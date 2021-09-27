# rm(list = ls())
# setwd(dirname(rstudioapi::getSourceEditorContext()$path))

library(BSgenome)
library(BSgenome.Hsapiens.UCSC.hg19)
library(RSVSim)

## ------------------------------------------------------------------------------ ##
genome0 <- BSgenome::getSeq(BSgenome.Hsapiens.UCSC.hg19)
genome <- genome0[c('chr5', 'chr6')]
# genome <- (c(BSgenome.Hsapiens.UCSC.hg19$chr5,
#              BSgenome.Hsapiens.UCSC.hg19$chr6))

## deletions
sim_del = simulateSV(output=NA, genome=genome, dels=3, sizeDels=10,
                     bpSeqSize=6, seed=456, verbose=FALSE)
sim_del

metadata(sim)

## insertions
sim_insert = simulateSV(output=NA, genome=sim_del, ins=3, sizeIns=5, bpSeqSize=6,
                        seed=246, verbose=FALSE)
sim_insert
metadata(sim)

## multiple copies copied
sim_multiplecopies = simulateSV(output=NA, genome=sim_insert, ins=3, sizeIns=5, percCopiedIns=0.66, bpSeqSize=6, seed=246, verbose=FALSE)

sim_multiplecopies

## Inversions
sim_inv = simulateSV(output=NA, genome=sim_multiplecopies, invs=3, sizeInvs=c(2,4,6),
                     bpSeqSize=6, seed=456, verbose=FALSE)
sim_inv

## tandem dups
sim_tandemdups = simulateSV(output=NA, genome=sim_inv, dups=1, sizeDups=6, maxDups=3,
                            bpSeqSize=6, seed=3456, verbose=FALSE)
sim_tandemdups

## Translocations
sim_transloc = simulateSV(output=NA, genome=sim_tandemdups,trans=1, bpSeqSize=6, seed=123, verbose=FALSE)
sim_transloc

## of using genome, it's just to double-check everything is okay when using the sequence without mutations
sim_to_save <- DNAStringSet(sim_del)
# sim_to_save <- DNAStringSet(genome)

DNAStringSet(sim_del)
sim_del

nreads=1000
length_read = 8
lengths_chroms <- sapply(sim_to_save, nchar)
lengths_chroms_norm <- lengths_chroms/sum(lengths_chroms)
give_reads <- function(){
  ## sample a chromosome with probability proportional to its size
  .chrom_selected <- sample(1:length(lengths_chroms_norm), size = 1, prob = lengths_chroms_norm)
  .start <- sample(1:(lengths_chroms[.chrom_selected]-length_read), size = 1)
  .read <- getSeq(sim_to_save, as(data.frame(chrom=names(sim_to_save)[.chrom_selected],
                                             start=.start, end=.start+(length_read-1)), "GRanges"))
  
  .read
}
reads <- replicate(nreads,  expr = give_reads(), simplify = T)

reads_c <- do.call('c', reads)

names(reads_c) = paste0('read', 1:length(reads_c))

sim_transloc

writeXStringSet(x = reads_c, filepath = "output/sim_transloc_reads_hg19.fa")
writeXStringSet(x = complement(reads_c), filepath = "output/sim_transloc_reads_complement_hg19.fa")


