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


input_data <- data.frame(age_group=c("A00-A04", "A05-A14", "A15-A34", "A35-A59", "A60-A79", "A80+"),
                         Einwohnerzahl=c(Einwohnerzahl_0_4, Einwohnerzahl_5_14, Einwohnerzahl_15_34, Einwohnerzahl_35_59, Einwohnerzahl_60_79, Einwohnerzahl_80))

results <- vector("list", nrow(input_data))


for (i in 1:nrow(input_data)) {
        
        results[[i]] <- filter(RKI_csv, Altersgruppe == input_data[i, "age_group"]) %>%
                        Prepare_data_faelle(., "AnzahlFall") %>%
                        Calculate_Inzidenz(., input_data[i, "Einwohnerzahl"])
}


# Plot data
p <- ggplot(results[[1]], aes(x=Meldedatum, y=Inzidenz)) +
        geom_line() + 
        ggtitle("7-Tage-Inzidenz 0-4 Jahre")
        xlab("")
p

p <- ggplot(results[[2]], aes(x=Meldedatum, y=Inzidenz)) +
        geomline() + 
        ggtitle("7-Tage-Inzidenz 15-14 Jahre")
        xlab("")
p

p <- ggplot(results[[3]], aes(x=Meldedatum, y=Inzidenz)) +
        geom_line() + 
        ggtitle("7-Tage-Inzidenz 15-34 Jahre")
        xlab("")
p

p <- ggplot(results[[4]], aes(x=Meldedatum, y=Inzidenz)) +
        geom_line() + 
        ggtitle("7-Tage-Inzidenz 35-59 Jahre")
        xlab("")
p

p <- ggplot(results[[5]], aes(x=Meldedatum, y=Inzidenz)) +
        geom_line() + 
        ggtitle("7-Tage-Inzidenz 60-79 Jahre")
        xlab("")
p

p <- ggplot(results[[6]], aes(x=Meldedatum, y=Inzidenz)) +
        geom_line() + 
        ggtitle("7-Tage-Inzidenz 80+ Jahre")
        xlab("")
p