# DHCP mit Verwaltungskonsole installieren; Ausrufezeichen taucht wieder auf, weil was konfiguriert werden muss
Install-WindowsFeature -Name DHCP -IncludeManagementTools
# DHCP Sicherheitsgruppe anlegen mit ausführlicher Meldung
Add-DHCPServerSecurityGroup -Verbose
# DHCP Dienst als konfiguriert kennzeichnen; keine Ausgabe
$RegHT = @{
    Path = 'HKLM:\SOFTWARE\Microsoft\ServerManager\Roles\12'
    Name = 'ConfigurationState'
    Value = 2
    }
    Set-ItemProperty @RegHT
# DHCP autorisieren; keine Ausgabe
Add-DhcpServerInDC -DnsName DC01.schulnetz.local
# DHCP neu starten; evtl Wartemeldung
Restart-Service -Name DHCPServer -Force


