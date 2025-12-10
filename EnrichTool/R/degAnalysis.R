#' @description
#' Find differentially expressed genes with DESeq2.
#'
#' @param count_data A matrix or data frame with raw counts.
#'   Rows are genes, columns are samples.
#' @param group A vector with the group label for each sample
#'   (for example c("A","A","B","B")).
#' @param alpha FDR cut-off for padj. Default is 0.05.
#' @param lfc_cutoff Minimum |log2 fold change| to keep. Default is 1.
#'
#' @return A data frame with one row per gene and the columns:
#'   gene, log2FoldChange, pvalue and padj.
#'
#' @examples
#' # deg <- degAnalysis(my_counts, my_group)
#'
#' @export
degAnalysis <- function(count_data, group, alpha = 0.05, lfc_cutoff = 1) {

  # check that DESeq2 is available
  if (!requireNamespace("DESeq2", quietly = TRUE)) {
    stop("Package 'DESeq2' is needed but not installed.")
  }

  # make a small data frame with the group information
  col_data <- data.frame(group = factor(group))
  rownames(col_data) <- colnames(count_data)

  # build DESeq2 object from the raw counts
  dds <- DESeq2::DESeqDataSetFromMatrix(
    countData = round(count_data),  # counts must be integers
    colData   = col_data,
    design    = ~ group
  )

  # run the DESeq2 pipeline (size factors, dispersion, tests, etc.)
  dds <- DESeq2::DESeq(dds)

  # get results: log2FC, p-value, padj
  res    <- DESeq2::results(dds)
  res_df <- as.data.frame(res)

  # add gene names as a column
  res_df$gene <- rownames(res_df)

  # keep only useful columns and remove NAs
  res_df <- res_df[, c("gene", "log2FoldChange", "pvalue", "padj")]
  res_df <- res_df[!is.na(res_df$padj), ]

  # apply cut-offs: FDR < alpha and big enough |log2FC|
  keep <- res_df$padj < alpha & abs(res_df$log2FoldChange) >= lfc_cutoff
  res_df[keep, ]
}

