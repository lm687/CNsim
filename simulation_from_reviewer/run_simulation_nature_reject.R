
## signature definitions
grid.arrange(ggplot(melt(f1, id.vars = "id"), aes(x=id, y=value, fill=variable, group=variable))+geom_histogram(alpha=0.2, stat = "identity")+
               facet_wrap(.~variable)+theme_bw(),
             ggplot(melt(f2, id.vars = "id"), aes(x=id, y=value, fill=variable, group=variable))+geom_histogram(alpha=0.2, stat = "identity")+
               facet_wrap(.~variable)+theme_bw(), nrow=2)

## get segment distributions
some_large_number <- 130
obs0 <- apply(exposures_true, 1, function(i){
  f1_obs <- rowSums(sapply(1:3, function(k){i[k]*rmultinom(n = 1, size = some_large_number, prob = f1[,k])}))
  f2_obs <- rowSums(sapply(1:3, function(k){i[k]*rmultinom(n = 1, size = some_large_number, prob = f2[,k])}))
  list(feature1=data.frame(f1_obs, id=f1$id),
       feature2=data.frame(f2_obs, id=f2$id))
})

obs <- melt(obs0,id.var='id')
head(obs)
ggplot((obs), aes(x=id, y=value))+geom_histogram(stat = "identity")+
  facet_wrap(.~L2)+theme_bw()+ggtitle('all samples')
ggplot((obs[obs$L1 < 6,]), aes(x=id, y=value))+geom_histogram(stat = "identity")+
  facet_wrap(.~interaction(L2, L1), ncol=2)+theme_bw()+ggtitle('first five samples')

## NMF: estimate signatures

##concantenate features

input_mat <- t(sapply(obs0, function(i) c(i[[1]][,1],i[[2]][,1])))
rownames(input_mat) <- paste0('sample', 1:nsamples)
colnames(input_mat) <- c(paste0('feature1_component', 1:length(f1s1)),
                         paste0('feature2_component', 1:length(f2s1)))
## I use a rank of three as it's the number of simulated signatures
nmf_res <- replicate(n = 100, NMF::nmf(x = t(as(input_mat, 'matrix')), rank = 3))
nmf_res[[1]] ## correct number of features, samples
nmf_res[[1]]@fit@W ## signature definitions
nmf_res[[1]]@fit@H ## weights (exposures)


sig_defs <- lapply(nmf_res, function(i) i@fit@W)
normalised_to_one_sig_defs <- lapply(sig_defs, function(i) sweep(i, 2, colSums(i), '/'))
normalised_sig_defs <- lapply(sig_defs, function(i) rbind(sweep(i[grep('feature1', rownames(i)),], 2,
                                                                colSums(i[grep('feature1', rownames(i)),]), '/'),
                                                          sweep(i[grep('feature2', rownames(i)),], 2,
                                                                colSums(i[grep('feature2', rownames(i)),]), '/')))
## how come the normalised exposures respect the weight of both features, making them equal?
colSums(normalised_to_one_sig_defs[[1]][grepl('feature1', rownames(normalised_to_one_sig_defs[[1]])),])
colSums(normalised_to_one_sig_defs[[1]][grepl('feature2', rownames(normalised_to_one_sig_defs[[1]])),])

## compare sig defs

pdf.options(reset = TRUE, onefile = FALSE)
pdf(paste0("figures/simulation_nature_reject_signature_recovery_prenormalisation_", append_name, ".pdf"))
print(grid.arrange(ggplot(melt(normalised_to_one_sig_defs[[1]]), aes(x=gsub("component", "", sub("^.*\\_", "", Var1)),
                                                                     y=value))+geom_histogram(stat = "identity")+labs(x="")+
                     facet_wrap(.~interaction(Var2, sub("_[^_]+$", "", Var1)), scales = "free_x", ncol=3)+theme_bw()+ggtitle('Estimated sigs'),
                   grid.arrange(ggplot(melt(f1, id.vars = "id"), aes(x=id, y=value, fill=variable, group=variable))+geom_histogram(alpha=0.2, stat = "identity")+
                                  facet_wrap(.~variable)+theme_bw()+guides(fill=FALSE)+ggtitle('True sigs'),
                                ggplot(melt(f2, id.vars = "id"), aes(x=id, y=value, fill=variable, group=variable))+geom_histogram(alpha=0.2, stat = "identity")+
                                  facet_wrap(.~variable)+theme_bw()+guides(fill=FALSE), nrow=2)))
