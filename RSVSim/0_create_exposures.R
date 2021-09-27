
rm(list = ls())
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

library(uuid)

for(i in 1:100){
  .uuid <- uuid::UUIDgenerate()
  write(x = paste0("dummy file for run ", .uuid, "\n In the future, add exposures.\n Date created:",
                   Sys.time()), file = paste0("exposures/", .uuid))
}