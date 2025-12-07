filterLowExpressed <- function(count_data, min_count = 10) {

  # remove genes that don't have enough counts
  keep <- rowSums(count_data) >= min_count
  
  # keep only the rows that passed the filter
  filtered_data <- count_data[keep, ]
  
  return(filtered_data)
}
