library(ggplot2)
library(dplyr)

source("functions.R")

# Stand 31. Dezember 2019
# https://de.statista.com/statistik/daten/studie/1351/umfrage/altersstruktur-der-bevoelkerung-deutschlands/#professional
Einwohnerzahl_0_4 <- 3961376
Einwohnerzahl_5_14 <- 7429886
Einwohnerzahl_15_34 <- 19117865
Einwohnerzahl_35_59 <- 28918594
Einwohnerzahl_60_79 <- 18057318
Einwohnerzahl_80 <- 5681135
        
# Fetch data
data <- read.csv("https://opendata.arcgis.com/datasets/dd4580c810204019a7b8eb3e0b329dd6_0.csv", stringsAsFactors=FALSE)

# Create df for every agegroup
agegroup_0_4 <- filter(data, Altersgruppe == 'A00-A04')
agegroup_5_14 <- filter(data, Altersgruppe == 'A05-A14')
agegroup_15_34 <- filter(data, Altersgruppe == 'A15-A34')
agegroup_35_59 <- filter(data, Altersgruppe == 'A35-A59')
agegroup_60_79 <- filter(data, Altersgruppe == 'A60-A79')
agegroup_80 <- filter(data, Altersgruppe == 'A80+')

# Subset date and cases
agegroup_0_4_faelle <- select(agegroup_0_4, c(Meldedatum, AnzahlFall))
agegroup_5_14_faelle <- select(agegroup_5_14, c(Meldedatum, AnzahlFall))
agegroup_15_34_faelle <- select(agegroup_15_34, c(Meldedatum, AnzahlFall))
agegroup_35_59_faelle <- select(agegroup_35_59, c(Meldedatum, AnzahlFall))
agegroup_60_79_faelle <- select(agegroup_60_79, c(Meldedatum, AnzahlFall))
agegroup_80_faelle <- select(agegroup_80, c(Meldedatum, AnzahlFall))

# Fix dates
agegroup_0_4_faelle$Meldedatum <- as.POSIXct(agegroup_0_4_faelle$Meldedatum, format="%Y/%m/%d %H:%M:%S")
agegroup_5_14_faelle$Meldedatum <- as.POSIXct(agegroup_5_14_faelle$Meldedatum, format="%Y/%m/%d %H:%M:%S")
agegroup_15_34_faelle$Meldedatum <- as.POSIXct(agegroup_15_34_faelle$Meldedatum, format="%Y/%m/%d %H:%M:%S")
agegroup_35_59_faelle$Meldedatum <- as.POSIXct(agegroup_35_59_faelle$Meldedatum, format="%Y/%m/%d %H:%M:%S")
agegroup_60_79_faelle$Meldedatum <- as.POSIXct(agegroup_60_79_faelle$Meldedatum, format="%Y/%m/%d %H:%M:%S")
agegroup_80_faelle$Meldedatum <- as.POSIXct(agegroup_80_faelle$Meldedatum, format="%Y/%m/%d %H:%M:%S")



# Aggregate data
agegroup_0_4_faelle <- aggregate(agegroup_0_4_faelle["AnzahlFall"], by=agegroup_0_4_faelle["Meldedatum"], sum)
agegroup_5_14_faelle <- aggregate(agegroup_5_14_faelle["AnzahlFall"], by=agegroup_5_14_faelle["Meldedatum"], sum)
agegroup_15_34_faelle <- aggregate(agegroup_15_34_faelle["AnzahlFall"], by=agegroup_15_34_faelle["Meldedatum"], sum)
agegroup_35_59_faelle <- aggregate(agegroup_35_59_faelle["AnzahlFall"], by=agegroup_35_59_faelle["Meldedatum"], sum)
agegroup_60_79_faelle <- aggregate(agegroup_60_79_faelle["AnzahlFall"], by=agegroup_60_79_faelle["Meldedatum"], sum)
agegroup_80_faelle <- aggregate(agegroup_80_faelle["AnzahlFall"], by=agegroup_80_faelle["Meldedatum"], sum)


# Calculate "7-Tage Inzidenz"
agegroup_0_4_faelle <- Calculate_Inzidenz(agegroup_0_4_faelle, Einwohnerzahl_0_4)
agegroup_5_14_faelle <- Calculate_Inzidenz(agegroup_5_14_faelle, Einwohnerzahl_5_14)
agegroup_15_34_faelle <- Calculate_Inzidenz(agegroup_15_34_faelle, Einwohnerzahl_15_34)
agegroup_35_59_faelle <- Calculate_Inzidenz(agegroup_35_59_faelle, Einwohnerzahl_35_59)
agegroup_60_79_faelle <- Calculate_Inzidenz(agegroup_60_79_faelle, Einwohnerzahl_60_79)
agegroup_80_faelle <- Calculate_Inzidenz(agegroup_80_faelle, Einwohnerzahl_80)


# Plot data
p <- ggplot(agegroup_0_4_faelle, aes(x=Meldedatum, y=Inzidenz)) +
        geom_line() + 
        ggtitle("7-Tage-Inzidenz 0-4 Jahre")
        xlab("")
p

p <- ggplot(agegroup_5_14_faelle, aes(x=Meldedatum, y=Inzidenz)) +
        geom_line() + 
        ggtitle("7-Tage-Inzidenz 15-14 Jahre")
        xlab("")
p

p <- ggplot(agegroup_15_34_faelle, aes(x=Meldedatum, y=Inzidenz)) +
        geom_line() + 
        ggtitle("7-Tage-Inzidenz 15-34 Jahre")
        xlab("")
p

p <- ggplot(agegroup_35_59_faelle, aes(x=Meldedatum, y=Inzidenz)) +
        geom_line() + 
        ggtitle("7-Tage-Inzidenz 35-59 Jahre")
        xlab("")
p

p <- ggplot(agegroup_60_79_faelle, aes(x=Meldedatum, y=Inzidenz)) +
        geom_line() + 
        ggtitle("7-Tage-Inzidenz 60-79 Jahre")
        xlab("")
p

p <- ggplot(agegroup_80_faelle, aes(x=Meldedatum, y=Inzidenz)) +
        geom_line() + 
        ggtitle("7-Tage-Inzidenz 80+ Jahre")
        xlab("")
p