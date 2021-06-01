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

# RSAT Tools auf Server DC01 (10.36.39.11) installieren; DNS NAme geht, wenn im lokalen Netz
$InstallSB = {
Get-WindowsFeature -Name *RSAT* | Install-WindowsFeature
}
$I1 = Invoke-Command -ComputerName DC01 -ScriptBlock $InstallSB
$I1
# Neustart funktioniert eventuell nicht automatisch (-wait ist problematisch); dann halt manuell neu starten
If ($I1.RestartNeeded -eq 'Yes') {
"DC01(10.36.39.11) wird neu gestartet"
Restart-Computer -ComputerName DC01 -Force -Wait -For PowerShell
}
