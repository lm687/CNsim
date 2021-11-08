local_bool = F
if(local_bool){
  rm(list = ls())
  local_bool=T
}

library(ggplot2)
library(optparse)
library(QDNAseq)
library(RSVSim)
library(Biobase)
library(ACE)
source("4_helper_functions.R")
if(local_bool){
  setwd(dirname(rstudioapi::getSourceEditorContext()$path))
  
  opt=list()
  opt$genome = "genome2"
  opt$name = "84eff1f1-f243-4470-9993-98180e80f71e"
  opt$name = "1f041abe-1a08-4b39-bab4-168614961fe6"
}else{
  option_list = list(
    make_option(c("--name"), type="character", default=NA,
                help="name (uuid)", metavar="character"),
    make_option(c("--size_deletion"), type="double", default=200,
                help="size of the deletion, in bp",
                metavar="double"),
    make_option(c("--nreads"), type="double", default=4000,
                help="number of reads",
                metavar="double"),
    make_option(c("--genome"), type="character", default=NA,
                help="name of genome to use", metavar="character"))
  opt_parser = OptionParser(option_list=option_list);
  opt = parse_args(opt_parser);
  
}


# genome <- readBStringSet("output/genome.fa", format="fasta",
#                          nrec=-1L, skip=0L, seek.first.rec=FALSE,
#                          use.names=TRUE, with.qualities=FALSE)

bins_genome <- readRDS(file = paste0("output/", opt$genome, "/bins_genome0002.RDS"))
readCounts <- QDNAseq::binReadCounts(bamfiles = paste0("output/output_",opt$genome, "/alignments/aligned_sim_transloc_reads", opt$name, '_nreads', opt$nreads, '_sizedels', opt$size_deletion, ".bam"),
                                     bins = bins_genome)
readCounts@assayData$counts ## how many are aligned
sum(readCounts@assayData$counts)

# readCounts <- QDNAseq::binReadCounts(bamfiles = "output/aligned_sim_transloc_reads_complement.bam", bins = bins_genome)
# readCounts@assayData$counts ## none are aligned??
# sum(readCounts@assayData$counts)

# QDNAseq::QDNAseqCopyNumbers(readCounts)
readCountsFiltered <- readCounts
# readCountsFiltered <- applyFilters(readCounts)
readCountsFiltered@featureData@data$mappability=TRUE ## everything is mappable
readCountsFiltered@featureData@data$use=TRUE ## everything is mappable
readCountsFiltered@featureData@data$gc = rep(1, length(readCountsFiltered@featureData@data$gc))
readCountsFiltered <- estimateCorrection(readCountsFiltered)
copyNumbers <- correctBins(readCountsFiltered)
copyNumbersNormalized <- normalizeBins(copyNumbers)
copyNumbersSmooth <- smoothOutlierBins(copyNumbersNormalized)
copyNumbersSegmented <- segmentBins(copyNumbersSmooth)

# fvarLabels(copyNumbersSegmented)
copyNumbersSegmented@featureData@varMetadata$labelDescription = rownames(copyNumbersSegmented@featureData@varMetadata)
copyNumbersSegmented@featureData@varMetadata = rbind(copyNumbersSegmented@featureData@varMetadata, 'mappability')
copyNumbersSegmented@featureData@varMetadata = rbind(copyNumbersSegmented@featureData@varMetadata, 'use')

rownames(copyNumbersSegmented@featureData@varMetadata)
colnames(readCountsFiltered@featureData@data)

rownames(copyNumbersSegmented@featureData@varMetadata)[nrow(copyNumbersSegmented@featureData@varMetadata)-1] = 'mappability'
rownames(copyNumbersSegmented@featureData@varMetadata)[nrow(copyNumbersSegmented@featureData@varMetadata)] = 'use'

copyNumbersSegmented <- normalizeSegmentedBins(object = copyNumbersSegmented)

rownames(copyNumbersSegmented@featureData@varMetadata)
colnames(readCountsFiltered@featureData@data)


copyNumbersCalled <- callBins(copyNumbersSegmented)

original_derivative <- readRDS(paste0("output/output_", opt$genome, "/reads/", opt$name, "derivative_genome.RDS"))
original_derivative_RSV <- readRDS(paste0("output/output_", opt$genome, "/reads/", opt$name, "derivative_genome_RSVSim.RDS"))

