
##' Lena M, 20211109
##' 
##' This script simulates CN values of a derivative genome by using the function simulateSV() once.
##'  The function allows for multiple CN changes. However, if it's used sequentially multiple times,
##'  then the code needs to be changed (for e.g. WGD, I can't think of a way of simulating data without running
##'  simulateSV once, then duplicating the derivative chromosomes, then running simulateSV again to add CN
##'  on top).
##'  
##'  To do:
##'   - add inversions

local <- F
if(local){
  rm(list = ls())
  setwd(dirname(rstudioapi::getSourceEditorContext()$path))
  opt=list()
  opt$name = "ff2bd965-1290-49aa-a2dc-d18a0fb5e431"
  opt$genome = "genome2"
  opt$sigset <- "sigset1"
  opt$num_events <- 20
  # system("touch exposures/dummyname")
}else{
  library(optparse)
  
  option_list = list(
    make_option(c("--name"), type="character", default=NA,
                help="name (uuid)", metavar="character"),
    make_option(c("--num_events"), type="numeric", default=20,
                help="number of events", metavar="numeric"),
    make_option(c("--sigset"), type="character", default=NA,
                help="set of signatures that we are using", metavar="character"),
    make_option(c("--genome"), type="character", default=NA,
                help="name of genome to use", metavar="character"))
  opt_parser = OptionParser(option_list=option_list);
  opt = parse_args(opt_parser);
}


library(BSgenome)
library(RSVSim)
library(reshape2)
library(ggplot2)
source("2_helper_functions.R")
stopifnot(!is.na(opt$sigset))

if(opt$sigset ==  "sigset1"){
  ## signature definitions
  ## one signature that creates tandem duplications
  ## one signature that creates very large duplications
  ## one signature that creates deletions
  #3 see below in code
}

 
exposures <- readLines(paste0("exposures/", opt$sigset, "/", opt$name))
exposures <- as.numeric(exposures)
# exposures <- c(0.2, 0.3, 0.5)
cat('Number of events ', opt$num_events, '\n')
cat('Exposures ', exposures, '\n')
## get number of events created by each signature
num_events_per_sig <- round(exposures*opt$num_events)
order_sigs <- sample(1:length(exposures), size = opt$num_events, prob = exposures, replace = T)

# library(optparse)

if(opt$genome ==  "genome2"){
  name_genome <- "output/genome2/genome2.fa"
}else{
  'Only genome 2 implemented for now'
}
genome <- readBStringSet(name_genome, format="fasta",
                         nrec=-1L, skip=0L, seek.first.rec=FALSE,
                         use.names=TRUE, with.qualities=FALSE)
# for(chr_names in names(genome)){
#   # genome[[chr_names]] <- paste0(paste0('{', 1:nchar(genome[[chr_names]]), '_', chr_names, '}'), collapse='')
#   genome[[chr_names]] <- paste0(paste0('#', 1:nchar(genome[[chr_names]]), chr_names), collapse='')
# }

## make genome diploid
genome <- rep(genome, 2)
names(genome) <- paste0(names(genome), rep(c('a', 'b'), each=length(genome)/2))

genome_list <- list(genome=genome)



