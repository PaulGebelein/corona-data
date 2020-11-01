library(ggplot2)
library(dplyr)

source("functions.R")

# Specify Kreis und Einwohnerzahl
Kreis <- "SK Frankfurt am Main"
Einwohnerzahl <- 765000
Einwohnerzahl_D <- 83020000

# Fetch data
# data <- read.csv("https://opendata.arcgis.com/datasets/dd4580c810204019a7b8eb3e0b329dd6_0.csv", stringsAsFactors=FALSE)
data <- read.csv("https://www.arcgis.com/sharing/rest/content/items/f10774f1c63e40168479a1feb6c7ca74/data", stringsAsFactors=FALSE)


# Subset data from Frankfurt
data_kreis <- filter(data, Landkreis == Kreis)

# Prepare data for plot
data_kreis_faelle <- Prepare_data_faelle(data_kreis, "AnzahlFall")
data_kreis_faelle <- Calculate_Inzidenz(data_kreis_faelle, Einwohnerzahl)

data_faelle <- Prepare_data_faelle(data, "AnzahlFall")
data_faelle <- Calculate_Inzidenz(data_faelle, Einwohnerzahl_D)


# Plot
p <- ggplot() + 
        geom_line(data=data_kreis_faelle, aes(x=Meldedatum, y=Inzidenz), color='red') + 
        geom_line(data=data_faelle, aes(x=Meldedatum, y=Inzidenz), color='black')
p
