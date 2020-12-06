# This script fetches the complete csv file from RKI
# Run before all other scripts
source("functions.R")

# data <- read.csv("https://opendata.arcgis.com/datasets/dd4580c810204019a7b8eb3e0b329dd6_0.csv", stringsAsFactors=FALSE)
# RKI_csv <- read.csv("https://www.arcgis.com/sharing/rest/content/items/f10774f1c63e40168479a1feb6c7ca74/data", stringsAsFactors=FALSE)
RKI_csv <- Read("https://www.arcgis.com/sharing/rest/content/items/f10774f1c63e40168479a1feb6c7ca74/data")