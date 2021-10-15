
library(BSgenome)
library(RSVSim)
library(optparse)

local = F

if(local){
  rm(list = ls())
  setwd(dirname(rstudioapi::getSourceEditorContext()$path))
  opt=list()
  opt$name = "dummyname"
  opt$genome = "genome2"
  opt$purity= 0.8
  opt$size_deletion = 200
  opt$nreads = 9000
  system("touch exposures/dummyname")
}else{
  option_list = list(
    make_option(c("--name"), type="character", default=NA,
                help="name (uuid)", metavar="character"),
    make_option(c("--genome"), type="character", default=NA,
                help="name of genome to use", metavar="character"),
    make_option(c("--purity"), type="double", default=0.8,
                help="purity, or fraction [0-1] of reads that come from tumour genome",
                metavar="double"),
    make_option(c("--size_deletion"), type="double", default=200,
                help="size of the deletion, in bp",
                metavar="double"),
    make_option(c("--nreads"), type="double", default=4000,
                help="number of reads",
                metavar="double"))
  opt_parser = OptionParser(option_list=option_list);
  opt = parse_args(opt_parser);
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
names(genome) <- paste0(names(genome), rep(c('a', 'b'), each=length(genome)/2))


## deletions
# sim_del = simulateSV(output=NA, genome=genome, dels=1, sizeDels=opt$size_deletion,
#                      verbose=FALSE)

sim_del = simulateSV(output=NA, genome=genome, dels=1, sizeDels=opt$size_deletion,
                     verbose=FALSE)

# sim_del <- genome
# sim_del[1] <-   Biostrings::substr(sim_del[1], 2000, nchar(sim_del[1]))
# sim_del[5] <-   Biostrings::substr(sim_del[1], 2000, nchar(sim_del[1]))

sim_to_save_BS <- sim_del
sim_to_save <- DNAStringSet(sim_to_save_BS)
saveRDS(sim_to_save_BS, paste0("output/output_", opt$genome, "/reads/", opt$name, "derivative_genome.RDS"))

# for(j in 1:20){
#   .sim_del = simulateSV(output=NA, genome=sim_del, dels=1, sizeDels=opt$size_deletion,
#                        verbose=FALSE)
#   sim_del <- .sim_del
# }
# sim_del@metadata

# rbind(strsplit(as.character(sim_del[1]), '')[[1]], strsplit(as.character(sim_del[5]), '')[[1]],)
# sim_del@metadata
# 
# sim_del

# metadata(sim)
# 
# ## insertions
# sim_insert = simulateSV(output=NA, genome=sim_del, ins=30, sizeIns=50, bpSeqSize=6,
#                         seed=246, verbose=FALSE)
# 
# sim_insert <- sim_del
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

## if using genome, it's just to double-check everything is okay when using the sequence without mutations
# sim_to_save <- DNAStringSet(genome)
# sim_to_save <- DNAStringSet(sim_insert)

sim_to_save

nreads=opt$nreads
length_read = 150
lengths_chroms <- sapply(sim_to_save, nchar)
lengths_chroms_norm <- lengths_chroms/sum(lengths_chroms)

give_reads <- function(arg_genome, arg_lengths_chroms, arg_lengths_chroms_norm){
  ## sample a chromosome with probability proportional to its size
  .chrom_selected <- sample(1:length(arg_lengths_chroms_norm), size = 1, prob = arg_lengths_chroms_norm)
  .start <- sample((1-length_read):(arg_lengths_chroms[.chrom_selected]-1), size = 1)
  # .start <- sample((1):(arg_lengths_chroms[.chrom_selected]-1-length_read), size = 1)
  .read <- getSeq(arg_genome, as(data.frame(chrom=names(arg_genome)[.chrom_selected],
                                              start=max(.start, 1),
                                             end=min(arg_lengths_chroms[.chrom_selected],
                                                     .start+(length_read-1))), "GRanges"))
  
  .read
}


reads_tumour <- replicate(round(nreads*opt$purity),  expr = try(give_reads(sim_to_save,
                                                                lengths_chroms,
                                                                lengths_chroms_norm)), simplify = T)
reads_tumour <- reads_tumour[sapply(reads_tumour, typeof) == "S4"]

## create complementary reads
sample_complementary_tumour <- sample(c(0,1), size = length(reads_tumour), prob = c(0.5, 0.5), replace = T)
reads_tumour[sample_complementary_tumour == 0] = sapply(reads_tumour[sample_complementary_tumour == 0], Biostrings::complement)

## create reads from the genome too, with a given purity
lengths_chroms_normal <- sapply(genome, nchar)
lengths_chroms_normal_norm <- lengths_chroms_normal/sum(lengths_chroms_normal)

reads_normal <- replicate(round(nreads*(1-opt$purity)),  expr = try(give_reads(DNAStringSet(genome),
                                                                       lengths_chroms_normal,
                                                                       lengths_chroms_normal_norm)), simplify = T)
reads_normal <- reads_normal[sapply(reads_normal, typeof) == "S4"]
sample_complementary_normal <- sample(c(0,1), size = length(reads_normal), prob = c(0.5, 0.5), replace = T)
reads_normal[sample_complementary_normal == 0] = sapply(reads_normal[sample_complementary_normal == 0], Biostrings::complement)

reads_c <- do.call('c', c(reads_tumour, reads_normal))

names(reads_c) = paste0('read', 1:length(reads_c))

# sim_transloc

system(paste0('mkdir -p output/output_', opt$genome))
system(paste0('mkdir -p output/output_', opt$genome, '/reads/'))

writeXStringSet(x = reads_c, filepath = paste0("output/output_", opt$genome, "/reads/sim_transloc_reads",
                                               opt$name, ".fa"))
# writeXStringSet(x = complement(reads_c), filepath = "output/sim_transloc_reads_complement.fa")

