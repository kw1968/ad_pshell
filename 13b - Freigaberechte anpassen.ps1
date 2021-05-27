# Freigaben erstellen
#
# Übersicht über Freigaben
Get-SmbShare -Name * |
Get-SmbShareAccess |
Format-Table -GroupBy Name
# Ordner freigeben; ohne Angabe von ACL hat JEDER Leserechte
New-SmbShare -Name Austausch -Path C:\Austausch
New-SmbShare -Name Vorgaben -Path C:\Vorgaben
# Beschreibung festlegen
$CHT01 = @{Confirm=$False}
Set-SmbShare -Name Austausch -Description 'Freigabe fuer Lehrer und Schueler' @CHT01
$CHT02 = @{Confirm=$False}
Set-SmbShare -Name Vorgaben -Description 'Vorlagenverzeichnis für Lehrer' @CHT02
#
#
# Aufzählungsmodus einstellen - wird nur angezeigt, wenn User Rechte hat
$CHT03 = @{Confirm = $false}
Set-SMBShare -Name Austausch -FolderEnumerationMode AccessBased @CHT03
$CHT04 = @{Confirm = $false}
Set-SMBShare -Name Vorgaben -FolderEnumerationMode AccessBased @CHT04
#
# Verschlüsselung einschalten . optional
Set-SmbShare -Name Austausch -EncryptData $true @CHT01
Set-SmbShare -Name Vorgaben -EncryptData $true @CHT01
#
# Freigaberechte nach Schulnetzrezept anpassen (Jeder bzw. Alle haben Freigaberecht "Full" = Ändern)
$AHT5 = @{
    Name = 'Austausch'
    AccessRight = 'Full'
    AccountName = 'Alle'
    Confirm = $false
    }
    Grant-SmbShareAccess @AHT5 | Out-Null
# Jeder - Freigabe entfernen (STandradmässig Lesen)
$AHT6 = @{
    Name = 'Austausch'
    AccountName = 'Jeder'
    Confirm = $false
    }
    Revoke-SmbShareAccess @AHT6 | Out-Null
#
# Vorgabefreigabe anpassen

$AHT5 = @{
    Name = 'Vorgaben'
    AccessRight = 'Full'
    AccountName = 'Alle'
    Confirm = $false
    }
    Grant-SmbShareAccess @AHT5 | Out-Null
# Jeder - Freigabe entfernen (Standardmässig Lesen)
$AHT6 = @{
    Name = 'Vorgaben'
    AccountName = 'Jeder'
    Confirm = $false
    }
    Revoke-SmbShareAccess @AHT6 | Out-Null
#
#
# Write-Output Verzeichnisse eingerichtet