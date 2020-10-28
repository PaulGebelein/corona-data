library(ggplot2)
library(dplyr)

# Specify Kreis und Einwohnerzahl
Kreis <- "SK Frankfurt am Main"
Einwohnerzahl <- 750000

# Fetch data
data <- read.csv("https://opendata.arcgis.com/datasets/dd4580c810204019a7b8eb3e0b329dd6_0.csv", stringsAsFactors=FALSE)

# Subset data from Frankfurt
data_kreis <- filter(data, Landkreis == Kreis)

# Subset date and cases
data_kreis_faelle <- select(data_kreis, c(Meldedatum, AnzahlFall))
data_kreis_todesfaelle <- select(data_kreis, c(Meldedatum, AnzahlTodesfall))

# Fix dates
data_kreis_faelle$Meldedatum <- as.POSIXct(data_kreis_faelle$Meldedatum, format="%Y/%m/%d %H:%M:%S")
data_kreis_todesfaelle$Meldedatum <- as.POSIXct(data_kreis_todesfaelle$Meldedatum, format="%Y/%m/%d %H:%M:%S")

# Aggregate data
data_kreis_faelle <- aggregate(data_kreis_faelle["AnzahlFall"], by=data_kreis_faelle["Meldedatum"], sum)
data_kreis_todesfaelle <- aggregate(data_kreis_todesfaelle["AnzahlTodesfall"], by=data_kreis_todesfaelle["Meldedatum"], sum)


# Calculate "7-Tage Inzidenz"
data_kreis_faelle["Inzidenz"] <- NA
rows <- nrow(sum_data_kreis)
rowcount <- c(7:rows)

for (i in rowcount) {
        temp <- data_kreis_faelle[(i-6):i, "AnzahlFall"]
        temp <- sum(temp)
        temp <- temp/(Einwohnerzahl/100000)
        data_kreis_faelle[i, "Inzidenz"] <- temp
}

# Plot data
p <- ggplot(data_kreis_faelle, aes(x=Meldedatum, y=AnzahlFall)) +
        geom_line() + 
        xlab("")
p

q <- ggplot(data_kreis_todesfaelle, aes(x=Meldedatum, y=AnzahlTodesfall)) +
        geom_line() + 
        xlab("")
q

r <- ggplot(data_kreis_faelle, aes(x=Meldedatum, y=Inzidenz)) +
        geom_line() + 
        xlab("")
r
