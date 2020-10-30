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

# Prepare dataframe to contain two columns: Meldedatum, Faelle
agegroup_0_4 <- Prepare_data_faelle(agegroup_0_4)
agegroup_5_14 <- Prepare_data_faelle(agegroup_5_14)
agegroup_15_34 <- Prepare_data_faelle(agegroup_15_34)
agegroup_35_59 <- Prepare_data_faelle(agegroup_35_59)
agegroup_60_79 <- Prepare_data_faelle(agegroup_60_79)
agegroup_80 <- Prepare_data_faelle(agegroup_80)

# Add column with Indizenz
agegroup_0_4 <- Calculate_Inzidenz(agegroup_0_4, Einwohnerzahl_0_4)
agegroup_5_14 <- Calculate_Inzidenz(agegroup_5_14, Einwohnerzahl_5_14)
agegroup_15_34 <- Calculate_Inzidenz(agegroup_15_34, Einwohnerzahl_15_34)
agegroup_35_59 <- Calculate_Inzidenz(agegroup_35_59, Einwohnerzahl_35_59)
agegroup_60_79 <- Calculate_Inzidenz(agegroup_60_79, Einwohnerzahl_60_79)
agegroup_80  <- Calculate_Inzidenz(agegroup_80 , Einwohnerzahl_80)


# Plot data
p <- ggplot(agegroup_0_4, aes(x=Meldedatum, y=Inzidenz)) +
        geom_line() + 
        ggtitle("7-Tage-Inzidenz 0-4 Jahre")
        xlab("")
p

p <- ggplot(agegroup_5_14, aes(x=Meldedatum, y=Inzidenz)) +
        geom_line() + 
        ggtitle("7-Tage-Inzidenz 15-14 Jahre")
        xlab("")
p

p <- ggplot(agegroup_15_34, aes(x=Meldedatum, y=Inzidenz)) +
        geom_line() + 
        ggtitle("7-Tage-Inzidenz 15-34 Jahre")
        xlab("")
p

p <- ggplot(agegroup_35_59, aes(x=Meldedatum, y=Inzidenz)) +
        geom_line() + 
        ggtitle("7-Tage-Inzidenz 35-59 Jahre")
        xlab("")
p

p <- ggplot(agegroup_60_79, aes(x=Meldedatum, y=Inzidenz)) +
        geom_line() + 
        ggtitle("7-Tage-Inzidenz 60-79 Jahre")
        xlab("")
p

p <- ggplot(agegroup_80, aes(x=Meldedatum, y=Inzidenz)) +
        geom_line() + 
        ggtitle("7-Tage-Inzidenz 80+ Jahre")
        xlab("")
p