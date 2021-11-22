extractCopynumberFeatures_generalised <- function(CN_data, cores = 1, chrlen, gaps){
  #get chromosome lengths
  
  #get centromere locations

  if(cores > 1) {
    require(foreach)
    doMC::registerDoMC(cores)
    
    temp_list = foreach::foreach(i=1:6) %dopar% {
      if(i == 1){
        list(segsize = getSegsize(CN_data) )
      } else if (i == 2) {
        list(bp10MB = getBPnum(CN_data,chrlen) )
      } else if (i == 3) {
        list(osCN = getOscilation(CN_data,chrlen) )
      } else if (i == 4) {
        list(bpchrarm = getCentromereDistCounts(CN_data,centromeres,chrlen) )
      } else if (i == 5) {
        list(changepoint = getChangepointCN(CN_data) )
      } else {
        list(copynumber = getCN(CN_data) )
      }
      
    }
    unlist( temp_list, recursive = FALSE )
  } else {  
    
    segsize<-getSegsize(CN_data)
    bp10MB<-getBPnum(CN_data,chrlen)
    osCN<-getOscilation(CN_data,chrlen)
    bpchrarm<-getCentromereDistCounts(CN_data,centromeres,chrlen)
    changepoint<-getChangepointCN(CN_data)
    copynumber<-getCN(CN_data)
    
    list(segsize=segsize,bp10MB=bp10MB,osCN=osCN,bpchrarm=bpchrarm,changepoint=changepoint,copynumber=copynumber)
  }
  
}

getSegTable<-function(x) #returns a table containing copy number segments
{
  dat<-x
  sn<-assayDataElement(dat,"segmented")
  fd <- fData(dat)
  fd$use -> use
  fdfiltfull<-fd[use,]
  sn<-sn[use,]
  segTable<-c()
  for(c in unique(fdfiltfull$chromosome))
  {
    snfilt<-sn[fdfiltfull$chromosome==c]
    fdfilt<-fdfiltfull[fdfiltfull$chromosome==c,]
    sn.rle<-rle(snfilt)
    starts <- cumsum(c(1, sn.rle$lengths[-length(sn.rle$lengths)]))
    ends <- cumsum(sn.rle$lengths)
    lapply(1:length(sn.rle$lengths), function(s) {
      from <- fdfilt$start[starts[s]]
      to <- fdfilt$end[ends[s]]
      segValue <- sn.rle$value[s]
      c(fdfilt$chromosome[starts[s]], from, to, segValue)
    }) -> segtmp
    segTableRaw <- data.frame(matrix(unlist(segtmp), ncol=4, byrow=T),stringsAsFactors=F)
    segTable<-rbind(segTable,segTableRaw)
  }
  colnames(segTable) <- c("chromosome", "start", "end", "segVal")
  segTable
}

getPloidy<-function(abs_profiles) #returns the ploidy of a sample from segTab or QDNAseq object
{
  out<-c()
  samps<-getSampNames(abs_profiles)
  for(i in samps)
  {
    if(class(abs_profiles)=="QDNAseqCopyNumbers")
    {
      segTab<-getSegTable(abs_profiles[,which(colnames(abs_profiles)==i)])
    }
    else
    {
      segTab<-abs_profiles[[i]]
      colnames(segTab)[4]<-"segVal"
    }
    segLen<-(as.numeric(segTab$end)-as.numeric(segTab$start))
    ploidy<-sum((segLen/sum(segLen))*as.numeric(segTab$segVal))
    out<-c(out,ploidy)
  }
  data.frame(out,stringsAsFactors = F)
}

getSampNames<-function(abs_profiles) # convenience function for getting sample names from QDNAseq or segTab list
{
  if(class(abs_profiles)=="QDNAseqCopyNumbers")
  {
    samps<-colnames(abs_profiles)
  }
  else
  {
    samps<-names(abs_profiles)
  }
  samps
}

depthtocn<-function(x,purity,seqdepth) #converts readdepth to copy number given purity and single copy depth
{
  (x/seqdepth-2*(1-purity))/purity
}

cntodepth<-function(cn,purity,seqdepth) #converts copy number to read depth given purity and single copy depth
{
  seqdepth*((1-purity)*2+purity*cn)
}

smooth_samples <- function(obj){
  # Index and subselect sample
  #ind <- which(colnames(copyNumbersSegmentedSmooth)==sample)
  relcn <- obj
  # Check if smoothing needed
  smooth.bool <- FALSE
  relative_tmp <- NULL
  if(sampleNames(obj) %in% smoothed_samples){
    smooth.bool <- TRUE
    currsamp <- relcn
    maxseg<-300
    sdadjust<-1.5
    condition <- fData(currsamp)$use
    segments <- assayDataElement(currsamp, "segmented")[condition, , drop=FALSE]
    segments<-apply(segments,2,rle)
    segnum<-as.numeric(lapply(segments,function(x){length(x$lengths)}))
    while(sum(segnum>maxseg)&sdadjust<5)
    {
      currsamp<-segmentBins(currsamp, transformFun="sqrt",undo.SD=sdadjust)
      segments <- assayDataElement(currsamp, "segmented")[condition, , drop=FALSE]
      segments<-apply(segments,2,rle)
      segnum<-as.numeric(lapply(segments,function(x){length(x$lengths)}))
      sdadjust<-sdadjust+0.5
    }
    relative_tmp <- currsamp
    relcn <- relative_tmp
  }
  return(relcn)
}
