library(ggplot2)
library(dplyr)

# Fetch data
data <- read.csv("https://opendata.arcgis.com/datasets/dd4580c810204019a7b8eb3e0b329dd6_0.csv", stringsAsFactors=FALSE)

# Subset data from Frankfurt
data_kreis <- filter(data, Landkreis == "SK Frankfurt am Main")

# Subset date and cases
data_kreis_plot <- select(data_kreis, c(AnzahlFall, Meldedatum))

# Fix dates
data_kreis_plot$Meldedatum <- as.POSIXct(data_kreis_plot$Meldedatum, format="%Y/%m/%d %H:%M:%S")

# Swap columns
data_kreis_plot <- data_kreis_plot[c("Meldedatum", "AnzahlFall")]

# Aggregate data
sum_data_kreis <- aggregate(data_kreis_plot["AnzahlFall"], by=data_kreis_plot["Meldedatum"], sum)

# Plot data
p <- ggplot(sum_data_kreis, aes(x=Meldedatum, y=AnzahlFall)) +
        geom_line() + 
        xlab("")
p
