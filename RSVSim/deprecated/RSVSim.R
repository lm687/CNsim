library(RSVSim)

vignette('RSVSim')

## ------------------------------------------------------------------------------ ##

## create genome

genome = DNAStringSet(
  c("AAAAAAAAAAAAAAAAAAAATTTTTTTTTTTTTTTTTTTT",
    "GGGGGGGGGGGGGGGGGGGGCCCCCCCCCCCCCCCCCCCC",
    "GGGGGGGGGGGGGGAAGGGGGCCCCCCCCAACCCCCCCCCCC"))
length_chrom <- c(70, 60, 45)
nchrom <- length(length_chrom)
genome = DNAStringSet(
  sapply(1:nchrom, function(i) paste0(sample(c('A', 'C', 'G', 'T'),
                                             size = length_chrom[i], replace = T),
                                      collapse = ""))
  )
names(genome) = paste0("chr", 1:nchrom)
genome

## ------------------------------------------------------------------------------ ##

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

## ------------------------------------------------------------------------------ ##
## find differences
sim = simulateSV(output=NA, genome=genome, dels=5, sizeDels=5,
                 bpSeqSize=10, seed=2345, verbose=FALSE)
simSVs = metadata(sim)$deletions
simSVs

sim_transloc
genome

## ------------------------------------------------------------------------------ ##

## need to simulate cycles of mutation and repair. e.g., for deletion, how is it repaired?
## update: I don't think so
sim_del

sim_del$chr1
sim_del$chr2

## using the compare genome feature
AA <- metadata(sim_transloc)
AA$translocations
RSVSim::compareSV(querySVs = genome, simSVs = sim_transloc)
querySVs = data.frame(
  chr=c("chr1","chr1","chr1","chr2","chr2","chr2"), 
  start=c(4,12,20,10,21,34), 
  end=c(8,16,28,14,31,38), 
  bpSeq=c("AAAAAAAAAA", "AAAAAAAAAT", "AAAATTTTTT", "GGGGGGGGGG", "GGGGGGGCCC", "CCCCCCCCCC")
)
sim_transloc_meta0 <- metadata(sim_transloc)
sim_transloc_meta <- sim_transloc_meta0$translocations

RSVSim::compareSV(querySVs = querySVs, simSVs = sim_transloc_meta, tol = 1000)


## do I need to create reads now, and then align them to the genome?
# RSVSim::
sim_transloc_meta0$translocations@
sim_transloc_meta

ls(sim_del$chr1@shared@.link_to_cached_object)
sim_del$chr1@shared@xp


Biostrings::getSeq(sim_del$chr1)
seq(sim_del$chr1)
Biostrings::seq(sim_del$chr1)

ls(sim_del$chr1@shared@.link_to_cached_object)

?DNAStringSet

seqs <- lapply(sim_del, as.character)
seqs_2 <- lapply(sim_transloc, as.character)

## create reads


library("seqinr")
seq1<- read.fasta(file = " first.fasta")
seq2<- read.fasta(file = " second.fasta")
seq1string <- toupper(c2s(seq1[[1]]))
seq2string <- toupper(c2s(seq2 [[2]]))
library(Biostrings)
reads <- replicate(20, sapply(seqs_2[[1]], function(i){
  .start <- sample(1:(nchar(i)-8), size = 1); substr(i, .start, .start+7)
}))
globalAlign<- pairwiseAlignment(reads, as.character(genome$chr1), type="local")
globalAlign@pattern@unaligned
globalAlign

library(msa)
msa_res <- msa(c(true=as.character(genome$chr1), reads), type = "dna")
msa_res@params

true_seq <- as.character(msa_res@unmasked[['true']])
msa_res@unmasked[['true']] <- NULL ## so that it's not counted

count_mat <- sapply(1:length(msa_res@unmasked), function(i){
  strsplit(as.character(msa_res@unmasked[[i]]), '')[[1]]  != "-"
  })

dim(count_mat)
rowSums(count_mat)

## for QDNASeq we need BAM files, so that we can read them using binReadCounts


# library(QDNAseq)
# data(LGG150)
# readCounts <- LGG150
# readCountsFiltered <- applyFilters(readCounts)
# readCountsFiltered <- estimateCorrection(readCountsFiltered)
# copyNumbers <- correctBins(readCountsFiltered)
# copyNumbersNormalized <- normalizeBins(copyNumbers)
# copyNumbersSmooth <- smoothOutlierBins(copyNumbersNormalized)
# copyNumbersSegmented <- segmentBins(copyNumbersSmooth)
# copyNumbersSegmented <- normalizeSegmentedBins(copyNumbersSegmented)
# copyNumbersCalled <- callBins(copyNumbersSegmented)

library(QDNAseq)
data(LGG150)
readCounts <- QDNAseqReadCounts(globalAlign)

readCountsFiltered <- applyFilters(readCounts)
readCountsFiltered <- estimateCorrection(readCountsFiltered)
copyNumbers <- correctBins(readCountsFiltered)
copyNumbersNormalized <- normalizeBins(copyNumbers)
copyNumbersSmooth <- smoothOutlierBins(copyNumbersNormalized)
copyNumbersSegmented <- segmentBins(copyNumbersSmooth)
copyNumbersSegmented <- normalizeSegmentedBins(copyNumbersSegmented)
copyNumbersCalled <- callBins(copyNumbersSegmented)