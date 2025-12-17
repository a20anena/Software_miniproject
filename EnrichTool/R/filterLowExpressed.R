#' Filter low expressed genes
#'
#' This function removes genes with very low expression levels
#' before differential expression analysis.
#' It uses edgeR's recommended filtering approach.
#'
#' @param count_data Raw count matrix (genes x samples)
#' @param Group labels for each sample (length = number of columns in count_data)
#'
#' @return Filtered count matrix
#' @examples
#' # data was created with import_RNA()
#' filtered_counts <- filterLowExpressed(
#'   count_data = data$counts,
#'   group = data$samples$disease
#' )
#' dim(filtered_counts)

#'
#' @export
filterLowExpressed <- function(count_data, group) {

  if (!requireNamespace("edgeR", quietly = TRUE)) {
    stop("edgeR package is required.")
  }

  group <- factor(group)

  y <- edgeR::DGEList(counts = count_data, group = group)

  keep <- edgeR::filterByExpr(y)

  count_data[keep, ]
}
