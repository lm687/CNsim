local_bool = F
if(local_bool){
  rm(list = ls())
  local_bool=T
}

library(ggplot2)
library(optparse)
library(QDNAseq)
library(CNSimGenome)
library(Biobase)

if(local_bool){
  setwd(dirname(rstudioapi::getSourceEditorContext()$path))
  
  opt=list()
  opt$name = "5df28185-3253-4dd7-b88f-320d4a5b87d0"
}else{
  option_list = list(
    make_option(c("--name"), type="character", default=NA,
                help="name (uuid)", metavar="character"))
  opt_parser = OptionParser(option_list=option_list);
  opt = parse_args(opt_parser);
  
}


# genome <- readBStringSet("output/genome.fa", format="fasta",
#                          nrec=-1L, skip=0L, seek.first.rec=FALSE,
#                          use.names=TRUE, with.qualities=FALSE)

bins_genome <- readRDS(file = "bins_genome02.RDS")
readCounts <- QDNAseq::binReadCounts(bamfiles = paste0("output/alignments/aligned_sim_transloc_reads", opt$name, ".bam"),
                                     bins = bins_genome)
readCounts@assayData$counts ## none are aligned??
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
# readCountsFiltered <- estimateCorrection(readCountsFiltered)
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

# QDNAseq::frequencyPlot(copyNumbersCalled)
# # QDNAseq::isobarPlot(readCountsFiltered)
# QDNAseq::noisePlot(readCountsFiltered)
# QDNAseq::plot(copyNumbersCalled)

# copyNumbersCalled@assayData$calls
# copyNumbersCalled@assayData$copynumber
# copyNumbersCalled@assayData$probnorm
# plot(copyNumbersSegmented@assayData$copynumber, type='l')

data_for_plot <- cbind.data.frame(chrom=paste0('chr', gsub(":.*", "", rownames(copyNumbersCalled@assayData$segmented))),
                 pos=t(sapply(gsub("*:.", "", rownames(copyNumbersCalled@assayData$segmented)), function(i) strsplit(i, '-')[[1]])),
                 cn=copyNumbersCalled@assayData$segmented[,1])
data_for_plot$pos.1 = as.numeric(data_for_plot$pos.1)
data_for_plot$pos.2 = as.numeric(data_for_plot$pos.2)

ggplot(data_for_plot, aes(x=pos.1, xend=pos.2, y=cn, yend=cn))+geom_segment()+facet_wrap(.~chrom)+theme_bw()
ggsave(paste0("output/plots_segmented/plotCN_", opt$name, ".pdf"))

### From now, I use excerps from Phil's code (see qdnaseq_mod_ds.R)
#bring back to readcount space 
copyNumbers_old <- copyNumbers
readCountsFiltered_old <- readCountsFiltered

# library(Biobase)
# assayDataElement(copyNumbers,"copynumber") <- assayDataElement(copyNumbers,"copynumber") * median(assayDataElement(readCountsFiltered, "fit"), na.rm=T)
# 
# dim(assayDataElement(copyNumbers,"copynumber"))
# median(assayDataElement(readCountsFiltered, "fit"), na.rm=T)
# median(assayDataElement(copyNumbersCalled, "fit"), na.rm=T)
# median(assayDataElement(copyNumbers, "fit"), na.rm=T)
# 
# ## copyNumbersSegmented
# 
# ## ?? where is this fit?
# 
# assayDataElement(copyNumbers,"copynumber")
# median(assayDataElement(readCountsFiltered[[1]], "fit"), na.rm=T)
# 
# # ????
#   
# smooth_samples <- function(obj){
#   # Index and subselect sample
#   #ind <- which(colnames(copyNumbersSegmentedSmooth)==sample)
#   relcn <- obj
#   # Check if smoothing needed
#   smooth.bool <- FALSE
#   relative_tmp <- NULL
#   if(sampleNames(obj) %in% smoothed_samples){
#     smooth.bool <- TRUE
#     currsamp <- relcn
#     maxseg<-300
#     sdadjust<-1.5
#     condition <- fData(currsamp)$use
#     segments <- assayDataElement(currsamp, "segmented")[condition, , drop=FALSE]
#     segments<-apply(segments,2,rle)
#     segnum<-as.numeric(lapply(segments,function(x){length(x$lengths)}))
#     while(sum(segnum>maxseg)&sdadjust<5)
#     {
#       currsamp<-segmentBins(currsamp, transformFun="sqrt",undo.SD=sdadjust)
#       segments <- assayDataElement(currsamp, "segmented")[condition, , drop=FALSE]
#       segments<-apply(segments,2,rle)
#       segnum<-as.numeric(lapply(segments,function(x){length(x$lengths)}))
#       sdadjust<-sdadjust+0.5
#     }
#     relative_tmp <- currsamp
#     relcn <- relative_tmp
#   }
#   return(relcn)
# }
# 
# 
# smoothed_samples <- sampleNames(copyNumbersSegmented)
# copyNumbersSegmentedSmooth <- smooth_samples(copyNumbersSegmented)
# 
# depthtocn<-function(x,purity,seqdepth) #converts readdepth to copy number given purity and single copy depth
# {
#   (x/seqdepth-2*(1-purity))/purity
# }
# 
# # List samples
# qc.data <- read.table(copyNumbersSegmented@input[["meta"]],header = T,sep = "\t")
# 
# samples <- qc.data
# 
# cn <- assayDataElement(copyNumbersCalled,"copynumber")
# seg <- assayDataElement(copyNumbersCalled,"segmented")
# 
# # Convert to abs
# length_bins <- sapply(gsub("*.:", "", rownames(readCounts@assayData$counts)), function(i){.x <- (strsplit(i, '-')[[1]]); as.numeric(.x[2])-as.numeric(.x[1])})
# average_depth <- mean(length_bins*readCounts@assayData$counts[,1])
# 
# abs_cn <- depthtocn(cn,purity = 1,seqdepth = average_depth)
# abs_seg <- depthtocn(seg,purity = 1,seqdepth = average_depth)
# 
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


