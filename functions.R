# Calculate 7-Tage-Inzidenz

Prepare_data_faelle <- function(filtered_df) {
        
        # Subset date and cases
        df <- select(filtered_df, c(Meldedatum, AnzahlFall))
        
        # Fix dates
        df$Meldedatum <- as.POSIXct(df$Meldedatum, format="%Y/%m/%d %H:%M:%S")
        
        # Aggregate data
        df <- aggregate(df["AnzahlFall"], by=df["Meldedatum"], sum)
        
        return (df)
}


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