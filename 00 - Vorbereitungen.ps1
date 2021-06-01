# Überprüfen der Windows Installation
$Key = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion'
$CliVer = (Get-ItemProperty -Path $Key).ReleaseId
$Platform = $ENV:PROCESSOR_ARCHITECTURE
"Windows-Client-Version : $CliVer"
"Hardwareplattform : $Platform"

# Überprüfen, welche RSAT Tools verfügbar sind
Get-WindowsCapability -Online | ? Name -like *RSAT*

# Fehlende KOmponenten installieren
Get-WindowsCapability -Online | ? {$_.Name -like "*RSAT*" -and $_.State -eq "NotPresent"} |Add-WindowsCapability -Online
# Alternativ ohne Test, ob schon installiert
Get-WindowsCapability -Online | ? {$_.Name -like "*RSAT*"} |Add-WindowsCapability -Online

# Alle Komponenten deinstallieren; funktioniert in neueren Versionen nicht mehr ( Ein permanentes Paket kann nicht deinstalliert werden.)
Get-WindowsCapability -Online | ? {$_.Name -like "*RSAT*" -and $_.State -eq "Installed"} | Remove-WindowsCapability -Online
