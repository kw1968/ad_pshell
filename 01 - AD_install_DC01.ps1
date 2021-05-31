# 1. Schritt: AD Dienste installieren; danach tauchen AD Einträge in Serververwaltung auf mit Ausrufezeichen
# Installiert werden die AD Dienste zusammen mit den Verwaltungswerkzeugen (GPO, AD BEnutzer, Vertrauensstelllungen) etc.
# NAch dem Neustart müssen diese Dienste konfiguriert werden (Serververwaltung im Dashboard)
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
