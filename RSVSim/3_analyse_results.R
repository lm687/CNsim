
library(optparse)

local=T

if(local){
  
  rm(list = ls())
  setwd(dirname(rstudioapi::getSourceEditorContext()$path))
  
  opt <- list()
  opt$sigset <- 'sigset1'
  
}else{
  
  option_list = list(
    make_option(c("--input_list"), type="character", default=NA,
                help="Text with small description of the type of simulation being carried out", metavar="character"),
    make_option(c("--sigset"), type="character", default=NA,
                help="set of signatures that we are using", metavar="character"),
    make_option(c("--genome"), type="character", default=NA,
                help="name of genome to use", metavar="character"));
  opt_parser = OptionParser(option_list=option_list);
  opt = parse_args(opt_parser);
}


sigset <- opt$sigset

system(paste0("mkdir -p ", sigset))

source("2_helper_functions.R")
source("../../../../other_repos/britroc-cnsignatures-bfb69cd72c50/main_functions.R")
source("../../../../other_repos/britroc-cnsignatures-bfb69cd72c50/helper_functions.R")
source("../../../../other_repos/britroc-cnsignatures-bfb69cd72c50/")

library(BSgenome)
library(RSVSim)
library(ComplexHeatmap)
library(pheatmap)
library(reshape2)
library(ggplot2)
library(flexmix)
library(NMF)

a <- list.files(paste0("output/output_genome2/outputRSVSim/", opt$sigset, "/"), full.names = T)
exposures <- list.files(paste0("exposures/", opt$sigset, "/"), full.names = T)
exposures_read <- sapply(exposures, read.table)
a_read <- lapply(opt$input_list, readRDS)

# a_read <- a_read[match(basename(exposures), gsub(".RDS", "", basename(a)))]
exposures <- exposures[match(gsub(".RDS", "", basename(a)), basename(exposures))]

exposures_read

a_read[[1]]


first_sig <- sapply(exposures_read, `[`, 1)
first_sig
hist(first_sig)

a_read

if(opt$genome == "genome2"){
  name_genome <- "output/genome2/genome2.fa"
}else{
  stop('Change genome\n')
}

genome <- readBStringSet(name_genome, format="fasta",
                         nrec=-1L, skip=0L, seek.first.rec=FALSE,
                         use.names=TRUE, with.qualities=FALSE)
genome <- rep(genome, 2)
names(genome) <- paste0(names(genome), rep(c('a', 'b'), each=length(genome)/2))

par(mfrow=c(1,1))
system(paste0("mkdir -p output/output_", opt$genome, "/outputRSVSim/figures/"))
pdf(paste0("output/output_", opt$genome, "/outputRSVSim/figures/", sigset, "_profiles.pdf"), height = 3, width = 5)
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
saveRDS(fmm, paste0("output/output_", opt$genome, "/direct_sigextraction/", sigset, "/sigextraction_fmm", ".RDS"))

lMats <- generateSampleByComponentMatrix_mod(CN_feature = features, all_components = fmm, feats=names(fmm))
saveRDS(lMats, paste0("output/output_", opt$genome, "/direct_sigextraction/", sigset, "/sigextraction_SxC", ".RDS"))

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
saveRDS(sigs, paste0("output/output_", opt$genome, "/direct_sigextraction/", sigset, "/sigextraction_optimalk_allfeats", ".RDS"))

image(sigs@consensus)
exposures_est <- coefficients(sigs)
signaturedef <- basis(sigs)
image(exposures_est)
## do we need to re-scale signatures??

# pairs(cbind(exposures_est[,1],
#       exposures_read[[1]])

data_cor_est_true <- cbind.data.frame(estimated_exposures=t(exposures_est),
                 true_exposures=do.call('rbind', exposures_read))

# pairs(data_cor_est_true,
#       # col=c(rep('blue', 3*ncol(exposures_est)/6), rep('red', 3*length(exposures_read)/6)))
#       col=rep(c('blue', 'red'), each=c(best_nsig*ncol(exposures_est)/6),  3*length(exposures_read)/6)
# )

head(data_cor_est_true)

est_mat <- data_cor_est_true[,grepl('estimated', colnames(data_cor_est_true))]
true_mat <- data_cor_est_true[,grepl('true', colnames(data_cor_est_true))]

cors_true_est_sig_exp <- outer(1:ncol(est_mat), 1:ncol(true_mat), Vectorize(function(i,j) cor(est_mat[,i],true_mat[,j])))
pheatmap::pheatmap(cors_true_est_sig_exp)

# recursively, match signatures one-to-one

## ------------------------------------------------------------------------------------------ ##
## ------------------------------------------------------------------------------------------ ##

## with fewer segments
for(feat in names(features)){
  lMats_fewerfeats <- generateSampleByComponentMatrix_mod(CN_feature = list(segsize=features[[feat]]),
                                                          all_components = fmm,
                                                          feats=c(feat))
  sigs_optimalk_fewerfeats <- chooseNumberSignatures(lMats_fewerfeats, iter=2, max_sig = 7)
  best_nsig_fewerfeats <- best_coph(sigs_optimalk_fewerfeats)
  
  saveRDS(list(lMats_fewerfeats=lMats_fewerfeats,
               sigs_optimalk_fewerfeats=sigs_optimalk_fewerfeats,
               best_nsig_fewerfeats=best_nsig_fewerfeats),
          paste0("output/output_", opt$genome, "/direct_sigextraction/", sigset, "/sigextraction_", feat, ".RDS"))

}


