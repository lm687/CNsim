# rm(list = ls())
# setwd(dirname(rstudioapi::getSourceEditorContext()$path))

## third genome: longer than genome3, and with four chromosomes as well

library(RSVSim)
library(BSgenome)

vignette('RSVSim')

## ------------------------------------------------------------------------------ ##

## create genome
length_chrom <- c(15000, 10000, 7500, 6000)
nchrom <- length(length_chrom)
genome = DNAStringSet(
  sapply(1:nchrom, function(i) paste0(sample(c('A', 'C', 'G', 'T'),
                                             size = length_chrom[i], replace = T),
                                      collapse = ""))
)
genome
names(genome) <- 1:length(genome)

system(paste0("mkdir -p ", "output/genome3/"))
system(paste0("mkdir -p ", "output/genome3/genome_per_chroms/"))
writeXStringSet(x = genome, filepath = "output/genome3/genome3.fa")

system("mkdir output/genome3/genome_per_chroms/")
## create BSGenome object
for(i in 1:length(genome)){
  # writeXStringSet(x = genome[i], filepath = paste0("output/genome_per_chroms/genome3/", names(genome)[i], ".fa"))
  writeXStringSet(x = genome[i], filepath = paste0("output/genome3/genome_per_chroms/chr", i, ".fa"))
}

system("/Users/morril01/anaconda3/pkgs/bwa-0.7.17-h2573ce8_7/bin/bwa index output/genome3/genome3.fa")

## create the genomee
BSgenome::forgeBSgenomeDataPkg("output/genome3/genome3-seed.txt")
system("R CMD build CNSimgenome3/")
system("R CMD check CNSimgenome3_1.0.tar.gz")
system("R CMD INSTALL CNSimgenome3_1.0.tar.gz")

# library(CNSimgenome3)
library(CNSimGenome3)
binSize <- 0.02 ##A numeric scalar specifying the width of the bins in units of kbp (1000 base pairs), e.g. binSize=15 corresponds to 15 kbp bins.
## if there is any problem creating this
## (check this first)
CNSimGenome3@single_sequences
seqlengths(CNSimGenome3)
## it's a problem with loading packages

bins_genome <- QDNAseq::createBins(CNSimGenome3, binSize, ignoreMitochondria=TRUE, excludeSeqnames=NULL,
                                   verbose=getOption("QDNAseq::verbose", TRUE))
saveRDS(bins_genome, "output/genome3/bins_genome.RDS")

bins_genome02 <- QDNAseq::createBins(CNSimGenome3, 0.2, ignoreMitochondria=TRUE, excludeSeqnames=NULL,
                                     verbose=getOption("QDNAseq::verbose", TRUE))
saveRDS(bins_genome02, "output/genome3/bins_genome02.RDS")

