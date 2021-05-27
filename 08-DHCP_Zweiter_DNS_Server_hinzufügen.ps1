# DC02 ist 2. Domänencontroller mit AD DNS integriert
# DC02 als 2. DNS Server per DHCP verteilen
$OHT = @{
ComputerName = 'DC01.schulnetz.local'
DnsDomain = 'schulnetz.local'
DnsServer = '10.36.39.11','10.36.39.12'
}
Set-DhcpServerV4OptionValue @OHT

# Reverse Lookup Zone einrichten ist nicht unbedingt nötig, aber "Best Practive" vgl Windows Server Kurs
# Reverse Lookup Zone einrichten
$PSHT = @{
    Name = '10.36.39.in-addr.arpa'
    ReplicationScope = 'Forest'
    DynamicUpdate = 'Secure'
    ResponsiblePerson = 'Administrator@schulnetz.local'
    }
Add-DnsServerPrimaryZone @PSHT

# Testen der Zonenauflösung
Get-DNSServerZone -Name 'schulnetz.local', '10.36.39.in-addr.arpa'

# DNS Auflösung auf DC01 testen
Test-DnsServer -IPAddress 10.36.39.11 -Context DnsServer
Test-DnsServer -IPAddress 10.36.39.11 -Context RootHints
Test-DnsServer -IPAddress 10.36.39.11 -ZoneName 'schulnetz.local'

# DNS Auflösung auf DC02 testen
Test-DnsServer -IPAddress 10.36.39.12 -Context DnsServer
Test-DnsServer -IPAddress 10.36.39.12 -Context RootHints
Test-DnsServer -IPAddress 10.36.39.12 -ZoneName 'schulnetz.local'
