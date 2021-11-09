
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
  opt$ndels <- 1
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
                metavar="double"),
    make_option(c("--ndels"), type="double", default=1,
                help="number of deletions simulated with RSVsim",
                metavar="double"),
    make_option(c("--readlen"), type="double", default=150,
                help="length of simulated read",
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

sim_del = simulateSV(output=NA, genome=genome, dels=opt$ndels, sizeDels=opt$size_deletion,
                     verbose=FALSE)

fiddle_with_genome <- F
if(fiddle_with_genome){
  sim_mod = simulateSV(output=NA, genome=genome, dels=opt$ndels, sizeDels=opt$size_deletion,
                       verbose=FALSE)
  
  sim_mod@metadata$deletions
  genome_changing <- genome
  sim_mod@metadata$deletions$Start:sim_mod@metadata$deletions$End
  chrom_in_change <- strsplit(as.character(genome_changing[sim_mod@metadata$deletions$Chr]), '')[[1]]
  chrom_in_change[sim_mod@metadata$deletions$Start:sim_mod@metadata$deletions$End] <- '-'
  genome_changing[[sim_mod@metadata$deletions$Chr]] <- BString(paste0(chrom_in_change, collapse = ""))
  
  many_changes <- simulateSV(dels = 10, ins = 20, dups = 20, genome = genome, output = NA, sizeDels = 500, sizeDups = 300)
  
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
      chrom_in_change <- strsplit(as.character(genome_changing[[many_changes@metadata$tandemDuplications$Chr[i_ins]]]), '')[[1]]
      chrom_in_change[1:many_changes@metadata$tandemDuplications$Start[i_ins]] <- '-'
      chrom_in_change[many_changes@metadata$tandemDuplications$End[i_ins]:width(genome_changing[many_changes@metadata$tandemDuplications$Chr[i_ins]])] <- '-'
      chrom_in_change <- BString(paste0(chrom_in_change, collapse = ""))
      for(i_td_dups in 1:many_changes@metadata$tandemDuplications$Duplications[i_ins]){
        ## many tandem duplications
        genome_changing[[paste0(many_changes@metadata$tandemDuplications$Chr[i_ins], '_', i_ins, '_', i_td_dups)]] <- chrom_in_change
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
  ## insertion vs duplication?????
  
  ## now select the chromosomes that are homologous
  chroms_final <- sapply(names(genome_changing), function(i) strsplit(i, '[a-z]')[[1]][1])
  chroms_final_idx <- sapply(unique(chroms_final), function(i) which(chroms_final == i))
  

  true_ploidies_sim <- lapply(1:length(chroms_final_idx), function(idx_chroms_final){
    splt_chrom_it <- sapply(genome_changing[chroms_final_idx[[idx_chroms_final]]], function(i) strsplit(as.character(i), '')[[1]])
    original_genome <- strsplit(as.character(genome[names(chroms_final[chroms_final_idx[[idx_chroms_final]]][1])]), '')[[1]]
    splt_chrom_it_match <- apply(splt_chrom_it, 2, function(i) i==original_genome)
    true_ploidy <- rowSums(splt_chrom_it_match)
    true_ploidy
  })
  plot(unlist(true_ploidies_sim),
       col=c('red', 'blue', 'green', 'orange')[factor(rep(1:length(true_ploidies_sim), sapply(true_ploidies_sim, length)))])
  
  true_ploidies_sim_df <- lapply(1:length(true_ploidies_sim), function(i) cbind.data.frame(cn=true_ploidies_sim[[i]],
                                                                   position=1:length(true_ploidies_sim[[i]])))
  names(true_ploidies_sim_df) <- names(chroms_final_idx)
  ggplot(melt(true_ploidies_sim_df, id.vars=c('cn', 'position')), aes(x=position, xend=position+1, y=cn, yend=cn))+
    # geom_segment()+facet_wrap(.~L1, scales = "free_x")+theme_bw()
  geom_step()+facet_wrap(.~L1, scales = "free_x")+theme_bw()
  
  ## repeat this with all chromosomes
  
  ## add additional mutations, but incorporating the changes into
  sim_mod2 = simulateSV(output=NA, genome=sim_mod, 
                        verbose=FALSE, ins = 2)
  sim_mod2@metadata$deletions
  sim_mod2@metadata$insertions
  
  library(RSVSim)
  

  many_changes@metadata$deletions
  many_changes@metadata$insertions
  RSVSim::compareSV(genome, many_changes)
  bins_genome <- readRDS(file = paste0("output/", opt$genome, "/bins_genome02.RDS"))
  
  Biostrings::coverage(many_changes)
  
  ## align each derivetive chromosome to the chromosome from which it comes, to get the ploidy
  ## not sure about inversions
  ## let's not simulate inversions for now
  length_read <- 5
  give_reads_string <- function(arg_genome, arg_lengths_chroms_norm){
    arg_genome_split <- strsplit(arg_genome, '')[[1]]
    arg_lengths_chroms <- length(arg_genome_split)
    .start <- sample((1-length_read):(arg_lengths_chroms-1), size = 1)
    .start
    paste0(arg_genome_split[max(.start, 1):min(arg_lengths_chroms,
                                        .start+(length_read-1))], collapse = "")
    # 
    # .read
  }
  
  as.character(many_changes[1])
  reads_sim <- replicate(100, give_reads_string(as.character(sim_del[1])))
  as.character(genome[1])
  
  globalAlign<- pairwiseAlignment(pattern = reads_sim, subject = as.character(genome[1]), type="local")
  globalAlign@pattern@unaligned
  globalAlign@pattern@unaligned
  globalAlign
  
  library(msa)
  msa_res <- msa(c(true=as.character(genome[[1]]), reads_sim), type = "dna")
  msa_res@params
  msa_res
  msa_res@unmasked
  msa_res@unmasked
  View(msa(c(true=as.character(genome[[1]]), reads_sim), method="ClustalOmega", type = "dna"))
  
  grepl(reads_sim[[1]], as.character(genome[[1]]))
}
  
# sim_del <- genome
# sim_del[1] <-   Biostrings::substr(sim_del[1], 2000, nchar(sim_del[1]))
# sim_del[5] <-   Biostrings::substr(sim_del[1], 2000, nchar(sim_del[1]))

sim_to_save0 <- sim_del
sim_to_save <- DNAStringSet(sim_del)

saveRDS(sim_to_save, paste0("output/output_", opt$genome, "/reads/", opt$name, "derivative_genome.RDS"))
saveRDS(sim_to_save0, paste0("output/output_", opt$genome, "/reads/", opt$name, "derivative_genome_RSVSim.RDS"))

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
length_read = opt$readlen
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
                                               opt$name, '_nreads', opt$nreads, '_sizedels', opt$size_deletion, ".fa"))


# writeXStringSet(x = complement(reads_c), filepath = "output/sim_transloc_reads_complement.fa")