# true_ploidies_sim_df_example <- sim_wrapper(dels = 10, ins = 20, dups = 20, genome = genome, output = NA,
#                                             sizeDels = 500, sizeDups = 30)
# true_ploidies_sim_df_example <- melt(true_ploidies_sim_df_example, id.vars=c('cn', 'position'))
# 
# table(true_ploidies_sim_df_example$cn)
# 
# ggplot(true_ploidies_sim_df_example, aes(x=position, xend=position+1, y=cn, yend=cn))+
#   geom_hline(yintercept = 2, lty='dashed', col='blue')+
#   geom_step()+facet_wrap(.~L1, scales = "free_x")+theme_bw()
# 
# dels = 10; ins = 20; dups = 20; genome = genome; output = NA;
# sizeDels = 500; sizeDups = 300
# true_ploidies_sim_df_example2 <- sim_wrapper(dels = 10, ins = 20, dups = 20, genome = genome, output = NA,
#                                             sizeDels = 500, sizeDups = 300)
# true_ploidies_sim_df_example2 <- melt(true_ploidies_sim_df_example2, id.vars=c('cn', 'position'))
# ggplot(true_ploidies_sim_df_example2, aes(x=position, xend=position+1, y=cn, yend=cn))+
#   geom_hline(yintercept = 2, lty='dashed', col='blue')+
#   geom_step()+facet_wrap(.~L1, scales = "free_x")+theme_bw()
# 
# chr1a <- as(data.frame(start=1, end=width(genome[1]), seqnames='1a'), 'GRanges')
# chr2a <- as(data.frame(start=1, end=width(genome[1]), seqnames='1a'), 'GRanges')
# chr3a <- as(data.frame(start=1, end=width(genome[1]), seqnames='1a'), 'GRanges')
# chr4a <- as(data.frame(start=1, end=width(genome[1]), seqnames='1a'), 'GRanges')
# all_chr <-  as(data.frame(start=1, end=width(genome), seqnames=names(genome)), 'GRanges')
# 
# regionsDels_list <- list(chr1a=chr1a,
#                          chr2a=chr2a,
#                          chr3a=chr3a,
#                          chr4a=chr4a,
#                          all_chr=all_chr)
#   
# params_multirun <- expand.grid(dels = 20, dups = 30, genome = 'genome', output = NA,
#             sizeDels = c(100, 500), sizeDups = c(200, 300),
#             regionsDels = c('chr1a', 'chr2a', 'chr3a', 'chr3a', 'chr4a'), stringsAsFactors = F)
# params_multirun <- params_multirun[rep(1:nrow(params_multirun), each=5),]
# 
# 
# give_objs <- function(j){
#   j$genome <- get(j$genome)
#   j$regionsDels <- get(j$regionsDels)
#   j$dels <- as.numeric(j$dels)
#   j$dups <- as.numeric(j$dups)
#   j$sizeDels <- as.numeric(j$sizeDels)
#   j$sizeDups <- as.numeric(j$sizeDups)
#   j
# }
# 
# runs_outputexpand <- apply(params_multirun, 1, function(i){
#   # give_objs(as.list(i))
#   try(do.call(what = 'sim_wrapper', args = give_objs(as.list(i))))
# })
# 
# table(sapply(runs_outputexpand, typeof))
# keep_runs <- sapply(runs_outputexpand, typeof) == "list"
# runs_outputexpand <- runs_outputexpand[keep_runs]

# plot_sim_genome(runs_outputexpand[[1]])


## get segments


# runs_outputexpand_segments <- lapply(runs_outputexpand, get_segments)
# runs_outputexpand_segments
# 
# plot_sim_genome(runs_outputexpand[[2]])
# 
# df_results <- cbind.data.frame(params_multirun[keep_runs,],
#                                num_segments=sapply(runs_outputexpand_segments, nrow),
#                                averagecn=sapply(runs_outputexpand_segments, function(i){
#                                  sum((i[,c(2)]-i[,c(1)])*i[,'cn'])/sum(i[,c(2)]-i[,c(1)])}
#                                 ))
# 
# apply(df_results, 2, table)
# ggplot(df_results, aes(y=num_segments, x=sizeDups))+geom_point()
# ggplot(df_results, aes(y=num_segments, x=averagecn, col=sizeDups, group=sizeDups))+geom_point()+theme_bw()#+
# #  geom_smooth()
# ggplot(df_results, aes(y=num_segments, x=sizeDels))+geom_point()
# ggplot(df_results, aes(y=regionsDels, x=sizeDups, fill=averagecn))+geom_tile()
# 
# ## get mixtures of features of segments
# 
# runs_outputexpand_segments_rbind <- do.call('rbind', runs_outputexpand_segments)
# runs_outputexpand_segments_rbind$sample <- rep(1:length(runs_outputexpand_segments), sapply(runs_outputexpand_segments, nrow))
# 
# segment_length <- runs_outputexpand_segments_rbind$end - runs_outputexpand_segments_rbind$start
# CN_changepoint <- lapply(unique(runs_outputexpand_segments_rbind$sample), function(sample_it){
#   do.call('c', sapply(unique(runs_outputexpand_segments_rbind$chrom), function(chrom_it){
#     .x <- runs_outputexpand_segments_rbind[runs_outputexpand_segments_rbind$sample == sample_it & 
#                                        runs_outputexpand_segments_rbind$chrom == chrom_it,]
#     abs(.x[-1,'cn']-.x[-nrow(.x),'cn'])}))
# })
# hist(unlist(CN_changepoint))
# 
# ## get mixture model components
# unlist(CN_changepoint)
# segment_length

## get sum of posteriors

## get signatures

##-------------------------------------------------------------------------------------##

## get hashtable
# starting_pos <- sapply(genome, length)
levels_chrom <- names(genome)
# names(starting_pos) <- names(genome)
# genome_hash <- 1:sum(sapply(genome, length))
# genome_hash

