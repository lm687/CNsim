sim_wrapper <- function(..., return_derivative_genome=F){
  
  if(exists('genome')){
    if(typeof(genome) == "character"){
      genome <- genome_list[[genome]]
    }
  }
  
  if(exists('regionsDels')){
    if(typeof(regionsDels) == "character"){
      regionsDels <- regionsDels_list[[regionsDels]]
    }
  }
  
  ## make changes to the genome
  # debug
  # many_changes <- simulateSV(dels = 10, ins = 20, dups = 20, genome = genome, output = NA,
  # sizeDels = 500, sizeDups = 30)
  many_changes <- simulateSV(...)
  
  ## initialise
  genome_changing <- genome
  
  ## Add "-" in nucleotides of deletions
  if(length(many_changes@metadata$deletions) != 0){
    for(i_del in 1:nrow(many_changes@metadata$deletions)){
      chrom_in_change <- strsplit(as.character(genome_changing[[many_changes@metadata$deletions$Chr[i_del]]]), '')[[1]]
      chrom_in_change[many_changes@metadata$deletions$Start[i_del]:many_changes@metadata$deletions$End[i_del]] <- '-'
      genome_changing[[many_changes@metadata$deletions$Chr[i_del]]] <- BString(paste0(chrom_in_change, collapse = ""))
    }
  }
  
  if(length(many_changes@metadata$tandemDuplications) != 0){
    for(i_dup in 1:nrow(many_changes@metadata$tandemDuplications)){
      ## need to sort how insertions work    
      chrom_in_change <- strsplit(as.character(genome_changing[[many_changes@metadata$tandemDuplications$Chr[i_dup]]]), '')[[1]]
      chrom_in_change[1:many_changes@metadata$tandemDuplications$Start[i_dup]] <- '-'
      chrom_in_change[many_changes@metadata$tandemDuplications$End[i_dup]:width(genome_changing[many_changes@metadata$tandemDuplications$Chr[i_dup]])] <- '-'
      chrom_in_change <- BString(paste0(chrom_in_change, collapse = ""))
      for(i_td_dups in 1:many_changes@metadata$tandemDuplications$Duplications[i_dup]){
        ## many tandem duplications
        genome_changing[[paste0(many_changes@metadata$tandemDuplications$Chr[i_dup], '_', i_dup, '_', i_td_dups)]] <- chrom_in_change
      }
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
  
  ## now select the chromosomes that are homologous
  chroms_final <- sapply(names(genome_changing), function(i) strsplit(i, '[a-z]')[[1]][1])
  chroms_final_idx <- sapply(unique(chroms_final), function(i) which(chroms_final == i))
  
  ## get true ploidies
  true_ploidies_sim <- lapply(1:length(chroms_final_idx), function(idx_chroms_final){
    splt_chrom_it <- sapply(genome_changing[chroms_final_idx[[idx_chroms_final]]], function(i) strsplit(as.character(i), '')[[1]])
    original_genome <- strsplit(as.character(genome[names(chroms_final[chroms_final_idx[[idx_chroms_final]]][1])]), '')[[1]]
    splt_chrom_it_match <- apply(splt_chrom_it, 2, function(i) i==original_genome)
    true_ploidy <- rowSums(splt_chrom_it_match)
    true_ploidy
  })
  
  true_ploidies_sim_df <- lapply(1:length(true_ploidies_sim), function(i) cbind.data.frame(cn=true_ploidies_sim[[i]],
                                                                                           position=1:length(true_ploidies_sim[[i]])))
  names(true_ploidies_sim_df) <- names(chroms_final_idx)
  
  if(return_derivative_genome){
    return(list(derivative_genome=many_changes, cn_derivative_genome=true_ploidies_sim_df))
  }else{
    return(true_ploidies_sim_df)
  }
}

plot_sim_genome <- function(true_ploidies_sim_df_example2, arg_nrow=1){
  true_ploidies_sim_df_example2 <- melt(true_ploidies_sim_df_example2, id.vars=c('cn', 'position'))
  ggplot(true_ploidies_sim_df_example2, aes(x=position, xend=position+1, y=cn, yend=cn))+
    geom_hline(yintercept = 2, lty='dashed', col='blue')+
    geom_step()+facet_wrap(.~L1, scales = "free_x", nrow=arg_nrow)+theme_bw()
}


get_segments <- function(j){
  do.call('rbind', lapply(1:length(j), function(j2_idx){
    j2 <- j[[j2_idx]]
    start_pos <- 1
    rbind_cn <- c()
    while(start_pos < nrow(j2)){
      new_start_pos <- which( (j2[,'cn'] != j2[start_pos,'cn']) & (j2[,'position'] > start_pos) )[1] ## get first bp with different CN
      if(is.na(new_start_pos)){
        new_start_pos <- nrow(j2)+1
      }
      rbind_cn <- rbind.data.frame(rbind_cn, data.frame(start=start_pos, end=new_start_pos-1, cn=j2[start_pos,'cn']))
      start_pos <- new_start_pos
    }
    return(cbind.data.frame(rbind_cn, chromosome=names(j)[j2_idx])[,c(1,2,4,3)])
  }))
}

plot_from_hash <- function(genome_hash_res, ...){
  cn_from_hash <- table(factor(genome_hash_res, levels= 1:sum(sapply(genome, length))))
  cn_from_hash <- rowSums(matrix(cn_from_hash, ncol=2)) ## to genome, taking into account the two sets of chromosomes
  plot(cn_from_hash, ...)
  abline(h = 2, lty='dashed', col='blue')
}

give_cn_from_hash <- function(genome_hash_res) table(factor(genome_hash_res, levels= 1:sum(sapply(genome, length))))

plot_from_hash_2 <- function(genome_hash_res, ...){
  cn_from_hash <- give_cn_from_hash(genome_hash_res)
  .x <- cbind.data.frame(position0=as.numeric(names(cn_from_hash)), cn=as.vector(cn_from_hash),
                         L1=rep(1:length( sapply(genome, length)),  sapply(genome, length)))
  .x$position <- unlist(sapply(sapply(genome, length), function(i) 1:i))
  ## join homologuos chromosomes
  .x[1:(nrow(.x)/2),]$cn <- .x[1:(nrow(.x)/2),]$cn+.x[(1+(nrow(.x)/2)):nrow(.x),]$cn
  .x <- .x[1:(nrow(.x)/2),]
  names_chr <- unique(as.character(.x$L1))
  .x <- lapply(names_chr, function(i){
    .x <- .x[.x$L1 == i,]
    .x <- .x[,!(colnames(.x) %in% c("L1", "position0"))]
    .x })
  names(.x) <- names_chr
  .x
}

extractCopynumberFeatures_mod<-function(CN_data, cores = 1){
  ## modified from britroc signatures
  
  #get chromosome lengths
  chrlen<-read.table(paste(this_path,"data/hg19.chrom.sizes.txt",sep="/"),sep="\t",stringsAsFactors = F)[1:24,]
  
  #get centromere locations
  gaps<-read.table(paste(this_path,"data/gap_hg19.txt",sep="/"),sep="\t",header=F,stringsAsFactors = F)
  centromeres<-gaps[gaps[,8]=="centromere",]
  
  if(cores > 1) {
    require(foreach)
    doMC::registerDoMC(cores)
    
    temp_list = foreach::foreach(i=1:4) %dopar% {
      if(i == 1){
        list(segsize = getSegsize(CN_data) )
      # } else if (i == 2) {
        # list(bp10MB = getBPnum(CN_data,chrlen) )
      } else if (i == 2) {
        list(osCN = getOscilation(CN_data,chrlen) )
      # } else if (i == 4) {
      #   list(bpchrarm = getCentromereDistCounts(CN_data,centromeres,chrlen) )
      } else if (i == 3) {
        list(changepoint = getChangepointCN(CN_data) )
      } else {
        list(copynumber = getCN(CN_data) )
      }
      
    }
    unlist( temp_list, recursive = FALSE )
  } else {  
    
    segsize<-getSegsize(CN_data)
    # bp10MB<-getBPnum(CN_data,chrlen)
    osCN<-getOscilation(CN_data,chrlen)
    # bpchrarm<-getCentromereDistCounts(CN_data,centromeres,chrlen)
    changepoint<-getChangepointCN(CN_data)
    copynumber<-getCN(CN_data)
    
    list(segsize=segsize,
         # bp10MB=bp10MB,
         osCN=osCN,
         # bpchrarm=bpchrarm,
         changepoint=changepoint,
         copynumber=copynumber)
  }
  
}

fitMixtureModels_mod <- function(CN_features, seed=77777, min_comp=2, max_comp=10, min_prior=0.001, model_selection="BIC",
                                 nrep=1, niter=1000, cores = 1, featsToFit = seq(1, 6)){
  
  if(cores > 1) {
    require(foreach)
    
    doMC::registerDoMC(cores)
    
    temp_list = foreach(i=1:6) %dopar% {
      
      if(i == 1 & i %in% featsToFit ){
        
        dat<-as.numeric(CN_features[["segsize"]][,2])
        list( segsize = fitComponent(dat,seed=seed,model_selection=model_selection,
                                     min_prior=min_prior,niter=niter,nrep=nrep,min_comp=min_comp,max_comp=max_comp) )
        
        # } else if (i == 2 & i %in% featsToFit ) {
        #   
        #   dat<-as.numeric(CN_features[["bp10MB"]][,2])
        #   list( bp10MB = fitComponent(dat,dist="pois",seed=seed,model_selection=model_selection,
        #                               min_prior=min_prior,niter=niter,nrep=nrep,min_comp=min_comp,max_comp=max_comp) )
        #   
      } else if (i == 2 & i %in% featsToFit ) {
        
        dat<-as.numeric(CN_features[["osCN"]][,2])
        list( osCN = fitComponent(dat,dist="pois",seed=seed,model_selection=model_selection,
                                  min_prior=min_prior,niter=niter,nrep=nrep,min_comp=min_comp,max_comp=max_comp) )
        
        # } else if (i == 4 & i %in% featsToFit ) {
        #   
        #   dat<-as.numeric(CN_features[["bpchrarm"]][,2])
        #   list( bpchrarm = fitComponent(dat,dist="pois",seed=seed,model_selection=model_selection,
        #                                 min_prior=min_prior,niter=niter,nrep=nrep,min_comp=min_comp,max_comp=max_comp) )
        #   
        # } else if (i == 4 & i %in% featsToFit ) {
        #   
        #   dat<-as.numeric(CN_features[["changepoint"]][,2])
        #   list( changepoint = fitComponent(dat,seed=seed,model_selection=model_selection,
        #                                    min_prior=min_prior,niter=niter,nrep=nrep,min_comp=min_comp,max_comp=max_comp) )
        #   
      } else if (i == 5 & i %in% featsToFit) {
        
        dat<-as.numeric(CN_features[["copynumber"]][,2])
        list( copynumber = fitComponent(dat,seed=seed,model_selection=model_selection,
                                        nrep=nrep,min_comp=min_comp,max_comp=max_comp,min_prior=0.005,niter=2000) )
        
      }
      
    }
    unlist( temp_list, recursive = FALSE ) 
  } else {
    dat<-as.numeric(CN_features[["segsize"]][,2])
    segsize_mm<-fitComponent(dat,seed=seed,model_selection=model_selection,
                             min_prior=min_prior,niter=niter,nrep=nrep,min_comp=min_comp,max_comp=max_comp)
    
    # dat<-as.numeric(CN_features[["bp10MB"]][,2])
    # bp10MB_mm<-fitComponent(dat,dist="pois",seed=seed,model_selection=model_selection,
    #                         min_prior=min_prior,niter=niter,nrep=nrep,min_comp=min_comp,max_comp=max_comp)
    
    dat<-as.numeric(CN_features[["osCN"]][,2])
    osCN_mm<-fitComponent(dat,dist="pois",seed=seed,model_selection=model_selection,
                          min_prior=min_prior,niter=niter,nrep=nrep,min_comp=min_comp,max_comp=max_comp)
    
    # dat<-as.numeric(CN_features[["bpchrarm"]][,2])
    # bpchrarm_mm<-fitComponent(dat,dist="pois",seed=seed,model_selection=model_selection,
    #                           min_prior=min_prior,niter=niter,nrep=nrep,min_comp=min_comp,max_comp=max_comp)
    
    # dat<-as.numeric(CN_features[["changepoint"]][,2])
    # changepoint_mm<-fitComponent(dat,seed=seed,model_selection=model_selection,
    #                              min_prior=min_prior,niter=niter,nrep=nrep,min_comp=min_comp,max_comp=max_comp)
    
    dat<-as.numeric(CN_features[["copynumber"]][,2])
    copynumber_mm<-fitComponent(dat,seed=seed,model_selection=model_selection,
                                nrep=nrep,min_comp=min_comp,max_comp=max_comp,min_prior=0.005,niter=2000)
    
    list(segsize=segsize_mm,
         # bp10MB=bp10MB_mm,
         osCN=osCN_mm,
         # bpchrarm=bpchrarm_mm,
         # changepoint=changepoint_mm,
         copynumber=copynumber_mm)
  }
}

generateSampleByComponentMatrix_mod<-function(CN_features, all_components=NULL, cores = 1, rowIter = 1000, subcores = 2,
                                              feats = c( "segsize", "bp10MB", "osCN", "changepoint", "copynumber", "bpchrarm" ))
{
  if(is.null(all_components))
  {
    all_components<-readRDS(paste(this_path,"data/component_parameters.rds",sep="/"))
  }
  
  if(cores > 1){
    require(foreach)
    
    
    doMC::registerDoMC(cores)
    
    full_mat = foreach(feat=feats, .combine=cbind) %dopar% {
      calculateSumOfPosteriors(CN_features[[feat]],all_components[[feat]], 
                               feat, rowIter = rowIter, cores = subcores)
    }
  } else {
    if(length(feats) == 1){
      full_mat <- calculateSumOfPosteriors(CN_features[[feats]],all_components[[feats]],feats)
      
    }else{
      full_mat<-do.call('cbind',
        sapply(feats, function(i){
          calculateSumOfPosteriors(CN_features[[i]],all_components[[i]],i)
          # calculateSumOfPosteriors(CN_features[["bp10MB"]],all_components[["bp10MB"]],"bp10MB"),
          # calculateSumOfPosteriors(CN_features[["osCN"]],all_components[["osCN"]],"osCN"),
          # calculateSumOfPosteriors(CN_features[["changepoint"]],all_components[["changepoint"]],"changepoint"),
          # calculateSumOfPosteriors(CN_features[["copynumber"]],all_components[["copynumber"]],"copynumber"),
          # calculateSumOfPosteriors(CN_features[["bpchrarm"]],all_components[["bpchrarm"]],"bpchrarm"))
        }))
    }
  }
  
  rownames(full_mat)<-unique(CN_features[["segsize"]][,1])
  full_mat[is.na(full_mat)]<-0
  full_mat
}


generateSignatures_mod <- function(sample_by_component,nsig,seed=77777,nmfalg="brunet", cores=1, nrun_arg=1000){
  NMF::nmf(t(sample_by_component),nsig,seed=seed,nrun=nrun_arg,method=nmfalg,.opt = paste0("p", cores), )
}