# Befehlsmuster: Get-ADUser -Filter * -Properties * | export-csv c:\tmp\exp.csv
#
# Beispiel unten
# liefert eine zweispaltige CSV Datei mit den Vornamen und Nachnamen der bestehenden Usern
#
#               GivenName Surname
#               --------- -------
#               Kurt      Windberger
#               Muster    Schueler
#
Get-ADUser -Filter *   | Select-Object GivenName, Surname  | export-csv c:\tmp\exp5.csv

#
#
#
# Alternative mit den Spalten, die auch beim Import benutzt werden zum Vergleich
#
Get-ADUser -Filter *  -Properties * | Select-Object -Property GivenName,Surname,Description,Company | Export-CSV "C:\tmp\exp_verbose.csv" -NoTypeInformation -Encoding UTF8