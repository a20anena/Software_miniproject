
#' @description
#' Performs over-representation analysis on set of genes.
#'
#' The "gene_data" is a dataframe where rownames are genes. Typically the
#' output of a differentially expressed genes analysis. The rownames are used
#' to convert to entrez id before enrichment.
#'
#' @param gene_data Dataframe where rownames are genes.
#' @param key_type Key type of the genes in the dataframe.
#'
#' @return
#' Ora results.
#'
#' @examples
#' library(EnrichTool)
#' ora_res(deg_res, key_type = "ENSEMBL")
#'
#' @export
#'
#'
ora_res <- function(gene_data, key_type = "ENSEMBL"){

  #Convert to entrez id
  entrez_df <- clusterProfiler::bitr(
                       geneID = rownames(gene_data),
                       fromType = key_type,
                       toType = "ENTREZID",
                       OrgDb = org.Hs.eg.db::org.Hs.eg.db)

  #Extract entrez vector
  entrez_ids <- unique(entrez_df$ENTREZID)

  #GO analysis
  go_res <- clusterProfiler::enrichGO(
    gene = entrez_ids,
    keyType = "ENTREZID",
    pvalueCutoff = 0.05,
    pAdjustMethod = "BH",
    OrgDb = org.Hs.eg.db::org.Hs.eg.db,
    readable = TRUE
  )

  #Kegg analysis
  kegg_res <- clusterProfiler::enrichKEGG(
    gene = entrez_ids,
    organism = "hsa",
    pvalueCutoff = 0.05
  )

  return(list(GO = go_res, KEGG = kegg_res))
}