sim_genome_forwards <- function(which_type_mut, manual_run=F){
  
  .current_genome <- genome
  previous_genome_hash <- 1:sum(sapply(.current_genome, length))
  muts_it <- 1
  
  while(muts_it < (1+opt$num_events)){
    cat('Mutation round #', muts_it, "\n")
    .previous_genome <- .current_genome
    
    cat('Length of genome ', sum(sapply(.previous_genome, length)), '\n')
    cat('Length of hash ', length(previous_genome_hash), '\n')
    stopifnot(sum(sapply(.previous_genome, length)) == length(previous_genome_hash))
    
  
    if(manual_run){
      ## if we are not using signatures, and we want all mutations to be of the same type
      assign(x = which_type_mut,  value = T)
    }else{
      ## simulating with signatures
      ## which signature to simulate from?
      if(opt$sigset == "sigset1"){
        if(order_sigs[muts_it] == 1){
          ## one signature that creates tandem duplications
          del <- F; ins <- F; dup <- T; inv <- F
          arg_sizeDups <- 90
          arg_maxDups <- 10 ## default
        }else if(order_sigs[muts_it] == 2){
          ## one signature that creates very large duplications
          del <- F; ins <- F; dup <- T; inv <- F
          arg_sizeDups <- 400
          arg_maxDups <- 2
        }else if(order_sigs[muts_it] == 3){
          ## one signature that creates deletions      
          del <- T; ins <- F; dup <- F; inv <- F
          arg_sizeDels <- 200
        }else{
          stop('Incorrect signature index\n')
        }
        if(opt$sigset == "sigset2"){
          ## two signatures
          if(order_sigs[muts_it] == 1){
            
            ## small tandem duplications
            del <- F; ins <- F; dup <- T; inv <- F
            arg_sizeDups <- 10
            arg_maxDups <- 4
            
          }else if(order_sigs[muts_it] == 2){
            
            ## large duplications
            
            del <- F; ins <- F; dup <- T; inv <- F
            arg_sizeDups <- 500
            arg_maxDups <- 1
            
          }
        }
    }

  
    if(sum(c(del, ins, dup, inv)) != 1){
      stop('Select only one from <del, ins, dup, inv>\n')
    }
    
    if(del){
      try({
        derivative_genome_res <- sim_wrapper(dels = 1, ins = 0, dups=0, genome = .current_genome, output = NA,
                                                   sizeDels = arg_sizeDels, return_derivative_genome = T)
      })
    }
    
    if(ins){
      try({    derivative_genome_res <- sim_wrapper(dels = 0, ins = 1, dups=0, genome = .current_genome, output = NA,
                                           sizeIns=100, return_derivative_genome = T)
      })
    }
    
    if(dup){
      try({
      derivative_genome_res <- sim_wrapper(dels = 0, ins = 0, dups=1, genome = .current_genome, output = NA,
                                           sizeDups=arg_sizeDups, maxDups=arg_maxDups, return_derivative_genome = T)
      })
    }
      
    if(typeof(derivative_genome_res) != "character"){
      
      derivative_genome_res[[1]]@metadata
      
      .current_genome <- derivative_genome_res[[1]]
      current_meta <- .current_genome@metadata
      previous_meta <- .previous_genome@metadata
      starting_pos <- sapply(.previous_genome, length)
      
      if(del){
        ## if it's a deletion
        idx_for_hash <- (max(0, sum(starting_pos[1:which(levels_chrom == current_meta[[1]]$Chr)-1])))
        .vec_for_hash <-  previous_genome_hash
        sum(is.na(.vec_for_hash))
        .vec_for_hash[(current_meta[[1]]$Start+idx_for_hash): (current_meta[[1]]$End+idx_for_hash)] <- NA
        sum(is.na(.vec_for_hash))
        genome_hash <- .vec_for_hash[!is.na(.vec_for_hash)]
      }else if(ins){
        ## there are multiple chromosomes (ChrA and ChrB) in current_meta
        ## the positions are moved from one chromosome to another. The hash table does change, because
        ## although no information is lost, the indices have changed
  
        sum(sapply(.current_genome, length))
        sum(sapply(genome, length))
        
        idx_for_hashA <- (max(0, sum(starting_pos[1:which(levels_chrom == current_meta[[1]]$ChrA)-1])))
        idx_for_hashB <- (max(0, sum(starting_pos[1:which(levels_chrom == current_meta[[1]]$ChrB)-1])))
        
        # sum(is.na(genome_hash))
        # length(genome_hash)
        genome_hash <- previous_genome_hash ## there is no change in the length of the hash
        genome_hash[(current_meta[[1]]$StartB+idx_for_hashB): (current_meta[[1]]$EndB+idx_for_hashB)] <- previous_genome_hash[(current_meta[[1]]$StartA+idx_for_hashA): (current_meta[[1]]$EndA+idx_for_hashA)]
        genome_hash[(current_meta[[1]]$StartA+idx_for_hashA): (current_meta[[1]]$EndA+idx_for_hashA)] <- previous_genome_hash[(current_meta[[1]]$StartB+idx_for_hashB): (current_meta[[1]]$EndB+idx_for_hashB)]
        
      }else if(dup){
        ## each position is duplicated a number of times. These are tandem duplications so they appear one after the other
        
        if(!grepl("tandemDuplication", current_meta[[1]]$Name)){
          warning('These duplications are not tandem duplications - check code')
        }
        
        idx_for_hash <- (max(0, sum(starting_pos[1:which(levels_chrom == current_meta[[1]]$Chr)-1])))
        genome_hash <- 1:sum(sapply(.current_genome, length))
        cat('The length of the previous genome is ', length(previous_genome_hash), '\n')
        cat('The length of the genome is ', length(genome_hash), '\n')
        
        length(.current_genome)
        length(.previous_genome)
        sum(sapply(.current_genome, length)) - sum(sapply(.previous_genome, length))
        sum(sapply(.previous_genome, length))
        length(previous_genome_hash)
        
        if(sum(sapply(.current_genome, length)) == sum(sapply(.previous_genome, length))){
          ## I don't know why RSVsim sometimes doesn't simulate tandem duplications
          cat('RSVSim has not added the tandem duplications. Skipping mutation round.\n')
        }else{
          idx_in_tandem_original <- ( (current_meta[[1]]$Start+idx_for_hash): (current_meta[[1]]$Start+current_meta[[1]]$Size+idx_for_hash-1 ) )
          idx_in_tandem <- ( (current_meta[[1]]$Start+current_meta[[1]]$Size+idx_for_hash): (current_meta[[1]]$Start+current_meta[[1]]$Size+current_meta[[1]]$Size*(current_meta[[1]]$Duplications)+idx_for_hash-1) )
          if(length(genome_hash[-idx_in_tandem]) != length(previous_genome_hash)){
            stop('Problem with -idx_in_tandem')
          }
          genome_hash[-idx_in_tandem] <- previous_genome_hash
          add_dups <- rep(previous_genome_hash[idx_in_tandem_original], current_meta[[1]]$Duplications)
          if(length(genome_hash[idx_in_tandem]) != length(add_dups)){
            stop('Problem with idx_in_tandem')
          }
          genome_hash[idx_in_tandem] <- add_dups
        }
      }
      
      # genome_hash
      # 
      # sapply(.current_genome, length)
      # sapply(.previous_genome, length)
      cat('Length of genome ', sum(sapply(.current_genome, length)), '\n')
      cat('Length of hash ', length(genome_hash), '\n')
      stopifnot(sum(sapply(.current_genome, length)) == length(genome_hash))
      
      previous_genome_hash <- genome_hash
      
    }else{
      warning('Mutation could not be added in this round\n\t ("Sorry, not possible to find a spot on the genome, which is large enough for SV of size 500bp,\n\t given the current parameter settings.")\n')
    }
    
    muts_it <- muts_it+1
  
  }
  return(genome_hash)
}


genome_derivative <- sim_genome_forwards(which_type_mut = NA, manual_run=F)

system(paste0("mkdir -p ", "output/output_genome2//outputRSVSim/", opt$sigset, "/"))
out_file <- paste0("output/output_genome2/outputRSVSim/", opt$sigset, "/", opt$name, ".RDS")
cat('Saving output file ', out_file, '\n')
saveRDS(genome_derivative, file = out_file)

sim_single_mut_type <- F

if(sim_single_mut_type){
  genome_hash_del <- sim_genome_forwards('del', manual_run=T)
  genome_hash_dup <- sim_genome_forwards('dup', manual_run=T)
  genome_hash_ins <- sim_genome_forwards('ins', manual_run=T)
  
  dev.off()
  par(mfrow=c(1,3))
  plot_from_hash(genome_hash_del, main='Del', type='h') ## decreased CN
  plot_from_hash(genome_hash_dup, main='Dup', type='h') ## increased CN
  plot_from_hash(genome_hash_ins, main='Ins', type='h') ## no changes in CN
  
  
  table(give_cn_from_hash(genome_hash_dup) > 2)
  
  .xx <- (plot_from_hash_2(genome_hash_dup))
  plot_sim_genome(plot_from_hash_2(genome_hash_del))
  plot_sim_genome(plot_from_hash_2(genome_hash_ins))
  plot_sim_genome(plot_from_hash_2(genome_hash_dup))
  
  # plot_sim_genome <- function(true_ploidies_sim_df_example2){
  #   true_ploidies_sim_df_example2 <- melt(true_ploidies_sim_df_example2, id.vars=c('cn', 'position'))
  # plot_sim_genome
  
}
