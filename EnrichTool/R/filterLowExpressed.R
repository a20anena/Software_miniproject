#' Filter low expressed genes
#'
#' This function removes genes with very low expression levels
#' before differential expression analysis.
#' It uses edgeR's recommended filtering approach.
#'
#' @param count_data Raw count matrix (genes x samples)
#' @param group Group labels for each sample
#'
#' @return Filtered count matrix
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
