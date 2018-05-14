require(readr)

# Read in file as data frame
clinical_data <- as.data.frame(read_tsv('~/Documents/breastcancer/GSE62944_06_01_15_TCGA_24_548_Clinical_Variables_9264_Samples.txt'))

# File of BRCA patient IDs
brca_IDs <- as.data.frame(read_tsv('~/Documents/breastcancer/brca_patients.tsv'))

# Set first column as row names and delete first three columns
rownames(clinical_data) <- clinical_data$X1
clinical_data <- clinical_data[-c(1:3)]

# Extract BRCA patient IDs only (cols) and ER, HER2, PR (rows)
clinical_data <- clinical_data[, names(clinical_data)[names(clinical_data) %in% brca_IDs$Patient]]
clinical_data <- clinical_data[c("er_status_by_ihc", "her2_status_by_ihc", "pr_status_by_ihc"),]

# Transpose data frame
clinical_data <- t(clinical_data)
clinical_data <- cbind(rownames(clinical_data), data.frame(clinical_data, row.names = NULL))
colnames(clinical_data) <- c("Patient", "ER", "HER2", "PR")

# Write to a new file
write.table(clinical_data, '~/Documents/breastcancer/er_her2_pr.tsv', quote = FALSE, sep = "\t", row.names = FALSE)
