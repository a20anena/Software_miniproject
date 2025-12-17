
#' Import RNA-seq count data and sample information
#'
#' This function reads RNA-seq count data and a sample table from files.
#' It only imports the data and does not perform filtering or analysis.
#'
#' @param count_file Path to the RNA-seq count file (tab-separated).
#'   Rows = genes, columns = samples.
#' @param sample_file Path to the sample metadata file (tab-separated).
#'
#' @return A list with two elements:
#'   counts  - count matrix
#'   samples - sample metadata
#'
#' @examples
#' # data <- import_RNA("counts.txt", "samples.txt")

#' @export
import_RNA <- function(count_file, sample_file) {
  
  counts <- read.table(
    count_file,
    header = TRUE,
    row.names = 1,
    sep = "\t",
    check.names = FALSE
  )
  
  samples <- read.table(
    sample_file,
    header = TRUE,
    sep = "\t",
    stringsAsFactors = FALSE
  )
  
  list(
    counts = counts,
    samples = samples
  )
}


