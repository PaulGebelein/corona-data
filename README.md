# corona-data
This repository is a collection of R scripts to make sense of RKI corona data.

Dieses Repo ist eine Sammlung von R Skripten, die für die Auswertung des RKI Coronadatensets.

## Skripte
**Plot_Landkreis.R**

*"Wie ist die Lage in meinem Kreis?"*

Dieses Skript erzeugt zwei Plots:

1. Anzahl gemeldeten Infizierten pro Tag
2. Anzahl gemeldeter Verstorbener pro Tag
3. 7-Tage-Izidenz

Am Anfang des Skripts können die Variablen "Kreis" und "Einwohnerzahl" spezifiziert werden.

**Inzidenz_D_nach_ALter.R**

*"Wie ist die Inzidenz in den jeweiligen Altersgruppen für Deutschland?"*

Dieses Skript erzeugt sechs Plots. Für jede Altersgruppe in den RKI Daten einen.

Das sind:

- 0-4 Jahre
- 5-14 Jahre
- 15-34 Jahre
- 35-59 Jahre
- 60-79 Jahre
- älter als 80 Jahre

## Verwendete Datenquelle
Zahlen des Robert-Koch-Instituts für Deutschland

https://www.arcgis.com/home/item.html?id=f10774f1c63e40168479a1feb6c7ca74


## Weitere Datenquellen
Europäisches Zentrum für die Prävention und die Kontrolle von Krankheiten

https://data.europa.eu/euodp/de/data/dataset/covid-19-coronavirus-data

Landkreise Deutschland
https://www.destatis.de/DE/Themen/Laender-Regionen/Regionales/Gemeindeverzeichnis/Administrativ/04-kreise.html

Gemeindeverzeichnis Deutschland
https://www.destatis.de/DE/Themen/Laender-Regionen/Regionales/Gemeindeverzeichnis/_inhalt.html

Alterstruktur Deutschland (Jahresweise)
https://de.statista.com/statistik/daten/studie/1351/umfrage/altersstruktur-der-bevoelkerung-deutschlands/
