#' importRna
#'
#' @description
#' Imports RNA-seq count data and performs filtering on log2 CPM
#'
#' @param file RNA-seq count file.
#' @param cutoff Cutoff value for filtering rows with low expression
#'
#' @return Filtered RNA-seq count data.
#'
#' @export
#'
#' @example
#' library(EnrhichTool)
#' importRna("path/to/file.txt", 1)
#'
importRna <- function(file, cutoff){
  mat <- read.table(file, header=TRUE, as.is=TRUE, row.names=1, sep="\t")

  meanLog2cpm <- rowMeans(log2(edgeR::cpm(mat) + 1))

  mat <- mat[meanLog2cpm > cutoff,]

  return(mat)
}
