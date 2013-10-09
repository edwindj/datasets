source("../R/datapackage.R")
geb <- read.csv("Geboorte__kerncijfer_1988_1993.csv", sep=";")
geb <- rbind(geb, read.csv("Geboorte__kerncijfer_1994_1999.csv", sep=";"))
geb <- rbind(geb, read.csv("Geboorte__kerncijfer_1999_2006.csv", sep=";"))
geb <- rbind(geb, read.csv("Geboorte__kerncijfer_2007_2012.csv", sep=";"))

is_gemeente <- !is.na(geb$Gemeente)
geb <- geb[is_gemeente,]
write.csv(geb, "geboorte_kerncijfers.csv", row.names=FALSE, na="")
