Filename = "test.txt"
peptide = read.table(Filename, na.strings = " ", header = TRUE)
peptide$Uniprot = substr(peptide$Uniprot, start = 4, stop = 9)
peptide$Peptide = gsub(pattern = "C",
                       replacement = "C$",
                       x = peptide$Peptide)

# ¡°$¡± works as an intermediary
peptide$Peptide = sub(
  pattern = "C$",
  replacement = "C*",
  x = peptide$Peptide ,
  fixed = TRUE
)
# "*" is the marker you want to add behind the exact amino acid, in the e.g. we use Cysteine(C)
for (i in c(1:length(peptide$Uniprot))) {
  if (grepl("$", peptide[i, 3], fixed = TRUE)) {
    peptide = peptide[-i, ]
    
    i = i + 1
  }
}
peptide
write.table(peptide,
            file = "output.txt",
            row.names = FALSE,
            quote = FALSE)

