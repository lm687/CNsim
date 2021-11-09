
##' Lena M, 20211109
##' 
##' This script simulates CN values of a derivative genome by using the function simulateSV() once.
##'  The function allows for multiple CN changes. However, if it's used sequentially multiple times,
##'  then the code needs to be changed (for e.g. WGD, I can't think of a way of simulating data without running
##'  simulateSV once, then duplicating the derivative chromosomes, then running simulateSV again to add CN
##'  on top).
##'  
##'  To do:
##'   - add insertions

rm(list = ls())
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

library(BSgenome)
library(RSVSim)
# library(optparse)

name_genome <- "output/genome2/genome2.fa"

genome <- readBStringSet(name_genome, format="fasta",
                         nrec=-1L, skip=0L, seek.first.rec=FALSE,
                         use.names=TRUE, with.qualities=FALSE)
## make genome diploid
genome <- rep(genome, 2)
names(genome) <- paste0(names(genome), rep(c('a', 'b'), each=length(genome)/2))

sim_wrapper <- function(...){
  ## make changes to the genome
  many_changes <- simulateSV(...)
  
  ## initialise
  genome_changing <- genome
  
  ## Add "-" in nucleotides of deletions
  for(i_del in 1:nrow(many_changes@metadata$deletions)){
    chrom_in_change <- strsplit(as.character(genome_changing[[many_changes@metadata$deletions$Chr[i_del]]]), '')[[1]]
    chrom_in_change[many_changes@metadata$deletions$Start[i_del]:many_changes@metadata$deletions$End[i_del]] <- '-'
    genome_changing[[many_changes@metadata$deletions$Chr[i_del]]] <- BString(paste0(chrom_in_change, collapse = ""))
  }
  for(i_dup in 1:nrow(many_changes@metadata$tandemDuplications)){
    ## need to sort how insertions work    
    chrom_in_change <- strsplit(as.character(genome_changing[[many_changes@metadata$tandemDuplications$Chr[i_dup]]]), '')[[1]]
    chrom_in_change[1:many_changes@metadata$tandemDuplications$Start[i_dup]] <- '-'
    chrom_in_change[many_changes@metadata$tandemDuplications$End[i_dup]:width(genome_changing[many_changes@metadata$tandemDuplications$Chr[i_dup]])] <- '-'
    chrom_in_change <- BString(paste0(chrom_in_change, collapse = ""))
    for(i_td_dups in 1:many_changes@metadata$tandemDuplications$Duplications[i_dup]){
      ## many tandem duplications
      genome_changing[[paste0(many_changes@metadata$tandemDuplications$Chr[i_dup], '_', i_dup, '_', i_td_dups)]] <- chrom_in_change
    }
  }
  ## Create "additional chromosomes" of inserted regions
  # for(i_ins in 1:nrow(many_changes@metadata$insertions)){
  #   ## need to sort how insertions work    
  #   chrom_in_change <- strsplit(as.character(genome_changing[[many_changes@metadata$insertions$Chr[i_ins]]]), '')[[1]]
  #   chrom_in_change[1:many_changes@metadata$insertions$Start[i_ins]] <- '-'
  #   chrom_in_change[many_changes@metadata$insertions$End[i_ins]:width(genome_changing[many_changes@metadata$insertions$Chr[i_ins]])] <- '-'
  #   chrom_in_change <- BString(paste0(chrom_in_change, collapse = ""))
  #   genome_changing[[paste0(many_changes@metadata$insertions$Chr[i_ins], '_', i_ins)]] <- chrom_in_change
  #   
  # }
  
  ## now select the chromosomes that are homologous
  chroms_final <- sapply(names(genome_changing), function(i) strsplit(i, '[a-z]')[[1]][1])
  chroms_final_idx <- sapply(unique(chroms_final), function(i) which(chroms_final == i))
  
  ## get true ploidies
  true_ploidies_sim <- lapply(1:length(chroms_final_idx), function(idx_chroms_final){
    splt_chrom_it <- sapply(genome_changing[chroms_final_idx[[idx_chroms_final]]], function(i) strsplit(as.character(i), '')[[1]])
    original_genome <- strsplit(as.character(genome[names(chroms_final[chroms_final_idx[[idx_chroms_final]]][1])]), '')[[1]]
    splt_chrom_it_match <- apply(splt_chrom_it, 2, function(i) i==original_genome)
    true_ploidy <- rowSums(splt_chrom_it_match)
    true_ploidy
  })
  
  true_ploidies_sim_df <- lapply(1:length(true_ploidies_sim), function(i) cbind.data.frame(cn=true_ploidies_sim[[i]],
                                                                                           position=1:length(true_ploidies_sim[[i]])))
  names(true_ploidies_sim_df) <- names(chroms_final_idx)
  
  return(true_ploidies_sim_df)
}

true_ploidies_sim_df_example <- sim_wrapper(dels = 10, ins = 20, dups = 20, genome = genome, output = NA,
                                            sizeDels = 500, sizeDups = 30)
true_ploidies_sim_df_example <- melt(true_ploidies_sim_df_example, id.vars=c('cn', 'position'))

table(true_ploidies_sim_df_example$cn)

ggplot(true_ploidies_sim_df_example, aes(x=position, xend=position+1, y=cn, yend=cn))+
  geom_hline(yintercept = 2, lty='dashed', col='blue')+
  geom_step()+facet_wrap(.~L1, scales = "free_x")+theme_bw()

true_ploidies_sim_df_example2 <- sim_wrapper(dels = 10, ins = 20, dups = 20, genome = genome, output = NA,
                                            sizeDels = 500, sizeDups = 300)
true_ploidies_sim_df_example2 <- melt(true_ploidies_sim_df_example2, id.vars=c('cn', 'position'))
ggplot(true_ploidies_sim_df_example2, aes(x=position, xend=position+1, y=cn, yend=cn))+
  geom_hline(yintercept = 2, lty='dashed', col='blue')+
  geom_step()+facet_wrap(.~L1, scales = "free_x")+theme_bw()


