library(dplyr)
library(googlesheets4)
library(data.table)
library(stringr)

#############################################
## script created by Audrey Arner          ## 
#############################################

count_dir <- "/filepath/counts" #directory is where your htseq-count output files are located.

count_files <- list.files(count_dir, full.names = TRUE) 
count_files <- count_files[
  count_files != "/filepath/file_name.Aligned.counts"
]

counts_list <- lapply(count_files, function(file) {
  fread(file, header = FALSE, col.names = c("gene", gsub(".txt$", "", basename(file))))
})

counts_matrix <- Reduce(function(...) merge(..., by = "gene"), counts_list)

# Convert to data frame if needed
counts_matrix <- as.data.frame(counts_matrix)
rownames(counts_matrix) <- counts_matrix$gene
counts_matrix <- counts_matrix[, -1]  # Drop gene column

column_names <- colnames(counts_matrix)

# Extract numbers after "TID"
colnames(counts_matrix) <- as.numeric(str_extract(column_names, "(?<=TID)\\d+"))

# View updated column names
print(colnames(counts_matrix))

write.table(counts_matrix)
