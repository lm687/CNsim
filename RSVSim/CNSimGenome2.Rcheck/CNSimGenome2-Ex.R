pkgname <- "CNSimGenome2"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('CNSimGenome2')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("package")
### * package

flush(stderr()); flush(stdout())

### Name: CNSimGenome2
### Title: Simulated genome for CN signature validation (#2)
### Aliases: CNSimGenome2-package CNSimGenome2 CNSimGenome2
### Keywords: package data

### ** Examples

CNSimGenome2
genome <- CNSimGenome2
head(seqlengths(genome))


## ---------------------------------------------------------------------
## Genome-wide motif searching
## ---------------------------------------------------------------------
## See the GenomeSearching vignette in the BSgenome software
## package for some examples of genome-wide motif searching using
## Biostrings and the BSgenome data packages:
if (interactive())
    vignette("GenomeSearching", package="BSgenome")



### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
