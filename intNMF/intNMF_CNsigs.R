## intnmf

rm(list = ls())
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

library(IntNMF)
library(pheatmap)
library(dendextend)
source("../../../../other_repos/britroc-cnsignatures-bfb69cd72c50/main_functions.R")
source("../../../../other_repos/britroc-cnsignatures-bfb69cd72c50/helper_functions.R")
source("../../../../other_repos/Vias_Brenton/copy_number_analysis_organoids/helper_functions.R")
source("../../../../GlobalDA/code/2_inference_TMB/helper_TMB.R")

feat_sig_mat <- readRDS("../../../../other_repos/britroc-cnsignatures-bfb69cd72c50/data/feat_sig_mat.rds")
absolute_britroc <- readRDS("../../../../other_repos/britroc-cnsignatures-bfb69cd72c50/manuscript_Rmarkdown/data/britroc_absolute_copynumber.rds")
CN_components <- absolute_britroc <- readRDS("../../../../other_repos/britroc-cnsignatures-bfb69cd72c50/data/component_parameters.rds")

absolute_britroc <- readRDS("../data/")
absolute_britroc_TCGA <- readRDS("../data/PCAWG_ABSOLUTE_CN_profiles_TCGA_Names.rds")


pcawg_CN_features <- readRDS("../../../../other_repos/britroc-cnsignatures-bfb69cd72c50/manuscript_Rmarkdown/data/pcawg_CN_features.rds")

names_tcga <- sort(unique(absolute_britroc_TCGA$sample))
absolute_britroc_TCGA <- lapply(names_tcga, function(i) absolute_britroc_TCGA[absolute_britroc_TCGA$sample == i,])
names(absolute_britroc_TCGA) <- names_tcga
pcawg_CN_featuresbritroc <- extractCopynumberFeatures(absolute_britroc_TCGA)
pcawg_CN_featuresbritroc

## these components are for all three cohorts?

pcawg_sample_component_matrix<-generateSampleByComponentMatrix(pcawg_CN_features, CN_components)

View(pcawg_sample_component_matrix)

names_features <- unique(gsub("[0-9]+$", "", colnames(pcawg_sample_component_matrix)))
pcawg_sample_component_matrix_list <- lapply(names_features,
                                             function(i) pcawg_sample_component_matrix[,grepl(i, colnames(pcawg_sample_component_matrix))])
sapply(pcawg_sample_component_matrix_list, dim) ## max num of signatures is 2, as the second and third features have 3 components

pcawg_sample_component_matrix_list_norm <- lapply(pcawg_sample_component_matrix_list, function(i) sweep(i, 1, rowSums(i), '/'))
fit_pcawg <- IntNMF::nmf.mnnals(dat=pcawg_sample_component_matrix_list,k=2,maxiter=200,st.count=20,n.ini=15,ini.nndsvd=TRUE, seed=TRUE)
fit_pcawg_norm <- IntNMF::nmf.mnnals(dat=pcawg_sample_component_matrix_list_norm,k=2,maxiter=200,st.count=20,n.ini=15,ini.nndsvd=TRUE, seed=TRUE)
fit_pcawg_norm_fewerfeatures <- IntNMF::nmf.mnnals(dat=pcawg_sample_component_matrix_list_norm[-c(2,3)],k=2,maxiter=200,st.count=20,n.ini=15,ini.nndsvd=TRUE, seed=TRUE)
fit_pcawg_norm_fewerfeaturesk3 <- IntNMF::nmf.mnnals(dat=pcawg_sample_component_matrix_list_norm[-c(2,3)],k=3,maxiter=200,st.count=20,n.ini=15,ini.nndsvd=TRUE, seed=TRUE)
fit_pcawg_norm_fewerfeaturesk4 <- IntNMF::nmf.mnnals(dat=pcawg_sample_component_matrix_list_norm[-c(2,3)],k=4,maxiter=200,st.count=20,n.ini=15,ini.nndsvd=TRUE, seed=TRUE)
fit_pcawg_norm_fewerfeaturesk5 <- IntNMF::nmf.mnnals(dat=pcawg_sample_component_matrix_list_norm[-c(2,3)],k=5,maxiter=200,st.count=20,n.ini=15,ini.nndsvd=TRUE, seed=TRUE)
fit_pcawg_norm_fewerfeaturesk5notnorm <- IntNMF::nmf.mnnals(dat=pcawg_sample_component_matrix_list[-c(2,3)],k=5,maxiter=200,st.count=20,n.ini=15,ini.nndsvd=TRUE, seed=TRUE)
## 6 sigs is no longer possible
ConsensusMatPlot(fit_pcawg,rowLab=TRUE,colLab=TRUE)
ConsensusMatPlot(fit_pcawg_norm,rowLab=TRUE,colLab=TRUE)
ConsensusMatPlot(fit_pcawg_norm_fewerfeatures,rowLab=TRUE,colLab=TRUE)

