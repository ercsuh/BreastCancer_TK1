require(readr)
library(stringr)
library(dplyr)

# Read in file as data frame
brca_patients <- as.data.frame(read_tsv('~/Documents/breastcancer/GSE62944_06_01_15_TCGA_24_CancerType_Samples.txt'))

colnames(brca_patients) <- c("Patient", "Cancer")

#brca_patients[which(brca_patients$Cancer == "BRCA"),]
brca_patients <- brca_patients[grep("BRCA", brca_patients$Cancer), ]

write.table(brca_patients, '~/Documents/breastcancer/brca_patients.tsv', quote = FALSE, sep = "\t", row.names = FALSE)