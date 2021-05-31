# Passwort für AD Wiederherstellungskonto festlegen; es handelt sich NICHT um das Admin Konto!
$PSSHT = @{
    String = 'Pa$$w0rd'
    AsPlainText = $true
    Force       = $true
}
# Passwort muss verschlüsselt werden
$PSS = ConvertTo-SecureString @PSSHT
# Domäne festlegen: Name (Schulnetz.local) und Windows Server 2016 Modus (WinThreshold = höchst möglicher Modus);
# Die Meldungen über NT 4.0 Unterstützung und DNS Delegierung können bei Erstinstallation ignoriert werden
$ADHT = @{
    DomainName = 'Schulnetz.local'
    SafeModeAdministratorPassword = $PSS
    InstallDNS = $true
    DomainMode = 'WinThreshold'
    ForestMode = 'WinThreshold'
    Force = $true
    # Der Neustart wird untern entweder erzwungen oder manuell ausgeführt. Wichtig bei Remoteverbindungen!
    NoRebootOnCompletion = $true
}
# Installation und Neustart
Install-ADDSForest @ADHT
# Vorsicht: RSAT bricht Verbindung ab! Entweder manuell neu starten oder # wegmachen
# Restart-Computer -Force
