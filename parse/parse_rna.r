require(readr)

# Read in file as data frame
rna_data <- as.data.frame(read_tsv('~/Documents/breastcancer/GSM1536837_06_01_15_TCGA_24.tumor_Rsubread_FeatureCounts.txt'))

# File of BRCA patient IDs
brca_IDs <- as.data.frame(read_tsv('~/Documents/breastcancer/brca_patients.tsv'))

# Set first column as row names
rownames(rna_data) <- rna_data$X1

# Extract BRCA patient IDs only
rna_data <- rna_data[, names(rna_data)[names(rna_data) %in% brca_IDs$Patient]]

# Write to a new file
write.table(rna_data, '~/Documents/breastcancer/rnaseq_brca.tsv', quote = FALSE, sep = "\t")#, row.names = FALSE)