require(readr)

# Read in file as data frame
brca_IDs <- as.data.frame(read_tsv('~/Documents/BreastCancer_TK1/GSE62944_06_01_15_TCGA_24_CancerType_Samples.txt'))

# Name columns
colnames(brca_IDs) <- c("Patient", "CancerType")

# Find patient IDs with Breast Cancer ("BRCA")
brca_IDs <- brca_IDs[grep("BRCA", brca_IDs$Cancer), ]

# Write to a new file
write.table(brca_IDs, '~/Documents/BreastCancer_TK1/brca_IDs.tsv', quote = FALSE, sep = "\t", row.names = FALSE)