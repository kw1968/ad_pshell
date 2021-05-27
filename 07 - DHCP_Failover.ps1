# Failover erfordert zwei Server DC01 und DC02
#  DC01 ist vollständig konfiguriert: DHCP, ein Bereich und Serveroptionen
# DC02 ist der Failover DHCP Server
$FHT = @{
    Name = 'DHCP','RSAT-DHCP'
    ComputerName = 'DC02.schulnetz.local'}
    Install-WindowsFeature @FHT

# DHCP Dienst informieren, dass alles konfiguriert wurde (auf DC02 ausführen)
$IPHT = @{
     Path = 'HKLM:\SOFTWARE\Microsoft\ServerManager\Roles\12'
     Name = 'ConfigurationState'
    Value = 2
    }
Set-ItemProperty @IPHT

# Authorisieren
Add-DhcpServerInDC -DnsName DC02.schulnetz.local

# Übersicht
Get-DhcpServerInDC

# Failover, Shared Secret ist beliebig, aber nicht zu kurz für digest Verschlüsselung
# Wenn man das weg lässt, wird Verschlüsselung abgeschaltet
$FHT= @{
    ComputerName = 'DC01.schulnetz.local'
    PartnerServer = 'DC02.schulnetz.local'
    Name = 'DC01-DC02'
    ScopeID = '10.36.39.0'
    LoadBalancePercent = 60
    SharedSecret = 'Pj!7hG32Nh'
    Force = $true
    }
Add-DhcpServerv4Failover @FHT

# Fertig! Kontrolle der aktiven Leases von beiden Servern
'DC01', 'DC02' | ForEach-Object {Get-DhcpServerv4Lease -ScopeID 10.36.39.0 -ComputerName $_}

# Statistiken abrufen
'DC01', 'DC02' | ForEach-Object {Get-DhcpServerv4ScopeStatistics -ComputerName $_}
