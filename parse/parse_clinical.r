require(readr)

# Read in file as data frame
clinical_data <- as.data.frame(read_tsv('~/Documents/BreastCancer_TK1/GSE62944_06_01_15_TCGA_24_548_Clinical_Variables_9264_Samples.txt'))

# File of BRCA patient IDs
brca_IDs <- as.data.frame(read_tsv('~/Documents/BreastCancer_TK1/brca_patients.tsv'))

# Set first column as row names and delete first three columns
rownames(clinical_data) <- clinical_data$X1
clinical_data <- clinical_data[-c(1:3)]

# Extract BRCA patient IDs only (cols) and ER, HER2, PR (rows)
clinical_data <- clinical_data[, names(clinical_data)[names(clinical_data) %in% brca_IDs$Patient]]
clinical_data <- clinical_data[c("er_status_by_ihc", "her2_status_by_ihc", "pr_status_by_ihc"),]

# Transpose data frame and create new column names
clinical_data <- t(clinical_data)
clinical_data <- cbind(rownames(clinical_data), data.frame(clinical_data, row.names = NULL))
colnames(clinical_data) <- c("Patient", "ER", "HER2", "PR")

# If not "Positve" or "Negative" change word to NA
clinical_data$ER[(clinical_data$ER != "Positive" & clinical_data$ER != "Negative")] <- NA
clinical_data$HER2[(clinical_data$HER2 != "Positive" & clinical_data$HER2 != "Negative")] <- NA
clinical_data$PR[(clinical_data$PR != "Positive" & clinical_data$PR != "Negative")] <- NA

# Remove rows that have NA in any column
clinical_data <- clinical_data[complete.cases(clinical_data),]

# Create TNBC column. If Negative in ER, HER2, and PR, then TRUE. Else, FALSE. 
clinical_data$TNBC <- ifelse(clinical_data$ER == "Negative" & clinical_data$HER2 == "Negative" & clinical_data$PR == "Negative", TRUE, FALSE) 

# Create Status column.
clinical_data$Status <- ifelse(clinical_data$TNBC==TRUE, "TNBC", ifelse(clinical_data$HER2=="Positive", "HER2+", "Other"))

# Write to a new file
write.table(clinical_data, '~/Documents/BreastCancer_TK1/clinical_data.tsv', quote = FALSE, sep = "\t", row.names = FALSE)
