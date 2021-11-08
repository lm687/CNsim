###
###

.pkgname <- "CNSimGenome3"

.seqnames <- c(paste0("chr",1:4))

.circ_seqs <- character(0)

.mseqnames <- NULL

.onLoad <- function(libname, pkgname)
{
    if (pkgname != .pkgname)
        stop("package name (", pkgname, ") is not ",
             "the expected name (", .pkgname, ")")
    extdata_dirpath <- system.file("extdata", package=pkgname,
                                   lib.loc=libname, mustWork=TRUE)

    ## Make and export BSgenome object.
    bsgenome <- BSgenome(
        organism="none",
        common_name="none",
        genome="GRCh37",
        provider="LM",
        release_date="2021",
        source_url="none",
        seqnames=.seqnames,
        circ_seqs=.circ_seqs,
        mseqnames=.mseqnames,
        seqs_pkgname=pkgname,
        seqs_dirpath=extdata_dirpath
    )

    ns <- asNamespace(pkgname)

    objname <- pkgname
    assign(objname, bsgenome, envir=ns)
    namespaceExport(ns, objname)

    old_objname <- "CNSimGenome3"
    assign(old_objname, bsgenome, envir=ns)
    namespaceExport(ns, old_objname)
}