pheatmap::pheatmap(fit_pcawg$W)
pheatmap::pheatmap(fit_pcawg$H$H1)
pheatmap::pheatmap(fit_pcawg$H$H2)
pheatmap::pheatmap(fit_pcawg$H$H3)
pheatmap::pheatmap(fit_pcawg$H$H4)
pheatmap::pheatmap(fit_pcawg$H$H5)
pheatmap::pheatmap(fit_pcawg$H$H6)

pheatmap::pheatmap(fit_pcawg_norm$W)
pheatmap::pheatmap(fit_pcawg_norm$H$H1)
pheatmap::pheatmap(fit_pcawg_norm$H$H2)
pheatmap::pheatmap(fit_pcawg_norm$H$H3)
pheatmap::pheatmap(fit_pcawg_norm$H$H4)
pheatmap::pheatmap(fit_pcawg_norm$H$H5)
pheatmap::pheatmap(fit_pcawg_norm$H$H6)

plot(fit_pcawg$W[,1], fit_pcawg_norm_fewerfeatures$W[,1]) ## when not using features #2 or #3
abline(coef = c(0,1), lty='dashed')

## compare the exposures from NatGen
sig_data = readRDS("../../../../other_repos/Vias_Brenton/copy_number_analysis_organoids/data/sig_data_unorm.RDS")
sig_data = cbind(sweep(sig_data[,1:7], 1, rowSums(sig_data[,1:7]), '/'),
                 sig_data[,8:ncol(sig_data)])
natgen <- as.matrix(sig_data[,1:7])
natgen_metadata <- sig_data[,8:10]
natgen_new_TCGA <- readRDS("../../../../other_repos/Vias_Brenton/copy_number_analysis_organoids/data/Export-matrix_OV_Sigs_on_TCGA-OV_12112019.rds")
natgen_metadata_newTCGA <- cbind.data.frame(study=rep('Updated TCGA', nrow(natgen_new_TCGA)), age=NA, age.cat=NA,
                                            stringsAsFactors = FALSE, row.names=rownames(natgen_new_TCGA))

#------------ Only keep TCGA samples which are of good enough quality------------#
summary_ascat = read.table("../../../../other_repos/Vias_Brenton/copy_number_analysis_organoids/data/summary.ascatTCGA.penalty70.txt",
                           header = TRUE, stringsAsFactors = FALSE)
good_tcga = summary_ascat$name[summary_ascat$dCIN]
good_tcga = good_tcga[!is.na(good_tcga)]
bool_tcga= lapply(natgen, function(i) grepl('TCGA', rownames(i)))
rm_na = function(df) !apply(df, 1, function(rw) all(is.na(rw)))

natgen_metadata <- natgen_metadata[!(grepl('TCGA', rownames(natgen_metadata)) & !( substr(rownames(natgen_metadata), 1, 12) %in% good_tcga)),]
natgen_metadata_newTCGA <- natgen_metadata_newTCGA[!(grepl('TCGA', rownames(natgen_metadata_newTCGA)) & !( rownames(natgen_metadata_newTCGA) %in% good_tcga)),]
natgen <- natgen[!(grepl('TCGA', rownames(natgen)) & !( substr(rownames(natgen), 1, 12) %in% good_tcga)),]
natgen_new_TCGA <- natgen_new_TCGA[!(grepl('TCGA', rownames(natgen_new_TCGA)) & !( rownames(natgen_new_TCGA) %in% good_tcga)),]
rownames(natgen_metadata_newTCGA) <- paste0('NewTCGA_', rownames(natgen_metadata_newTCGA))
rownames(natgen_new_TCGA) <- paste0('NewTCGA_', rownames(natgen_new_TCGA))

natgen <- rbind(natgen, natgen_new_TCGA)
natgen_metadata <- rbind(natgen_metadata, natgen_metadata_newTCGA)

rownames(natgen)[grepl("TCGA-13-0793", rownames(natgen))]
dim(natgen)

pairs(cbind(news1=fit_pcawg_norm$W[,1], natgen[match(rownames(fit_pcawg_norm$W), rownames(natgen)),]))
pairs(cbind(news2=fit_pcawg_norm$W[,2], natgen[match(rownames(fit_pcawg_norm$W), rownames(natgen)),]))
## the first signature is s4, s7. the second one is s1, s3
pdf("figures/two_clusters_ConsensusMatPlot_fit_pcawg_norm.pdf", onefile=FALSE)
ConsensusMatPlot(fit_pcawg_norm,rowLab=TRUE,colLab=TRUE)
dev.off()
image(fit_pcawg_norm$consensus)