ACE::singleplot(template = copyNumbersCalled, QDNAseqobjectsample = 1, cellularity = 0.8)
ACE::singleplot(template = copyNumbersCalled, QDNAseqobjectsample = 1, cellularity = 0.2)
# 
# readCounts@assayData$counts

# QDNAseq::frequencyPlot(copyNumbersCalled)
# # QDNAseq::isobarPlot(readCountsFiltered)
# QDNAseq::noisePlot(readCountsFiltered)
# QDNAseq::plot(copyNumbersCalled)

# copyNumbersCalled@assayData$calls
# copyNumbersCalled@assayData$copynumber
# copyNumbersCalled@assayData$probnorm
# plot(copyNumbersSegmented@assayData$copynumber, type='l')

data_for_plot <- cbind.data.frame(chrom=paste0('chr', gsub(":.*", "", rownames(copyNumbersCalled@assayData$segmented))),
                 pos=t(sapply(gsub("*.:", "", rownames(copyNumbersCalled@assayData$segmented)), function(i) strsplit(i, '-')[[1]])),
                 cn=copyNumbersCalled@assayData$segmented[,1])
data_for_plot$pos.1 = as.numeric(data_for_plot$pos.1)
data_for_plot$pos.2 = as.numeric(data_for_plot$pos.2)

#ggplot(data_for_plot, aes(x=pos.1, xend=pos.2, y=cn, yend=cn))+geom_segment()+
#  facet_wrap(.~chrom, scales = "free_x")+theme_bw()
#ggsave(paste0("output/output_", opt$genome, "/plots_segmented/plotCN_", opt$name, ".pdf"))

## add information about simulation
details_sim <- readRDS(paste0("output/output_", opt$genome, "/reads/", opt$name, "derivative_genome.RDS"))

title_plot_lengths_chrom <- paste0(apply(sapply(1:(length(details_sim)/2), function(chrom_idx) sapply(details_sim[c(chrom_idx, chrom_idx+(length(details_sim)/2))], length)),
      2, paste0, collapse=';'), collapse = " ")

pdf(paste0("output/output_", opt$genome, "/plots_segmented/plotCN_", opt$name, '_nreads', opt$nreads, '_sizedels', opt$size_deletion, '_ACE08cellularity.pdf'))

ACE::singleplot(template = copyNumbersCalled, QDNAseqobjectsample = 1, cellularity = 0.8,
                # title = paste0(original_derivative@metadata$deletions[1:4], collapse = "-"),
                title=title_plot_lengths_chrom)
dev.off()

pdf(paste0("output/output_", opt$genome, "/plots_segmented/plotCN_", opt$name, '_nreads', opt$nreads, '_sizedels', opt$size_deletion, '_coverage.pdf'))
QDNAseq::plot(readCounts)
dev.off()

pdf(paste0("output/output_", opt$genome, "/plots_segmented/plotCN_", opt$name, '_nreads', opt$nreads, '_sizedels', opt$size_deletion, '_logRatio1.pdf'))
plot(copyNumbersSegmented$`aligned_sim_transloc_reads1f041abe-1a08-4b39-bab4-168614961fe6`)
dev.off()

pdf(paste0("output/output_", opt$genome, "/plots_segmented/plotCN_", opt$name, '_nreads', opt$nreads, '_sizedels', opt$size_deletion, '_logRatio2.pdf'))
plot(copyNumbersCalled)
dev.off()

# QDNAseq::isobarPlot(x = copyNumbersSegmented$`aligned_sim_transloc_reads1f041abe-1a08-4b39-bab4-168614961fe6`)
# QDNAseq::noisePlot(x = copyNumbersSegmented$`aligned_sim_transloc_reads1f041abe-1a08-4b39-bab4-168614961fe6`)


### From now, I use excerps from Phil's code (see qdnaseq_mod_ds.R)
#bring back to readcount space 
copyNumbers_old <- copyNumbers
readCountsFiltered_old <- readCountsFiltered


median(assayDataElement(readCountsFiltered, "fit"), na.rm=T)

assayDataElement(copyNumbers,"copynumber")
## need to go from relative to absolute CN. However, we are already in absolute CN, given that the purity is of 1?
assayDataElement(copyNumbers,"copynumber") <- assayDataElement(copyNumbers,"copynumber") * median(assayDataElement(readCountsFiltered, "fit"), na.rm=T)

copyNumbersSmooth <- mclapply(X=list(copyNumbers), FUN=smoothOutlierBins, mc.cores=1)
copyNumbersSegmented <- mclapply(X=copyNumbersSmooth, FUN=segmentBins, transformFun="sqrt", mc.cores=1)

