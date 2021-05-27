# Konfiguration der DHCP Bereiche

# Bereiche festlegen

# Schuelernetz; State = Active wäre nicht nötig, da Defaultwert
$SHT01 = @{
    Name = 'Schulnetz_Schuelernetz01'
    StartRange = '10.36.39.100'
    EndRange = '10.36.39.200'
    SubnetMask = '255.255.255.0'
    LeaseDuration = '30.00:00:00'
    Delay = '10'
    Type = 'Dhcp'
    Description = 'Standardbereich fuer lokales Schuelernetz01'
    State = 'Active'
    ComputerName = 'DC01.schulnetz.local'
    }
    Add-DhcpServerV4Scope @SHT01

    # DHCP Serveroptionen konfigurieren
    $OHT = @{
        ComputerName = 'DC01.schulnetz.local'
        DnsDomain = 'schulnetz.local'
        DnsServer = '10.36.39.11'
        Router = '10.36.39.1'
        
        }
        Set-DhcpServerV4OptionValue @OHT
    
        # DNS Einstellungen für DHCP Server
        $OHT2 = @{
            ComputerName = 'DC01.schulnetz.local'
            DynamicUpdates = 'Always'
            NameProtection = $true
            # Folgende Einstellung räumt auf, Macht auch Sinn, damit muss aber Name Protection ausgeschaltet werden
            # DeleteDnsRROnLeaseExpiry = $true
            }

        Set-DhcpServerv4DnsSetting @OHT2