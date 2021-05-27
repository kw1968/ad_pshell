$Features = 'FileAndStorage-Services','File-Services',
'FS-FileServer','RSAT-File-Services'
Add-WindowsFeature -Name $Features
#
Get-SmbServerConfiguration
#
# SMB 1 ausschalten
$CHT = @{
    EnableSMB1Protocol = $false
    Confirm = $false
    }
    Set-SmbServerConfiguration @CHT
#
# Signieren und Verschlüsseln
$SHT1 = @{
    RequireSecuritySignature = $true
    EnableSecuritySignature = $true
    EncryptData = $true
    Confirm = $false
    }
    Set-SmbServerConfiguration @SHT1
#
# Standardfreigaben deaktivieren
$SHT2 = @{
    AutoShareServer = $false
    AutoShareWorkstation = $false
    Confirm = $false
    }
    Set-SmbServerConfiguration @SHT2
#
# Serverankündigung ausschalten
$SHT3 = @{
    ServerHidden = $true
    AnnounceServer = $false
    Confirm = $false
    }
    Set-SmbServerConfiguration @SHT3
#
#
# Neustart des Servers ist notwendig für die Änderungen; eventuell manuell neu starten
Restart-Service lanmanserver
#