# dim(assayDataElement(copyNumbers,"copynumber"))


##here 

smoothed_samples <- sampleNames(copyNumbersSegmented)
names(copyNumbersSegmented) <- smoothed_samples
copyNumbersSegmentedSmooth <- smooth_samples(copyNumbersSegmented[[1]])

# View(copyNumbersSegmentedSmooth@assayData$segmented) ## these copy numbers look huge

data_for_plot_abs <- cbind.data.frame(chrom=paste0('chr', gsub(":.*", "", rownames(copyNumbersSegmentedSmooth@assayData$segmented))),
                                  pos=t(sapply(gsub("*:.", "", rownames(copyNumbersSegmentedSmooth@assayData$segmented)), function(i) strsplit(i, '-')[[1]])),
                                  cn=copyNumbersSegmentedSmooth@assayData$segmented[,1])
data_for_plot_abs$pos.1 = as.numeric(data_for_plot$pos.1)
data_for_plot_abs$pos.2 = as.numeric(data_for_plot$pos.2)

#ggplot(data_for_plot_abs, aes(x=pos.1, xend=pos.2, y=cn, yend=cn))+geom_segment()+facet_wrap(.~chrom)+theme_bw()
#ggsave(paste0("output/output_", opt$genome, "/plots_segmented/plotabsCN_", opt$name, ".pdf"))


# # List samples
# qc.data <- read.table(copyNumbersSegmented@input[["meta"]],header = T,sep = "\t")
# 
# samples <- qc.data
# 
cn <- assayDataElement(copyNumbersCalled,"copynumber")
seg <- assayDataElement(copyNumbersCalled,"segmented")
# 
# # Convert to abs
length_bins <- sapply(gsub("*.:", "", rownames(readCounts@assayData$counts)), function(i){.x <- (strsplit(i, '-')[[1]]); as.numeric(.x[2])-as.numeric(.x[1])})
average_depth <- sum(length_bins/(sum(length_bins))*readCounts@assayData$counts[,1])

abs_cn <- depthtocn(cn,purity = 0.8,seqdepth = average_depth)
abs_seg <- depthtocn(seg,purity = 0.8,seqdepth = average_depth)

# copyNumbersCalled_for_sigs <- copyNumbersCalled
# assayDataElement(copyNumbersCalled_for_sigs,"copynumber") <- abs_cn
# assayDataElement(copyNumbersCalled_for_sigs,"segmented") <- abs_seg
# 
# source("../../../../other_repos/britroc-cnsignatures-bfb69cd72c50/main_functions.R")
# source("../../../../other_repos/britroc-cnsignatures-bfb69cd72c50/helper_functions.R")
# 
# # chrlen<-read.table(paste(this_path,"data/hg19.chrom.sizes.txt",sep="/"),sep="\t",stringsAsFactors = F)[1:24,]
# 
# chrlen <- cbind.data.frame(paste0('chr', 1:length(CNSimGenome)),
#       sapply(1:length(CNSimGenome),function(i) length(CNSimGenome[[i]])))
# colnames(chrlen) <- NULL
# gaps<-read.table(paste(this_path,"data/gap_hg19.txt",sep="/"),sep="\t",header=F,stringsAsFactors = F)
# centromeres<-gaps[gaps[,8]=="centromere",]
# gaps <- matrix(NA, ncol=ncol(gaps), nrow=nrow(gaps))
# centromeres <- c()
# 
# extractCopynumberFeatures_generalised(CN_data = (copyNumbersCalled_for_sigs), chrlen = chrlen, gaps = gaps)
# extractCopynumberFeatures
# copyNumbersCalled_for_sigs@featureData@data
# 
# CN_data = list(copyNumbersCalled_for_sigs)
# abs_profiles = copyNumbersCalled_for_sigs
# 
# 
# list(segsize = getSegsize(CN_data[[1]]) )
# list(segsize = getSegsize(CN_data) )
# list(bp10MB = getBPnum(CN_data[[1]],chrlen) )
# list(osCN = getOscilation(CN_data[[1]],chrlen) )
# list(bpchrarm = getCentromereDistCounts(CN_data[[1]],centromeres,chrlen) )
# list(changepoint = getChangepointCN(CN_data[[1]]) )
# list(copynumber = getCN(CN_data[[1]]) )

## all looks a bit funky


