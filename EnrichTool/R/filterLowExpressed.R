#' @description
#' This function removes genes that have very low counts.
#' It checks how many counts each gene has in total, and if it's too small,
#' the gene is filtered out. This helps clean up the dataset before doing
#' any analysis.
#'
#' @param count_data A data frame containing gene counts.
#' Each row is a gene and each column is a sample.
#'
#' @param min_count The minimum total count a gene must have.
#' Genes below this number are removed. Default is 10.
#'
#' @return A filtered version of the data frame where only genes with
#' enough counts are kept.
#'
#' @examples
#' filtered <- filterLowExpressed(my_counts, min_count = 10)
#'
#' @export
filterLowExpressed <- function(count_data, min_count = 10) {

  # remove genes that don't have enough counts
  keep <- rowSums(count_data) >= min_count

  # keep only the rows that passed the filter
  filtered_data <- count_data[keep, ]

  return(filtered_data)
}
