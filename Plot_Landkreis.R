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
data_kreis_plot <- select(data_kreis, c(AnzahlFall, Meldedatum))

# Fix dates
data_kreis_plot$Meldedatum <- as.POSIXct(data_kreis_plot$Meldedatum, format="%Y/%m/%d %H:%M:%S")

# Swap columns
data_kreis_plot <- data_kreis_plot[c("Meldedatum", "AnzahlFall")]

# Aggregate data
sum_data_kreis <- aggregate(data_kreis_plot["AnzahlFall"], by=data_kreis_plot["Meldedatum"], sum)

# Calculate "7-Tage Inzidenz"
sum_data_kreis["Inzidenz"] <- NA
rows <- nrow(sum_data_kreis)
rowcount <- c(7:rows)

for (i in rowcount) {
        temp <- sum_data_kreis[(i-6):i, "AnzahlFall"]
        temp <- sum(temp)
        temp <- temp/(Einwohnerzahl/100000)
        sum_data_kreis[i, "Inzidenz"] <- temp
}

# Plot data
p <- ggplot(sum_data_kreis, aes(x=Meldedatum, y=AnzahlFall)) +
        geom_line() + 
        xlab("")
p

q <- ggplot(sum_data_kreis, aes(x=Meldedatum, y=Inzidenz)) +
        geom_line() + 
        xlab("")
q
