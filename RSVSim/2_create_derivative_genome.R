# rm(list = ls())
# setwd(dirname(rstudioapi::getSourceEditorContext()$path))

library(BSgenome)
library(RSVSim)
library(optparse)
option_list = list(
  make_option(c("--name"), type="character", default=NA,
              help="name (uuid)", metavar="character"),
  make_option(c("--genome"), type="character", default=NA,
              help="name of genome to use", metavar="character"))
opt_parser = OptionParser(option_list=option_list);
opt = parse_args(opt_parser);

local = F
if(local){
  opt=list()
  opt$name = "dummyname"
  system("touch exposures/dummyname")
}

cat('Reading exposures - still to be implemented')
exposures <- readLines(paste0("exposures/", opt$name))

## ------------------------------------------------------------------------------ ##

if(opt$genome == 'genome'){
  name_genome <- "output/genome/genome.fa"
}else if(opt$genome == 'genome2'){
  name_genome <- "output/genome2/genome2.fa"
}

genome <- readBStringSet(name_genome, format="fasta",
                         nrec=-1L, skip=0L, seek.first.rec=FALSE,
                         use.names=TRUE, with.qualities=FALSE)

if(sum(sapply(names(genome), nchar)) == 0){
  names(genome) <- 1:length(genome)
}

## duplicate genome to make it diploid
genome <- rep(genome, 2)
names(genome) <- paste0(names(genome), c('a', 'b'))

genome

## deletions
sim_del = simulateSV(output=NA, genome=genome, dels=3, sizeDels=10,
                     bpSeqSize=6, verbose=FALSE)
sim_del

# metadata(sim)
# 
# ## insertions
sim_insert = simulateSV(output=NA, genome=sim_del, ins=3, sizeIns=5, bpSeqSize=6,
                        seed=246, verbose=FALSE)
# sim_insert
# metadata(sim)
# 
# ## multiple copies copied
# sim_multiplecopies = simulateSV(output=NA, genome=sim_insert, ins=3, sizeIns=5, percCopiedIns=0.66, bpSeqSize=6, seed=246, verbose=FALSE)
# 
# sim_multiplecopies
# 
# ## Inversions
# sim_inv = simulateSV(output=NA, genome=sim_multiplecopies, invs=3, sizeInvs=c(2,4,6),
#                      bpSeqSize=6, seed=456, verbose=FALSE)
# sim_inv
# 
# ## tandem dups
# sim_tandemdups = simulateSV(output=NA, genome=sim_inv, dups=1, sizeDups=6, maxDups=3,
#                             bpSeqSize=6, seed=3456, verbose=FALSE)
# sim_tandemdups
# 
# ## Translocations
# sim_transloc = simulateSV(output=NA, genome=sim_tandemdups,trans=1, bpSeqSize=6, seed=123, verbose=FALSE)
# sim_transloc
# 


## create reads and
## write them as fasta

sim_to_save <- DNAStringSet(sim_del)
## if using genome, it's just to double-check everything is okay when using the sequence without mutations
# sim_to_save <- DNAStringSet(genome)
sim_to_save <- DNAStringSet(sim_insert)

DNAStringSet(sim_del)
sim_del

nreads=200
length_read = 80
lengths_chroms <- sapply(sim_to_save, nchar)
lengths_chroms_norm <- lengths_chroms/sum(lengths_chroms)
give_reads <- function(){
  ## sample a chromosome with probability proportional to its size
  .chrom_selected <- sample(1:length(lengths_chroms_norm), size = 1, prob = lengths_chroms_norm)
  .start <- sample((1-length_read):(lengths_chroms[.chrom_selected]-1), size = 1)
  .read <- getSeq(sim_to_save, as(data.frame(chrom=names(sim_to_save)[.chrom_selected],
                                              start=max(.start, 1),
                                             end=min(lengths_chroms[.chrom_selected],
                                                     .start+(length_read-1))), "GRanges"))
  
  .read
}
reads <- replicate(nreads,  expr = give_reads(), simplify = T)

reads_c <- do.call('c', reads)

names(reads_c) = paste0('read', 1:length(reads_c))

# sim_transloc

system(paste0('mkdir -p output/output_', opt$genome))
system(paste0('mkdir -p output/output_', opt$genome, '/reads/'))

writeXStringSet(x = reads_c, filepath = paste0("output/output_", opt$genome, "/reads/sim_transloc_reads",
                                               opt$name, ".fa"))
# writeXStringSet(x = complement(reads_c), filepath = "output/sim_transloc_reads_complement.fa")

