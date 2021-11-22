
rm(list = ls())
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

library(uuid)

for(i in 1:100){
  .uuid <- uuid::UUIDgenerate()
  write(x = paste0("dummy file for run ", .uuid, "\n In the future, add exposures.\n Date created:",
                   Sys.time()), file = paste0("exposures/", .uuid))
}

## sigset1

for(i in 1:100){
  .uuid <- uuid::UUIDgenerate()
  write(x = paste0(MCMCpack::rdirichlet(1, c(1/3, 1/3, 1/3))), file = paste0("exposures/sigset1/", .uuid))
}

## sigset 2
system("mkdir -p exposures/sigset2/")
for(i in 1:300){
  .uuid <- uuid::UUIDgenerate()
  write(x = paste0(MCMCpack::rdirichlet(1, c(1/3, 1/3))), file = paste0("exposures/sigset2/", .uuid))
}


## sigset 3
system("mkdir -p exposures/sigset3/")
for(i in 1:500){
  .uuid <- uuid::UUIDgenerate()
  write(x = paste0(MCMCpack::rdirichlet(1, c(1/3, 1/3, 1/3, 1/3))), file = paste0("exposures/sigset3/", .uuid))
}

## sigset 4
system("mkdir -p exposures/sigset4/")
for(i in 1:500){
  .uuid <- uuid::UUIDgenerate()
  write(x = paste0(MCMCpack::rdirichlet(1, c(1/3, 1/3, 1/3))), file = paste0("exposures/sigset3/", .uuid))
}

