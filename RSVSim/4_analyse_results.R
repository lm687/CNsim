## second part of analysing results, once signatures have been called

rm(list = ls())
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

local=T
if(local){
  opt = list()
  opt$sigset = "sigset1"
  a <- list.files(paste0("output/output_genome2/outputRSVSim/", opt$sigset, "/"), full.names = T)
  opt$input_list = a
  opt$genome = "genome2"
}

## read in results from FMM, signature extraction, simulated signatures, etc.

a <- list.files(paste0("output/output_genome2/outputRSVSim/", opt$sigset, "/"), full.names = T)
exposures <- list.files(paste0("exposures/", opt$sigset, "/"), full.names = T)
exposures_read <- sapply(exposures, read.table)
a_read <- lapply(opt$input_list, readRDS)

# a_read <- a_read[match(basename(exposures), gsub(".RDS", "", basename(a)))]
exposures <- exposures[match(gsub(".RDS", "", basename(a)), basename(exposures))]
exposures_true <- do.call('rbind', exposures_read)
colnames(exposures_true) <- paste0('true', 1:ncol(exposures_true))
## read in extracted signatures
sigs = readRDS( paste0("output/output_", opt$genome, "/direct_sigextraction/", opt$sigset, "/sigextraction_optimalk_allfeats", ".RDS"))

image(sigs@consensus)
exposures_est <- coefficients(sigs)
signaturedef <- basis(sigs)
image(exposures_est)
dim(signaturedef)
dim(exposures_est)

## do we need to re-scale signatures??
## re-scaling in a naive way (simply normalising)
exposures_est <- t(sweep(exposures_est, 2, colSums(exposures_est), '/'))
colnames(exposures_est) <- paste0('est', 1:ncol(exposures_est))


# pairs(cbind(exposures_est[,1],
#       exposures_read[[1]])

if(dim(signaturedef)[2] == 2){
  par(mfrow=c(2,3))
  plot(density(exposures_true[,1]), main='true#1', xlim=c(0,1))
  plot(density(exposures_true[,2]), main='true#2', xlim=c(0,1))
  plot(density(exposures_true[,3]), main='true#3', xlim=c(0,1))
  plot(density(exposures_est[,1]), main='est#1', xlim=c(0,1))
  plot(density(exposures_est[,2]), main='est#2', xlim=c(0,1))
  plot(density(exposures_est[,3]), main='est#3', xlim=c(0,1))
}

melt_exposures = melt(list(true_exp=exposures_true, est_exp=exposures_est))
melt_exposures$Var2 = paste0(melt_exposures$L1, '_', melt_exposures$Var2)
ggplot(melt_exposures,
       aes(x=value, col=L1))+geom_density()+facet_wrap(.~Var2)+theme_bw()
ggsave(paste0("output/output_", opt$genome, "/direct_sigextraction/", opt$sigset, "/density_true_est_sig_exp", ".pdf"), width = 9)

data_cor_est_true <- cbind.data.frame(estimated_exposures=exposures_est,
                                      true_exposures=exposures_true)

best_nsig = dim(signaturedef)[2]
pairs(data_cor_est_true
      # col=c(rep('blue', 3*ncol(exposures_est)/6), rep('red', 3*length(exposures_read)/6)))
      # col=rep(c('blue', 'red'), each=c(best_nsig*ncol(exposures_est)/6),  3*length(exposures_read)/6)
)

head(data_cor_est_true)

est_mat <- data_cor_est_true[,grepl('estimated', colnames(data_cor_est_true))]
true_mat <- data_cor_est_true[,grepl('true', colnames(data_cor_est_true))]

cors_true_est_sig_exp <- outer(1:ncol(est_mat), 1:ncol(true_mat), Vectorize(function(i,j) cor(est_mat[,i],true_mat[,j])))
rownames(cors_true_est_sig_exp) = paste0('est', 1:ncol(est_mat))
colnames(cors_true_est_sig_exp) = paste0('true', 1:ncol(true_mat))
cors_true_est_sig_exp
pdf(paste0("output/output_", opt$genome, "/direct_sigextraction/", opt$sigset, "/cors_true_est_sig_exp", ".pdf"))
print(pheatmap::pheatmap(cors_true_est_sig_exp, display_numbers=round(cors_true_est_sig_exp, 2)))
dev.off()

# recursively, match signatures one-to-one
current_cors_true_est_sig_exp <- cors_true_est_sig_exp
ct <- 1
matched_sigs <- list()
while(!is.null(dim(current_cors_true_est_sig_exp))){
  which_max_mod <-   which.max(current_cors_true_est_sig_exp)
  matched_sigs[[ct]] <- c(rownames(current_cors_true_est_sig_exp)[1+(which_max_mod %/% nrow(current_cors_true_est_sig_exp))],
                          colnames(current_cors_true_est_sig_exp)[1+(which_max_mod %% nrow(current_cors_true_est_sig_exp))])
  current_cors_true_est_sig_exp=current_cors_true_est_sig_exp[-match(matched_sigs[[ct]][1], rownames(current_cors_true_est_sig_exp)),
                                                              -match(matched_sigs[[ct]][2], colnames(current_cors_true_est_sig_exp))]
  
  ct <- ct+1
}
if(length(current_cors_true_est_sig_exp) > 1){
  ## if there is more than one signature left
  if(ncol(cors_true_est_sig_exp) > nrow(cors_true_est_sig_exp)){
    ## more true signatures than estimated
    matched_sigs[[ct]] = c(rownames(cors_true_est_sig_exp)[!(rownames(cors_true_est_sig_exp) %in% unlist(matched_sigs))],
                           names(which.max(current_cors_true_est_sig_exp)))
    for(j in names(current_cors_true_est_sig_exp)[!(names(current_cors_true_est_sig_exp)  %in% unlist(matched_sigs))]){
      ct <- ct+1
      matched_sigs[[ct]] <- c(NA, j)
    }
  }else{
    ## fewer true signatures than estimated
    matched_sigs[[ct]] = c(names(which.max(current_cors_true_est_sig_exp)),
                           colnames(cors_true_est_sig_exp)[!(colnames(cors_true_est_sig_exp) %in% unlist(matched_sigs))])
    for(j in names(current_cors_true_est_sig_exp)[!(names(current_cors_true_est_sig_exp)  %in% unlist(matched_sigs))]){
      ct <- ct+1
      matched_sigs[[ct]] <- c(j, NA)
    }
  }

}else{
  ## otherwise
  matched_sigs[[ct]] = c(rownames(cors_true_est_sig_exp)[!(rownames(cors_true_est_sig_exp) %in% unlist(matched_sigs))],
                           colnames(cors_true_est_sig_exp)[!(colnames(cors_true_est_sig_exp) %in% unlist(matched_sigs))])
}
matched_sigs

pdf(paste0("output/output_", opt$genome, "/direct_sigextraction/", opt$sigset, "/scatter_paired_true_est_sig_exp", ".pdf"))
lapply(matched_sigs, function(pair_it){
  plot(exposures_est[,pair_it[1]],
       exposures_true[,pair_it[2]], main=pair_it)
})
dev.off()


