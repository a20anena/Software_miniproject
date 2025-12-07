# export results to an Excel file

# this function takes a data frame and saves it as an .xlsx file
exportToExcel <- function(results, file_name = "results.xlsx") {

  # check if the openxlsx package is installed
  # (we need it to actually write Excel files)
  if (!requireNamespace("openxlsx", quietly = TRUE)) {
    stop("The 'openxlsx' package is not installed.")
  }

  # write the data to the Excel file
  openxlsx::write.xlsx(results, file = file_name)

  # let the user know the file was saved
  return(paste("File saved as", file_name))
}
