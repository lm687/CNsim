rm(list = ls())
setwd(dirname(rstudioapi::getSourceEditorContext()$path))
source("2_helper_functions.R")
source("../../../../other_repos/britroc-cnsignatures-bfb69cd72c50/main_functions.R")
source("../../../../other_repos/britroc-cnsignatures-bfb69cd72c50/helper_functions.R")
source("../../../../other_repos/britroc-cnsignatures-bfb69cd72c50/")

library(BSgenome)
library(RSVSim)
library(reshape2)
library(ggplot2)
library(flexmix)
library(NMF)

sigset <- 'sigset1'
a <- list.files("output/output_genome2/outputRSVSim/sigset1/", full.names = T)
exposures <- list.files("exposures/sigset1/", full.names = T)
exposures_read <- sapply(exposures, read.table)
a_read <- lapply(a, readRDS)

# a_read <- a_read[match(basename(exposures), gsub(".RDS", "", basename(a)))]
exposures <- exposures[match(gsub(".RDS", "", basename(a)), basename(exposures))]


exposures_read

a_read[[1]]


first_sig <- sapply(exposures_read, `[`, 1)
first_sig
hist(first_sig)

a_read


name_genome <- "output/genome2/genome2.fa"
genome <- readBStringSet(name_genome, format="fasta",
                         nrec=-1L, skip=0L, seek.first.rec=FALSE,
                         use.names=TRUE, with.qualities=FALSE)
genome <- rep(genome, 2)
names(genome) <- paste0(names(genome), rep(c('a', 'b'), each=length(genome)/2))

par(mfrow=c(1,1))
system("mkdir -p output/output_genome2/outputRSVSim/figures/")
pdf(paste0("output/output_genome2/outputRSVSim/figures/", sigset, "_profiles.pdf"), height = 3, width = 5)
for(j in 1:length(a_read)){
  # plot_from_hash(a_read[j], main=j)
  # sapply(a_read[j], plot_from_hash, main=j)
  print(plot_sim_genome(plot_from_hash_2(a_read[[j]]))+ggtitle(basename(a)[j]))
}
dev.off()


segments <- lapply(a_read, function(i) get_segments(plot_from_hash_2(i)))
segments_rbind <- do.call('rbind', segments)
segments_rbind$sample <- rep(1:length(segments), sapply(segments, nrow))
segments_rbind_no2 <- segments_rbind[segments_rbind$cn != 2,]
## summarise segments and get mixture models
## do I need to remove the segments with cn=2?

segment_length <- segments_rbind_no2$end - segments_rbind_no2$start

CN_changepoint <- lapply(unique(segments_rbind$sample), function(sample_it){
  do.call('c', sapply(unique(segments_rbind$chromosome), function(chrom_it){
    .x <- segments_rbind[segments_rbind$sample == sample_it &
                           segments_rbind$chromosome == chrom_it,]
    abs(.x[-1,'cn']-.x[-nrow(.x),'cn'])}))
})
CN_changepoint_unlist <- unlist(CN_changepoint)

par(mfrow=c(1,2))
plot(density(segment_length), main='Segment length')
plot(density(CN_changepoint_unlist), main='CN changepoint')
table(CN_changepoint_unlist == 0)

# extractfe
# flexmix::flexmix(formula = segment_length~1, data=data.frame(segments=segment_length), k = 2)
# segment_length
# CN_changepoint_unlist

names(segments) <- gsub(".RDS", "", basename(a))
features <- extractCopynumberFeatures_mod(segments)

if(sum(features$changepoint[,2] == 0) > 0){stop('I do not think there should be changepoints of 0,\
because those are not changepoints')}

features$changepoint[features$changepoint[,2] == 0,]

getChangepointCN(segments)