## see if these are the two clusters of s3 and s4 from the organoids paper
pdf("figures/two_clusters_fit_pcawg_norm.pdf", height = 5, width = 3)
grid.arrange(createBarplot(natgen[names(fit_pcawg_norm$clusters)[fit_pcawg_norm$clusters == 1],], remove_labels = T),
             createBarplot(natgen[names(fit_pcawg_norm$clusters)[fit_pcawg_norm$clusters == 2],], remove_labels = T), nrow=2)
dev.off()
## indeed, these are the s3 and s4 clusters

## now the signatures in which we remove two of the features

## k =3
pairs(cbind.data.frame(newsigs=fit_pcawg_norm_fewerfeaturesk3$W, natgen[match(rownames(fit_pcawg_norm$W), rownames(natgen)),]))
## s2, s3 and s4 have equivalent signatures in the new ones of k=3

## k =4
pairs(cbind.data.frame(newsigs=fit_pcawg_norm_fewerfeaturesk4$W, natgen[match(rownames(fit_pcawg_norm$W), rownames(natgen)),]))
## s2, s3 s4 and s5 have equivalent signatures in the new ones of k=4

## k = 5
pairs(cbind.data.frame(newsigs=fit_pcawg_norm_fewerfeaturesk5$W, natgen[match(rownames(fit_pcawg_norm$W), rownames(natgen)),]))
## most sigs are present


#### what happens if we don't normalise?
par(mfrow=c(1,2))
rowSums(fit_pcawg_norm_fewerfeaturesk5$W) ## exposures don't add up to one: should we normalise?
image(fit_pcawg_norm_fewerfeaturesk5$W)           ## the exposures seem to be very different
image(fit_pcawg_norm_fewerfeaturesk5notnorm$W)    ## the exposures seem to be very different

rowSums(fit_pcawg_norm_fewerfeaturesk5$H$H2) ## even when we are comparing features of the same signature, the sum is not exactly the same
rowSums(fit_pcawg_norm_fewerfeaturesk5$H$H3)
pairs(sapply(fit_pcawg_norm_fewerfeaturesk5$H, rowSums))

## re-normalised exposures
image(fit_pcawg_norm_fewerfeaturesk5$W %*% diag(1/rowSums(sapply(fit_pcawg_norm_fewerfeaturesk5$H, rowSums))))
image(fit_pcawg_norm_fewerfeaturesk5notnorm$W %*% diag(1/rowSums(sapply(fit_pcawg_norm_fewerfeaturesk5notnorm$H, rowSums))))

## twice re-normalised exposures
dev.off()
normalised_exposures_norm <- normalise_rw(fit_pcawg_norm_fewerfeaturesk5$W %*% diag(1/rowSums(sapply(fit_pcawg_norm_fewerfeaturesk5$H, rowSums))))
par(mfrow=c(1,2))
image(normalised_exposures_norm)
image(normalise_rw(fit_pcawg_norm_fewerfeaturesk5notnorm$W %*% diag(1/rowSums(sapply(fit_pcawg_norm_fewerfeaturesk5notnorm$H, rowSums)))))
## reminder that signatures don't necessarily have to be in the same order

fit_pcawg_norm_fewerfeaturesk5notnorm$H$H4

pairs(cbind.data.frame(newsigs=normalised_exposures_norm, natgen[match(rownames(fit_pcawg_norm$W), rownames(natgen)),]))

##---------------------------------------------------------------------------------------------------------##
## compare signature exposures in several methods
change_column_paste <- function(mat_x, append){
  if(is.null( colnames(mat_x) ))  colnames(mat_x) <- paste0(1:ncol((mat_x)) )
  colnames(mat_x) <- paste(colnames(mat_x), append, sep = "_")
  mat_x
}

all_exposures <- cbind.data.frame(change_column_paste(natgen[match(rownames(fit_pcawg_norm$W), rownames(natgen)),], 'natgen'),
                                  change_column_paste(fit_pcawg$W, 'fit_pcawg'),
                 change_column_paste(fit_pcawg_norm$W, 'fit_pcawg_norm'),
                 change_column_paste(fit_pcawg_norm_fewerfeatures$W, 'fit_pcawg_norm_fewerfeatures'),
                 change_column_paste(fit_pcawg_norm_fewerfeaturesk3$W, 'fit_pcawg_norm_fewerfeaturesk3'),
                 change_column_paste(fit_pcawg_norm_fewerfeaturesk4$W, 'fit_pcawg_norm_fewerfeaturesk4'),
                 change_column_paste(fit_pcawg_norm_fewerfeaturesk5$W, 'fit_pcawg_norm_fewerfeaturesk5'),
                 change_column_paste(fit_pcawg_norm_fewerfeaturesk5notnorm$W, 'fit_pcawg_norm_fewerfeaturesk5notnorm'))

