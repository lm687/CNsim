## I simulate in the same way of Nature reviewer #3

local <- F
if(local){
  rm(list = ls())
  setwd(dirname(rstudioapi::getSourceEditorContext()$path))
}
set.seed(234)

library(ggplot2)
library(reshape2)
library(gridExtra)
library(MCMCpack)
library(pheatmap)
library(NMF)
library(dendextend)

append_name = "ex2"

## two features with several components
## simulate three signatures

f1s1 <- c(0.0, 0.0, 0.2, 0.3, 0.4, 0.1, 0.0, 0.0)
f1s2 <- c(0.8, 0.1, 0.1, 0.0, 0.0, 0.0, 0.0, 0.0)
f1s3 <- c(0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.7, 0.2)

f1 <- cbind.data.frame(f1s1, f1s2, f1s3)
f1$id <- 1:length(f1s1)

f2s1 <- c(0.1, 0.4, 0.4, 0.1)
f2s2 <- c(0.1, 0.4, 0.4, 0.1)
f2s3 <- c(0.1, 0.4, 0.4, 0.1)
f2 <- cbind.data.frame(f2s1, f2s2, f2s3)
f2$id <- 1:length(f2s1)

stopifnot( all(colSums(f1[,-ncol(f1)]) == 1) & all(colSums(f2[,-ncol(f2)]) == 1) )

## create samples by sampling from signatures
## (this omits that from one cn more than one can be created, etc. sort of infinite sites assumption)

nsamples <- 100
## we sample exposures from a dirichlet
exposures_true <- MCMCpack::rdirichlet(n = nsamples, alpha = c(1, 1, 1))
pheatmap::pheatmap(exposures_true)

source("run_simulation_nature_reject.R")