dev.off()

pdf.options(reset = TRUE, onefile = FALSE)
pdf(paste0("figures/simulation_nature_reject_signature_recovery_postnormalisation_", append_name, ".pdf"))
print(grid.arrange(ggplot(melt(normalised_sig_defs[[1]]), aes(x=gsub("component", "", sub("^.*\\_", "", Var1)),
                                                              y=value))+geom_histogram(stat = "identity")+labs(x="")+
                     facet_wrap(.~interaction(Var2, sub("_[^_]+$", "", Var1)), scales = "free_x", ncol=3)+theme_bw()+ggtitle('Estimated sigs'),
                   grid.arrange(ggplot(melt(f1, id.vars = "id"), aes(x=id, y=value, fill=variable, group=variable))+geom_histogram(alpha=0.2, stat = "identity")+
                                  facet_wrap(.~variable)+theme_bw()+guides(fill=FALSE)+ggtitle('True sigs'),
                                ggplot(melt(f2, id.vars = "id"), aes(x=id, y=value, fill=variable, group=variable))+geom_histogram(alpha=0.2, stat = "identity")+
                                  facet_wrap(.~variable)+theme_bw()+guides(fill=FALSE), nrow=2)))
dev.off()

## cluster signature definitions accross replicates to get a consensus estimated signature set

## all sigs, 1:3, concantenated
normalised_to_one_sig_defs_concat <- do.call('cbind', normalised_to_one_sig_defs)
colnames(normalised_to_one_sig_defs_concat) <- rep(1:3, nsamples)
## add the true definitions HEREEEE f1, f2
normalised_to_one_sig_defs_concat
normalised_to_one_sig_defs_dist <- dist(t(normalised_to_one_sig_defs_concat))
normalised_to_one_sig_defs_hclust <- hclust(normalised_to_one_sig_defs_dist, method = "complete")
## we need to find the correspondence for each signature
clusters <- cutree(normalised_to_one_sig_defs_hclust, k = 3)
## see if, for each replicate we have one signature in each cluster
## select by three, which correspond to the same replicate
normalised_to_one_sig_defs_hclust$labels <- do.call('c', lapply(0:(length(nmf_res)-1), function(nrep_it){
  proposed_clusters <- clusters[(3*nrep_it + 1):(3*nrep_it + 3)]
  if(length(unique(proposed_clusters)) == 3){
    proposed_clusters
  }else{
    c(".", ".", ".")
  }
}))
plot(normalised_to_one_sig_defs_hclust, hang=-1)

pdf(paste0("figures/clustering_heatmap_signature_definitions_", append_name, ".pdf"))
pheatmap(normalised_to_one_sig_defs_dist) ## nice clustering into three. the blue dots indicate low distance/high similarity
dev.off()
normalised_to_one_sig_defs_hclust$height <- log10(normalised_to_one_sig_defs_hclust$height)
normalised_to_one_sig_defs_hclust$height <- normalised_to_one_sig_defs_hclust$height + 0.1 - min(normalised_to_one_sig_defs_hclust$height)
dend <- as.dendrogram(normalised_to_one_sig_defs_hclust, hang=-1)
d1=dendextend::color_branches(dend,col = c('#F08080', '#E9967A', '#CD5C5C')[as.numeric(labels(dend))])

dev.off()
pdf(paste0("figures/clustering_signature_definitions_", append_name, ".pdf"))
plot(d1 %>% hang.dendrogram(hang = -1) ) ## don't trust heights: they have been transformed for visualisation purposes
dev.off()
## very nice clustering

