# Modul NTFS Security wird benötigt
# Install-Module NTFSSecurity -Force
# Anzeigen, was das Modul alles kann
# Get-Command -Module NTFSSecurity
# Neuen Freigabeordner erstellen
New-Item -Path C:\Vorgaben -ItemType Directory | Out-Null
# ACL des Ordners anzeigen
Get-NTFSAccess -Path C:\Vorgaben | Format-Table -AutoSize
# Ausmisten - Vererbung ausschalten
$IRHT1 = @{
    Path = 'C:\Vorgaben'
    RemoveInheritedAccessRules = $True
    }
    Disable-NTFSAccessInheritance @IRHT1
# Ausmisten Vordefiniertes Benutzerkonto entfernen
    $AHT2 = @{
        Path = 'C:\Vorgaben'
        Account = 'VORDEFINIERT\Benutzer'
        AccessRights = 'FullControl'
        }
        Remove-NTFSAccess @AHT2
# Admin Vollzugriff geben - optional, falls gewünscht
$AHT3 = @{
    Path = 'C:\Vorgaben\'
    Account = 'VORDEFINIERT\Administratoren'
    AccessRights = 'FullControl'
    }
    Add-NTFSAccess @AHT3
# Lehrer Ändernrechte geben
$AHT4 = @{
    Path = 'C:\Vorgaben\'
    Account = 'Schulnetz\Lehrergruppe'
    AccessRights = 'Modify'
    }
    Add-NTFSAccess @AHT4
# Schüler Lesezugriff geben
$AHT5 = @{
    Path = 'C:\Vorgaben\'
    Account = 'Schulnetz\Schuelergruppe'
    AccessRights = 'Read'
    }
    Add-NTFSAccess @AHT5
# ACL des Ordners anzeigen
    Get-NTFSAccess -Path C:\Vorgaben | Format-Table -AutoSize
#
#
#
# Neuen Freigabeordner erstellen
New-Item -Path C:\Austausch -ItemType Directory | Out-Null
# ACL des Ordners anzeigen
Get-NTFSAccess -Path C:\Austausch | Format-Table -AutoSize
# Ausmisten - Vererbung ausschalten
$IRHT2 = @{
    Path = 'C:\Austausch'
    RemoveInheritedAccessRules = $True
    }
    Disable-NTFSAccessInheritance @IRHT2
# Ausmisten Vordefiniertes Benutzerkonto entfernen
    $AHT6 = @{
        Path = 'C:\Austausch'
        Account = 'VORDEFINIERT\Benutzer'
        AccessRights = 'FullControl'
        }
        Remove-NTFSAccess @AHT6
# Admin Vollzugriff geben
$AHT7 = @{
    Path = 'C:\Austausch\'
    Account = 'VORDEFINIERT\Administratoren'
    AccessRights = 'FullControl'
    }
    Add-NTFSAccess @AHT7
# Lehrer Ändernrechte geben
$AHT8 = @{
    Path = 'C:\Austausch\'
    Account = 'Schulnetz\Lehrergruppe'
    AccessRights = 'Modify'
    }
    Add-NTFSAccess @AHT8
# Schüler Ändernrechte geben
$AHT9 = @{
    Path = 'C:\Austausch\'
    Account = 'Schulnetz\Schuelergruppe'
    AccessRights = 'Modify'
    }
    Add-NTFSAccess @AHT9
# ACL des Ordners anzeigen
    Get-NTFSAccess -Path C:\Austausch | Format-Table -AutoSize
#
# Optional
# Kontingente für den Austauschordner festlegen;
# Ressourcenmanager installieren - Kontingente und Dateitypen können dann festgelegt werden
$RES = @{
    Name = 'FS-Resource-Manager'
    IncludeManagementTools = $True
    }
    Install-WindowsFeature @RES
#
# Kontingentvorlage für User erstellen (250 MB); es sind schon viele Vorlagen verfügbar!
$QHT250 = @{
    Name = '250 MB-Grenze'
    Description = '250 MB Kontingent'
    Size = 250MB
    }
    New-FsrmQuotaTemplate @QHT250
#
# Empfehlung: Ohne Mailserver kann man das auch per Hand machen - einmalige Sache