cor_all_exposures <- cor(all_exposures)
cor_all_exposures_hclust <- hclust(as.dist(cor_all_exposures))

pdf("figures/correlation_exposures_several_sig_extractions.pdf", height = 9, width = 9)
pheatmap(cor_all_exposures)
dev.off()

## compare the signature definitions of NatGen and current ones
fit_pcawg_norm$W

## correlation per feature
pdf("figures/correlation_several_sig_definitions.pdf", height = 9, width = 9)
normalised_features_sigs <- lapply(names_features, function(names_features_it){
  cat(names_features_it, '\n')
  if( !(names_features_it %in% names_features[-c(2,3)] ) ){
    .x <- cbind.data.frame(change_column_paste(normalise_rw(feat_sig_mat[grepl(names_features_it, rownames(feat_sig_mat)),]), 'natgen'),
                           change_column_paste(normalise_rw(t(fit_pcawg_norm$H[[which(names_features == names_features_it)]])), 'fit_pcawg_norm'))
    }else{
    .x <- cbind.data.frame(change_column_paste(normalise_rw(feat_sig_mat[grepl(names_features_it, rownames(feat_sig_mat)),]), 'natgen'),
                     change_column_paste(normalise_rw(t(fit_pcawg_norm$H[[which(names_features == names_features_it)]])), 'fit_pcawg_norm'),
                     change_column_paste(normalise_rw(t(fit_pcawg_norm_fewerfeatures$H[[which(names_features[-c(2,3)] == names_features_it)]])), 'fit_pcawg_norm_fewerfeatures'),
                     change_column_paste(normalise_rw(t(fit_pcawg_norm_fewerfeaturesk3$H[[which(names_features[-c(2,3)] == names_features_it)]])), 'fit_pcawg_norm_fewerfeaturesk3'),
                     change_column_paste(normalise_rw(t(fit_pcawg_norm_fewerfeaturesk4$H[[which(names_features[-c(2,3)] == names_features_it)]])), 'fit_pcawg_norm_fewerfeaturesk4'),
                     change_column_paste(normalise_rw(t(fit_pcawg_norm_fewerfeaturesk5$H[[which(names_features[-c(2,3)] == names_features_it)]])), 'fit_pcawg_norm_fewerfeaturesk5'),
                     change_column_paste(normalise_rw(t(fit_pcawg_norm_fewerfeaturesk5notnorm$H[[which(names_features[-c(2,3)] == names_features_it)]])),
                                         'fit_pcawg_norm_fewerfeaturesk5notnorm'))
    }
  cor_x <- as.dist(apply(cor(.x), 2, as.numeric))
  .a <- try(hclust(cor_x))
  if(typeof(.a) == "character"){
    ## error
    print(pheatmap(cor(.x), cluster_cols = F, cluster_rows = F, main = names_features_it))
  }else{
    print(pheatmap(cor(.x), main = names_features_it))
  }
  return(.x)
})
dev.off()

## correlation using all features

sapply(normalised_features_sigs, dim)

## fill empty entries in the cases of signatures with fewer features
for(i_fewer_features in which(sapply(normalised_features_sigs, dim)[2,] == 9)){
  match_cols <- match(colnames(normalised_features_sigs[[1]]),
        colnames(normalised_features_sigs[[i_fewer_features]]))
  normalised_features_sigs[[i_fewer_features]] <- sapply(match_cols, function(i) if(is.na(i)){rep(NA, nrow(normalised_features_sigs[[i_fewer_features]]))
    }else{normalised_features_sigs[[i_fewer_features]][,i]})
  colnames(normalised_features_sigs[[i_fewer_features]]) = colnames(normalised_features_sigs[[1]])
}

sapply(normalised_features_sigs, dim)

normalised_features_sigs_all <- do.call('rbind', normalised_features_sigs)

cor_normalised_features_sigs_all <- cor(na.omit(normalised_features_sigs_all))
cor_normalised_features_sigs_all_hclust <- hclust(as.dist(cor_normalised_features_sigs_all))

pdf("figures/correlation_joint_sig_definitions.pdf", height = 9, width = 9)
pheatmap(cor_normalised_features_sigs_all)
dev.off()

## tanglegram
dend_comparison_1 <- as.dendrogram (cor_normalised_features_sigs_all_hclust, title='adsd')
dend_comparison_2 <- as.dendrogram (cor_all_exposures_hclust)
pdf("figures/correlation_several_sig_definitions_exposures_tanglegram.pdf", height = 5, width = 7)
dendextend::tanglegram(dend_comparison_1, dend_comparison_2, main_left='Cor exposures', main_right='Cor sig defs',
                       columns_width=c(6,3,6), cex_main=2, lab.cex=1, highlight_distinct_edges=F, highlight_branches_lwd=F)
dev.off()