# so, signatures are the same. But what about exposures?
## they do, too
pdf(paste0("figures/comparison_exposures_", append_name, ".pdf"), height = 3)
par(mfrow=c(1,2))
image((nmf_res[[1]]@fit@H), main='Estimated exposures')
image(t(exposures_true), main='True exposures')
dev.off()
## not really

## what if we choose the optimal number of signatures instead?
k_vector <- 2:6
nmf_res_choosingk <- lapply(k_vector, function(k) NMF::nmf(x = t(as(input_mat, 'matrix')), rank = k))

which_optimal_k <- which.min(sapply(nmf_res_choosingk, function(i) i@residuals))
optimal_k <- k_vector[which_optimal_k]
sig_defs_optimalk <- nmf_res_choosingk[[which_optimal_k]]@fit@W
normalised_to_one_sig_defs_optimalk <- sweep(sig_defs_optimalk, 2, colSums(sig_defs_optimalk), '/')

normalised_to_one_sig_defs_optimalk_melt <- melt(normalised_to_one_sig_defs_optimalk)
normalised_to_one_sig_defs_optimalk_melt$Var1cropped <- sub("_[^_]+$", "", normalised_to_one_sig_defs_optimalk_melt$Var1)
normalised_to_one_sig_defs_optimalk_sum <- normalised_to_one_sig_defs_optimalk_melt %>%
  dplyr::group_by(Var2, Var1cropped) %>% dplyr::summarise(sum=sum(value))
# normalised_to_one_sig_defs_optimalk_sum$Var1cropped = "1"
normalised_to_one_sig_defs_optimalk_sum$Var1 = "1"
normalised_to_one_sig_defs_optimalk_sum$value = Inf
normalised_to_one_sig_defs_optimalk_sum$sum = round(normalised_to_one_sig_defs_optimalk_sum$sum, 3)

pdf.options(reset = TRUE, onefile = FALSE)
pdf(paste0("figures/simulation_nature_reject_signature_recovery_optimalk_postnormalisation_", append_name, ".pdf"))
print(grid.arrange(ggplot(normalised_to_one_sig_defs_optimalk_melt, aes(x=gsub("component", "", sub("^.*\\_", "", Var1)),
                                                              y=value))+geom_histogram(stat = "identity")+labs(x="")+
                     geom_text(data = normalised_to_one_sig_defs_optimalk_sum, aes(label=sum),
                               col='red', size=3,hjust=-0.3, vjust=1.8, angle=00)+
                     facet_wrap(.~interaction(Var2, Var1cropped), scales = "free_x", ncol=ncol(normalised_to_one_sig_defs_optimalk))+theme_bw()+ggtitle('Estimated sigs'),
                   grid.arrange(ggplot(melt(f1, id.vars = "id"), aes(x=id, y=value, fill=variable, group=variable))+geom_histogram(alpha=0.2, stat = "identity")+
                                  facet_wrap(.~variable)+theme_bw()+guides(fill=FALSE)+ggtitle('True sigs'),
                                ggplot(melt(f2, id.vars = "id"), aes(x=id, y=value, fill=variable, group=variable))+geom_histogram(alpha=0.2, stat = "identity")+
                                  facet_wrap(.~variable)+theme_bw()+guides(fill=FALSE), nrow=2)))
dev.off()


## intNMF
# feature_names <- unique(gsub("_.*", "", colnames(input_mat)))
# input_intNMF <- lapply(feature_names, function(i) input_mat[,grepl(i, colnames(input_mat))])
# names(input_intNMF) <- c(feature_names)
# fit_pcawg_norm <- IntNMF::nmf.mnnals(dat=input_intNMF,k=2, #min(sapply(input_intNMF, dim)[2,]) -1,
#                                      maxiter=200,st.count=20,n.ini=15,ini.nndsvd=TRUE, seed=TRUE)


save.image(file = paste0("cached_images/image_", append_name, ".RData"))
