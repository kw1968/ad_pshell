# ad_pshell
Einfache Powershell Befehle zum Konfigurieren eines AD mit grundlegenden Diensten

## Konzept
Es handlet sich hier um eine halbautomatische Installation eines ADs mit Hilfe einfachster Scriptbefehle.
Es gibt weder eine augefeilte, elegante Fehlerbehandlung, noch sind die Scripte über ein übergeordnetes Script aufrufbar.
Das ist hier nicht der Sinn der ganzen Liste.
Ziel ist es, Einsteigern in die Powershell zu verdeutlichen, dass viele Aufgaben in der GUI des Windows Servers 2019 auch durch Powershell Befehle durchgeführt werden können.
Hierbei erhält man auch noch eine gute Dokumentationsmöglichkeit und eine Art Backup der Konfiguration, die teilweise sehr parktisch sein kann (GPOs, DHCP)

Liste der Scripte

* 01 - AD_install_DC01.ps1
* 02 - AD_DCPromo_DC01.ps1
* 03 - AD_info.ps1
* 04 - DHCP_installieren.ps1
* 05 - DHCP_Grundkonfiguration.ps1
* 06 - DHCP_Reservierungen.ps1
* 07 - DHCP_Failover.ps1
* 08 - DHCP_Zweiter_DNS_Server_hinzufügen.ps1
* 09 - OUs_anlegen.ps1
* 09a - OUs anlegen.ps1
* 10 - User auslesen.ps1
* 11a - Gruppen_anlegen.ps1
* 11b - Schueler_anlegen_Test_Umlaute.ps1
* 11c - Schueler_in_Gruppe_aufnehmen.ps1
* 12b - Lehrer_anlegen.ps1
* 12c - Lehrer_in_Gruppe_aufnehmen.ps1
* 13 - Freigabeordner mit ACLs_erstellen.ps1
* 13a - SMB Server einrichten.ps1
* 13b - Freigaberechte anpassen.ps1
* 13c - Script für Laufwerksbuchstabenmapping auf Client.ps1
* 14 - GPO anlegen.ps1
* 15 - BSI_GPO_importieren.ps1
* 23 - Zeichentabelle feststellen.ps1
* 24 - User_verschieben.ps1

