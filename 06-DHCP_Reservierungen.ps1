# Reservierungen aus bestehenden Clients generieren
# Konzept: Noch keine IP ADressen wurden per DHCP vergeben. FreeIP holt dann beginnend von der
# untersten verfügbaren IP Adresse (hier 10.36.39.100) der Reihe nach die freien Adressen
# aus dem Bereich ScopeID.
# Kennt man eine Liste der MAC Adressen, so kann man die Reservierungen der REihe nach festlegen.
# 
$FreeIP = Get-DhcpServerv4FreeIPAddress -ComputerName "DC01.schulnetz.local" -ScopeId 10.36.39.0
#
# Reservierungsdaten für den Rechner mit der MAC F0-DE-00-00-00-00 festlegen
$SHT01 =@{
    ScopeID = '10.36.39.0'
    ComputerName = 'DC01.schulnetz.local'
    IPAddress = $FreeIP
    ClientId = 'F0-DE-00-00-00-00'
    Name = 'PC01'
    Description = "Arbeitsplatzrechner 01"
    }
# Reserviert die von $FreeIP geholte freie IP Adresse für den Rechner mit der obigen Client ID 
Add-DhcpServerv4Reservation @SHT01
#
# Befehl muss für jede Reservierung wiederholt werden, hier für drei Rechner; Arrays hochzählen nicht vergessen.
# Wenn MAC Adressen bekannt sind, kann man auch ein Array füllen und eine Schleife verwenden
# Rechner PC02
$FreeIP2 = Get-DhcpServerv4FreeIPAddress -ComputerName "DC01.schulnetz.local" -ScopeId 10.36.39.0
$SHT02 =@{
    ScopeID = '10.36.39.0'
    ComputerName = 'DC01.schulnetz.local'
    IPAddress = $FreeIP2
    ClientId = 'F0-DE-00-00-00-22'
    Name = 'PC02'
    Description = "Abrbeitsplatzrechner 02"
    }
# Reserviert die von $FreeIP geholte freie IP Adresse für den Rechner mit der obigen Client ID 
Add-DhcpServerv4Reservation @SHT02

# Rechner PC03
$FreeIP3 = Get-DhcpServerv4FreeIPAddress -ComputerName "DC01.schulnetz.local" -ScopeId 10.36.39.0
$SHT03 =@{
    ScopeID = '10.36.39.0'
    ComputerName = 'DC01.schulnetz.local'
    IPAddress = $FreeIP3
    ClientId = 'F0-DE-00-00-00-33'
    Name = 'PC02'
    Description = "Abrbeitsplatzrechner 02"
    }
# Reserviert die von $FreeIP geholte freie IP Adresse für den Rechner mit der obigen Client ID 
Add-DhcpServerv4Reservation @SHT03


# Alternative mit CSV Datei (im selben Verzeichnis wie das Script):
# Import-Csv -Path "Reservations.csv" | Add-DhcpServerv4Reservation -ComputerName "DC01.schulnetz.local"
#
# Aufbau der CSV Datei:
# ScopeId,IPAddress,Name,ClientId,Description
# 10.36.39.0, 10.36.39.100,PC01,F0-DE-00-00-00-00, Arbeitsplatzrechner01
# 10.36.39.0, 10.36.39.101,PC02,F0-DE-00-00-00-01, Arbeitsplatzrechner02
# usw. 