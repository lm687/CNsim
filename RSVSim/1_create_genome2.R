# rm(list = ls())
# setwd(dirname(rstudioapi::getSourceEditorContext()$path))

## second genome: longer, and with four chromosomes

library(RSVSim)
library(BSgenome)

vignette('RSVSim')

## ------------------------------------------------------------------------------ ##

## create genome
length_chrom <- c(7000, 6000, 4500, 2000)
nchrom <- length(length_chrom)
genome = DNAStringSet(
  sapply(1:nchrom, function(i) paste0(sample(c('A', 'C', 'G', 'T'),
                                             size = length_chrom[i], replace = T),
                                      collapse = ""))
)
genome
names(genome) <- 1:length(genome)

writeXStringSet(x = genome, filepath = "output/genome2/genome2.fa")

system("mkdir output/genome2/genome_per_chroms/")
## create BSGenome object
for(i in 1:length(genome)){
  # writeXStringSet(x = genome[i], filepath = paste0("output/genome_per_chroms/genome2/", names(genome)[i], ".fa"))
  writeXStringSet(x = genome[i], filepath = paste0("output/genome2/genome_per_chroms/chr", i, ".fa"))
}

system("/Users/morril01/anaconda3/pkgs/bwa-0.7.17-h2573ce8_7/bin/bwa index output/genome2/genome2.fa")

## create the genomee
BSgenome::forgeBSgenomeDataPkg("output/genome2/genome2-seed.txt")
system("R CMD build CNSimGenome2/")
system("R CMD check CNSimGenome2_1.0.tar.gz")
system("R CMD INSTALL CNSimGenome2_1.0.tar.gz")

library(CNSimGenome2)
binSize <- 0.02 ##A numeric scalar specifying the width of the bins in units of kbp (1000 base pairs), e.g. binSize=15 corresponds to 15 kbp bins.
## if there is any problem creating this
## (check this first)
CNSimGenome2@single_sequences
seqlengths(CNSimGenome2)
## it's a problem with loading packages

bins_genome <- QDNAseq::createBins(CNSimGenome2, binSize, ignoreMitochondria=TRUE, excludeSeqnames=NULL,
                                   verbose=getOption("QDNAseq::verbose", TRUE))
saveRDS(bins_genome, "output/genome2/bins_genome.RDS")

bins_genome02 <- QDNAseq::createBins(CNSimGenome2, 0.2, ignoreMitochondria=TRUE, excludeSeqnames=NULL,
                                     verbose=getOption("QDNAseq::verbose", TRUE))
saveRDS(bins_genome02, "output/genome2/bins_genome02.RDS")

bins_genome02 <- QDNAseq::createBins(CNSimGenome2, 0.002, ignoreMitochondria=TRUE, excludeSeqnames=NULL,
                                     verbose=getOption("QDNAseq::verbose", TRUE))
saveRDS(bins_genome02, "output/genome2/bins_genome0002.RDS")
