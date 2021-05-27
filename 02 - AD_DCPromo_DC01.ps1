# Passwort für AD Wiederherstellungskonto festlegen
$PSSHT = @{
    String = 'Pa$$w0rd'
    AsPlainText = $true
    Force       = $true
}
# Passwort muss verschlüsselt werden
$PSS = ConvertTo-SecureString @PSSHT
# Domäne festlegen: Name und Windows Server 2016 Modus;
# die Meldungen über NT 4.0 Unterstützung und DNS Delegierung können ignoriert werden
$ADHT = @{
    DomainName = 'Schulnetz.local'
    SafeModeAdministratorPassword = $PSS
    InstallDNS = $true
    DomainMode = 'WinThreshold'
    ForestMode = 'WinThreshold'
    Force = $true
    NoRebootOnCompletion = $true
}
# Installation und Neustart
Install-ADDSForest @ADHT
# Vorsicht: RSAT bricht Verbindung ab! Entweder manuell neu starten oder # wegmachen
# Restart-Computer -Force
