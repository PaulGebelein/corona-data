library(ggplot2)
library(dplyr)

source("functions.R")

# Specify Kreis und Einwohnerzahl
Kreis <- "SK Frankfurt am Main"
Einwohnerzahl <- 765000
Einwohnerzahl_D <- 83020000

# Subset data from Frankfurt
data_kreis <- filter(RKI_csv, Landkreis == Kreis)

# Prepare data for plot
data_kreis_faelle <- Prepare_data_faelle(data_kreis, "AnzahlFall")
data_faelle <- Prepare_data_faelle(RKI_csv, "AnzahlFall")

# Calculate ratio of cases from Kreis of cases from D
data_ratio <- Calculate_ratio(data_faelle, data_kreis_faelle)

# Calculate 7-Tage-Inzidenz
data_kreis_faelle <- Calculate_Inzidenz(data_kreis_faelle, Einwohnerzahl)
data_faelle <- Calculate_Inzidenz(data_faelle, Einwohnerzahl_D)




# Plot
p <- ggplot() + 
        geom_line(data=data_kreis_faelle, aes(x=Meldedatum, y=Inzidenz), color='red') + 
        geom_line(data=data_faelle, aes(x=Meldedatum, y=Inzidenz), color='black')
p

q <- ggplot() +
        geom_line(data_ratio, aes(x=Meldedatum, y=Ratio)) + 
        ggtitle("Anteil der Fälle im Kreis zu Gesamtdeutschland")
        xlab("")
q