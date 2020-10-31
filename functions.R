# Calculate 7-Tage-Inzidenz

Prepare_data_faelle <- function(filtered_df, value) {
        
        # Subset date and cases
        df <- select(filtered_df, c(Meldedatum, all_of(value)))
        
        # Fix dates
        df$Meldedatum <- as.POSIXct(df$Meldedatum, format="%Y/%m/%d %H:%M:%S")
        
        # Aggregate data
        df <- aggregate(df[value], by=df["Meldedatum"], sum)
        
        return (df)
}


Calculate_Inzidenz <- function(data_faelle, Einwohnerzahl) {
        data_faelle["Inzidenz"] <- NA
        rows <- nrow(data_faelle)
        rowcount <- c(7:rows)
        
        for (i in rowcount) {
                data_faelle[i, "Inzidenz"] <- data_faelle[(i-6):i, "AnzahlFall"] %>%
                                                sum()/(Einwohnerzahl/100000)
        }
        return(data_faelle)
}