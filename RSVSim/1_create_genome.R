# rm(list = ls())
# setwd(dirname(rstudioapi::getSourceEditorContext()$path))

library(RSVSim)

vignette('RSVSim')

## ------------------------------------------------------------------------------ ##

## create genome

genome = DNAStringSet(
  c("AAAAAAAAAAAAAAAAAAAATTTTTTTTTTTTTTTTTTTT",
    "GGGGGGGGGGGGGGGGGGGGCCCCCCCCCCCCCCCCCCCC",
    "GGGGGGGGGGGGGGAAGGGGGCCCCCCCCAACCCCCCCCCCC"))
length_chrom <- c(700, 600, 450)
nchrom <- length(length_chrom)
genome = DNAStringSet(
  sapply(1:nchrom, function(i) paste0(sample(c('A', 'C', 'G', 'T'),
                                             size = length_chrom[i], replace = T),
                                      collapse = ""))
)
genome

writeXStringSet(x = genome, filepath = "output/genome.fa")

## create BSGenome object
for(i in 1:length(genome)){
  writeXStringSet(x = genome[i], filepath = paste0("output/genome_per_chroms/", names(genome)[i], ".fa"))
}
system("/Users/morril01/anaconda3/pkgs/bwa-0.7.17-h2573ce8_7/bin/bwa index output/genome.fa")

library(CNSimGenome)
binSize <- 0.02 ##A numeric scalar specifying the width of the bins in units of kbp (1000 base pairs), e.g. binSize=15 corresponds to 15 kbp bins.
## if there is any problem creating this
## (check this first)
CNSimGenome@single_sequences
seqlengths(CNSimGenome)
## it's a problem with loading packages

bins_genome <- QDNAseq::createBins(CNSimGenome, binSize, ignoreMitochondria=TRUE, excludeSeqnames=NULL,
                    verbose=getOption("QDNAseq::verbose", TRUE))
saveRDS(bins_genome, "output/genome/bins_genome.RDS")

bins_genome02 <- QDNAseq::createBins(CNSimGenome, 0.2, ignoreMitochondria=TRUE, excludeSeqnames=NULL,
                                     verbose=getOption("QDNAseq::verbose", TRUE))
saveRDS(bins_genome02, "output/genome/bins_genome02.RDS")


forgeBSgenomeDataPkg("output/genome-seed.txt")
#' from command line:
#' R CMD build CNSimGenome/
#' R CMD check CNSimGenome_1.0.tar.gz 
#' R CMD INSTALL CNSimGenome_1.0.tar.gz 

