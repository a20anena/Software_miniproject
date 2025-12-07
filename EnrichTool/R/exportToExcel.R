# export results to an Excel file

# this function takes a data frame and saves it as an .xlsx file
exportToExcel <- function(results, file_name = "results.xlsx") {

  # check if the openxlsx package is available
  # (we need it to write Excel files)
  if (!requireNamespace("openxlsx", quietly = TRUE)) {
    stop("The 'openxlsx' package is not installed.")
  }

  # save the data to the Excel file
  openxlsx::write.xlsx(results, file = file_name)

  # tell the user the file was created
  return(paste("File saved as", file_name))
}

