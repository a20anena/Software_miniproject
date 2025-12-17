#' Differential expression analysis with edgeR
#'
#' This function runs a standard edgeR workflow to find genes that are
#' differentially expressed between two groups (e.g. cancer vs normal).
#'
#' @param count_data A matrix/data.frame of raw read counts.
#'   Rows = genes, columns = samples. Row names should be gene symbols.
#' @param group A vector with the group label for each sample (same order as columns in count_data).
#'   Example: c("Normal","Normal","Cancer","Cancer")
#' @param alpha FDR cutoff. Default is 0.05.
#' @param lfc_cutoff Minimum absolute log2 fold change. Default is 1.
#'
#' @return A data.frame with significant genes and these columns:
#'   gene, logFC, PValue, FDR
#'
#' @examples
#' # deg <- degAnalysis(my_counts, my_group)
#'
#' @export
degAnalysis <- function(count_data, group, alpha = 0.05, lfc_cutoff = 1) {

  if (!requireNamespace("edgeR", quietly = TRUE)) {
    stop("Package 'edgeR' is needed but not installed.")
  }

  group <- factor(group)

  # Build edgeR object
  y <- edgeR::DGEList(counts = count_data, group = group)

  # Library size normalization (TMM)
  y <- edgeR::calcNormFactors(y)

  # Design matrix for two-group comparison
  design <- stats::model.matrix(~ group)

  # Estimate dispersion and fit model
  y <- edgeR::estimateDisp(y, design)
  fit <- edgeR::glmFit(y, design)

  # Test the group effect (2nd coefficient is the group difference)
  lrt <- edgeR::glmLRT(fit, coef = 2)

  # Get full results table
  tab <- edgeR::topTags(lrt, n = Inf)$table
  tab$gene <- rownames(tab)

  # Keep only the columns we need
  tab <- tab[, c("gene", "logFC", "PValue", "FDR")]

  # Apply cutoffs
  keep <- tab$FDR < alpha & abs(tab$logFC) >= lfc_cutoff
  tab[keep, ]
}
