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