# 1. Schritt: AD Dienste installieren; danach tauchen AD Einträge in Serververwaltung auf mit Ausrufezeichen
# Installiert werden die AD Dienste zusammen mit den Verwaltungswerkzeugen (GPO, AD Benutzer, Vertrauensstelllungen) etc.
# Nach dem Neustart müssen diese Dienste konfiguriert werden (Serververwaltung im Dashboard)
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Gleichen Befehl für DC02 verwenden
