#
# BSI GPO importieren
# Import und Export möglich:
#
# Aufruf mit     Scriptname.ps1 –Mode Export
# oder
#               Scriptname.ps1 –Mode Import
#
# Aufruf nur mit Parameter (Mandatory = $True)
Param(
[Parameter(Mandatory=$True)]
[ValidateSet("Export", "Import")]
[string]$Mode #Possible Modes: Export, Import
)
# Verzeichnisse festlegen
import-module grouppolicy
$ExportFolder="c:\GPOs\"
$Importfolder="c:\GPOs\"
$PreName=""
$PostName=""
# Import - Export Funktionen
function Export-GPOs {
    $GPO=Get-GPO -All
    foreach ($Entry in $GPO) {
    $Path=$ExportFolder+$entry.Displayname
    New-Item -ItemType directory -Path $Path
    Backup-GPO -Guid $Entry.id -Path $Path
    }
    }
function Import-GPOs {
        $Folder=Get-childItem -Path $Importfolder -Exclude *.ps1
        foreach ($Entry in $Folder) {
        $Name=$PreName+$Entry.Name+$postname
        $Path=$Importfolder+$entry.Name
        $ID=Get-ChildItem -Path $Path
        New-GPO -Name $Name
        Import-GPO -TargetName $Name -Path $Path -BackupId $ID.Name
        }
        $BS1 = @{
            Name = 'Normaler_Schutzbedarf_Benutzer'
            Target = 'OU=Klassen,OU=Schulnetz,DC=Schulnetz,DC=local'
            }
            New-GPLink @BS1 | Out-Null
        $BS2 = @{
            Name = 'Normaler_Schutzbedarf_Domainmitglied_Computer'
            Target = 'OU=Schule,OU=Schulnetz,DC=Schulnetz,DC=local'
            }
        New-GPLink @BS2 | Out-Null
        $BS3 = @{
            Name = 'Protokollierung_Computer'
            Target = 'OU=Schule,OU=Schulnetz,DC=Schulnetz,DC=local'
            }
        New-GPLink @BS3 | Out-Null
    }
        switch ($Mode){
            {$_ -eq "Export"}
            {Export-GPOs
            break}
            {$_ -eq "Import"}
            {Import-GPOs
            break}
            }