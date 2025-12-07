filterLowExpressed <- function(count_data, min_count = 10) {
  # Remove low-expressed genes
  keep <- rowSums(count_data) >= min_count
  filtered_data <- count_data[keep, ]
  return(filtered_data)
}
