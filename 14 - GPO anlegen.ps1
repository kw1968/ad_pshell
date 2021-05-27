# Alle GPOs auslesen
Get-GPO -All -Domain Schulnetz.local | Sort -Property DisplayName | Format-Table -Property Displayname, Description, GpoStatus
# Alle GPOs sichern
Get-GPO -All | Backup-GPO -Path C:\GPOs
#
# Alle GPOs wiederherstellen
Restore-GPO -All -Path C:\GPOs
#
# GPO aus Verzeichnis nachschauen: https://gpsearch.azurewebsites.net/
#
# Es gibt auch eine Excel Datei: https://www.microsoft.com/en-us/download/details.aspx?displaylang=en&id=25250
#
# ######################################################
# Beispiel GPO erstellen: Powershellscripte zulassen und "Unrestricted" (Scripte aus allen Quellen) zulassen
# SEHR unsicher!!! Nur zum Testen
# #######################################################
#
# Neues GPO Objekt
$GPol = New-GPO -Name Powershell-Scripte -Comment “fuer Admin Maschinen zum Testen” -Domain schulnetz.local
#
# Nur Computerzweig wird benötigt
$GPol.GpoStatus = ‘UserSettingsDisabled’
#
#
# GPO Einstellungen 1
$PO1= @{
    Name = ‘Powershell-Scripte’
    Key = ‘HKLM\Software\Policies\Microsoft\Windows\PowerShell’
    ValueName = ‘EnableScripts’
    Type = ‘DWord’
    Value = 1
    }
# GPO Einstellungen setzen
    Set-GPRegistryValue @PO1 | Out-Null
# GPO Einstellungen 2
$PO2= @{
    Name = ‘Powershell-Scripte’
    Key = ‘HKLM\Software\Policies\Microsoft\Windows\PowerShell’
    ValueName = ‘ExecutionPolicy’
    Value = ‘Unrestricted’
    Type = ‘String’
    }
    # GPO Einstellungen setzen
    Set-GPRegistryValue @PO2 | Out-Null

# Weiteres harmloses Beispiel
# #########################################
# Bildschirmschoner deaktivieren
# #########################################
#
# Neues GPO anlegen
$GPO2 = New-GPO -Name 'Screen Saver Time Out'
$GPO2.GpoStatus = 'ComputerSettingsDisabled'
$GPO2.Description = '15 Minuten Wartezeit'
#
# Werte schreiben
$PO3= @{
    Name = 'Screen Saver Time Out'
    Key = 'HKCU\Software\Policies\Microsoft\Windows\'+
    'Control Panel\Desktop'
    ValueName = 'ScreenSaveTimeOut'
    Value = 900 # in Sekunden
    Type = 'DWord'
    }
    Set-GPRegistryValue @PO3 | Out-Null
#
#
# Beide GPOs mit der OU Schule verknüpfen (Computer)
$GPLHT1 = @{
    Name = 'Powershell-Scripte'
    Target = 'OU=Schule,OU=Schulnetz,DC=Schulnetz,DC=local'
    }
    New-GPLink @GPLHT1 | Out-Null
    $GPLHT2 = @{
    Name = 'Screen Saver Time Out'
    Target = 'OU=Schule,OU=Schulnetz,DC=Schulnetz,DC=local'
    }
    New-GPLink @GPLHT2 | Out-Null