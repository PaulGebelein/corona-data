# Calculate 7-Tage-Inzidenz

Calculate_Inzidenz <- function(data_faelle, Einwohnerzahl) {
        data_faelle["Inzidenz"] <- NA
        rows <- nrow(data_faelle)
        rowcount <- c(7:rows)
        
        for (i in rowcount) {
                temp <- data_faelle[(i-6):i, "AnzahlFall"]
                temp <- sum(temp)
                temp <- temp/(Einwohnerzahl/100000)
                data_faelle[i, "Inzidenz"] <- temp
        }
        return(data_faelle)
}