# #----------------------------------------------------------------------------------------------------------------
# #----------------------------------------------------------------------------------------------------------------
# abs_profiles <- segments
# out<-c()
# samps<-getSampNames(abs_profiles)
# for(i in samps)
# {
#   if(class(abs_profiles)=="QDNAseqCopyNumbers")
#   {
#     segTab<-getSegTable(abs_profiles[,which(colnames(abs_profiles)==i)])
#   }
#   else
#   {
#     segTab<-abs_profiles[[i]]
#     colnames(segTab)[4]<-"segVal"
#   }
#   segTab$segVal[as.numeric(segTab$segVal)<0]<-0
#   chrs<-unique(segTab$chromosome)
#   allcp<-c()
#   for(c in chrs)
#   {
#     currseg<-as.numeric(segTab[segTab$chromosome==c,"segVal"])
#     allcp<-c(allcp,abs(currseg[-1]-currseg[-length(currseg)]))
#   }
#   if(length(allcp)==0)
#   {
#     allcp<-0 #if there are no changepoints
#   }
#   out<-rbind(out,cbind(ID=rep(i,length(allcp)),value=allcp))
# }
# rownames(out)<-NULL
# data.frame(out,stringsAsFactors = F)
# }
# <bytecode: 0x7f9f72a014d8>
# 
# #----------------------------------------------------------------------------------------------------------------
# #----------------------------------------------------------------------------------------------------------------

ggplot(melt(features), aes(x=value))+geom_density()+facet_wrap(.~L1)

table(features$osCN$value) ## good
table(features$copynumber$value) ## good
table(features$segsize$value) ## good
table(features$changepoint$value) ## good

fmm <- fitMixtureModels_mod(features)
# fmm <- fitMixtureModels(features, featsToFit = c(1, 2, 5))

lMats <- generateSampleByComponentMatrix_mod(CN_feature = features, all_components = fmm, feats=names(fmm))

## need to find optimal number of signatures

sigs_optimalk <- chooseNumberSignatures(lMats, iter=2, max_sig = 7)
## select based on cophenetic idx
best_coph <- function(opt_res){
  .x <- (opt_res$data[opt_res$data$variable == 'cophenetic',])
  .x <- .x[order(.x$value, decreasing = T),]
  .x[1,'rank']
}
best_nsig <- best_coph(sigs_optimalk)

sigs <- generateSignatures_mod(lMats, nsig = best_nsig, nrun=2)
image(sigs@consensus)
exposures_est <- coefficients(sigs)
signaturedef <- basis(sigs)
image(exposures_est)
## do we need to re-scale signatures??

# pairs(cbind(exposures_est[,1],
#       exposures_read[[1]])

data_cor_est_true <- cbind.data.frame(estimated_exposures=t(exposures_est),
                 true_exposures=do.call('rbind', exposures_read))

pairs(data_cor_est_true,
      # col=c(rep('blue', 3*ncol(exposures_est)/6), rep('red', 3*length(exposures_read)/6)))
      col=rep(c('blue', 'red'), each=c(best_nsig*ncol(exposures_est)/6),  3*length(exposures_read)/6)
)

head(data_cor_est_true)

est_mat <- data_cor_est_true[,grepl('estimated', colnames(data_cor_est_true))]
true_mat <- data_cor_est_true[,grepl('true', colnames(data_cor_est_true))]

cors_true_est_sig_exp <- outer(1:ncol(est_mat), 1:ncol(true_mat), Vectorize(function(i,j) cor(est_mat[,i],true_mat[,j])))
pheatmap::pheatmap(cors_true_est_sig_exp)

# recursively, match signatures one-to-one

## ------------------------------------------------------------------------------------------ ##
## ------------------------------------------------------------------------------------------ ##

## with fewer segments
lMats_fewerfeats <- generateSampleByComponentMatrix_mod(CN_feature = list(segsize=features$segsize),
                                                        # all_components = list(segsize=fmm$segsize),
                                                        all_components = fmm,
                                                        feats=c("segsize"))
sigs_optimalk_fewerfeats <- chooseNumberSignatures(lMats_fewerfeats, iter=2, max_sig = 7)
best_nsig_fewerfeats <- best_coph(sigs_optimalk_fewerfeats)


generateSampleByComponentMatrix_mod



