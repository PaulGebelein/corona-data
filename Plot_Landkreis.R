library(ggplot2)
library(dplyr)

source("functions.R")

# Specify Kreis und Einwohnerzahl
Kreis <- "SK Frankfurt am Main"
Einwohnerzahl <- 765000

# Subset data from Frankfurt
data_kreis <- filter(RKI_csv, Landkreis == Kreis)

# Prepare data for plot
df_faelle <- Prepare_data_faelle(data_kreis, "AnzahlFall")
df_faelle <- Calculate_Inzidenz(df_faelle, Einwohnerzahl)

df_todesFaelle <- Prepare_data_faelle(data_kreis, "AnzahlTodesfall")


# Plot data
p <- ggplot(df_faelle, aes(x=Meldedatum, y=AnzahlFall)) +
        geom_line() + 
        xlab("")
p

q <- ggplot(df_todesFaelle, aes(x=Meldedatum, y=AnzahlTodesfall)) +
        geom_line() + 
        xlab("")
q

r <- ggplot(df_faelle, aes(x=Meldedatum, y=Inzidenz)) +
        geom_line() + 
        xlab("")
r
