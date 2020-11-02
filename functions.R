Prepare_data_faelle <- function(filtered_df, value) {
        
        # Subset date and cases
        df <- select(filtered_df, c(Meldedatum, all_of(value)))
        
        # Fix dates
        df$Meldedatum <- as.POSIXct(df$Meldedatum, format="%Y/%m/%d %H:%M:%S")
        
        # Aggregate data
        df <- aggregate(df[value], by=df["Meldedatum"], sum)
        
        return (df)
}

# Calculate 7-Tage-Inzidenz
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

# This function accepts two dataframes with dates and Fallzahlen
Calculate_ratio <- function(df1, df2) {
        df <- merge(x = df1, y = df2, by = "Meldedatum", all = TRUE)
        df['Ratio'] <- NA
        rows <- nrow(df)

        for (i in 1:rows) {
                df[i, "Ratio"] <- df[i, "AnzahlFall.y"]/(df[i, "AnzahlFall.x"]/100)
        }
        return(df)
}