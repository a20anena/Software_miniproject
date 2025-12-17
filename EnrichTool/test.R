library(EnrichTool)

# Test import_RNA function

data <- import_RNA(
  "E-MTAB-2523.counts.txt",
  "E-MTAB-2523_sample table.txt"
)

# Check structure
names(data)

# Check dimensions of count matrix
dim(data$counts)

# Look at sample metadata
head(data$samples)


# Test filterLowExpressed()


group <- data$samples$disease

filtered_counts <- filterLowExpressed(
  count_data = data$counts,
  group = group
)

dim(data$counts)
dim(filtered_counts)

stopifnot(ncol(filtered_counts) == ncol(data$counts))

head(filtered_counts[, 1:3])


# Test UpdateddegAnalysis.R

deg_res <- degAnalysis(
  count_data = filtered_counts,
  group = data$samples$disease
)

head(deg_res)
dim(deg_res)

head(deg_res)
summary(deg_res$logFC)



# Test ora_res()

library(clusterProfiler)
library(org.Hs.eg.db)

gene_data <- deg_res
rownames(gene_data) <- gene_data$gene

ora <- ora_res(gene_data, key_type = "SYMBOL")

head(as.data.frame(ora$GO))
head(as.data.frame(ora$KEGG))






















#This is an example script on how to run the functions

#Import count data and filter on log 2 cpm
count_table <- import_RNA("Examples/E-MTAB-2523.counts.txt")

#Extract the sample information from sdrf file
sdrf <- data.table::fread("Examples/E-MTAB-2523_sample table.txt")

#Set the group variable and make "healthy" baseline
Patient <- factor(sdrf$individual)
Sample <- sdrf$sample
Disease <- factor(sdrf$disease, levels = c("normal", "carcinoma"))

SampleTable <- data.frame(Sample, Disease, Patient)
SampleTable <- data.frame(SampleTable, row.names = 1)

#Run DEG analysis on the filtered count data and provide the group variable
deg_res <- degAnalysis(count_table, SampleTable$Disease)

#Run ORA (GO and KEGG) on the deg results
ora <- ora_res(deg_res, "SYMBOL")

head(ora$GO)
head(ora$KEGG)

#export result
exportToExcel(deg_res)

#plot enrichment analysis
ora_plot(ora)
