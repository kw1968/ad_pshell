# Funktion zum Ersetzen der Umlaute
# Achtung: Das Script muss als UTF-8 mit BOM gespeichert werden,
# sonst funktioniert die Maskierung der Umlaute nicht!
# Die Codierung steht unten rechts in VS Code; ansonsten Doku des Editors lesen.
# Das Script geht davon aus, dass in "Description" und "Company" in der CSV Datei keine Umlaute vorkommen; sonst anpassen.
Function Replace-Umlaut {

    param (
       [string]$Text 
    )
 
    # create HashTable with replace map
    $characterMap = @{}
    $characterMap.([Int][Char]'ä') = "ae"
    $characterMap.([Int][Char]'ö') = "oe"
    $characterMap.([Int][Char]'ü') = "ue"
    $characterMap.([Int][Char]'ß') = "ss"
    $characterMap.([Int][Char]'Ä') = "Ae"
    $characterMap.([Int][Char]'Ü') = "Ue"
    $characterMap.([Int][Char]'Ö') = "Oe"
    $characterMap.([Int][Char]' ') = "."
    $characterMap.([Int][Char]'á') = "_"
    # Hier kann die Austauschtabelle beliebig erweitert werden
    # Replace chars
    ForEach ($key in $characterMap.Keys) {
        $Text = $Text -creplace ([Char]$key),$characterMap[$key] 
    }
 
     # return result
     $Text
}
# CSV Datei einlesen aus Verzeichnis C:\tmp, nach Nachnamen sortiert
#
#
$Users = Import-CSV -Path C:\tmp\user_import02.csv | Sort-Object -Property Surname
#
# Wenn gewünscht:
# Formatierte Übersicht der anzulegenden User ausgeben zur Kontrolle
# $Users | Sort-Object -Property Surname | Format-Table
#
# Basispfad für Benutzer festlegen
$Path = "OU=Klassen,OU=Schulnetz,DC=schulnetz,DC=local"
ForEach ($User in $Users) {
# Hashwerte ins Array einlesen; 
    $Prop = @{}
        $Prop.GivenName = Replace-Umlaut($User.GivenName)
        $Prop.Surname = Replace-Umlaut($User.Surname)
        $Prop.Name = $Prop.Surname + "." + $Prop.GivenName
        $Prop.Initials = $User.GivenName[0]+ $User.SurName[0]
        $Prop.UserPrincipalName = $Prop.GivenName+"."+$Prop.Surname+"@schulnetz.local"
        $Prop.Displayname = $Prop.GivenName + " " + $Prop.Surname
        $Prop.Description = $User.Description
        $Prop.Company = $User.Company
        $PW = ConvertTo-SecureString -AsPlainText $user.Password -Force
        $Prop.AccountPassword = $PW
        # Um sicher zu sein! User müssen Anfangspasswort selber setzen
        $Prop.ChangePasswordAtLogon = $true
        # Benutzer Klasse und Stufe einlesen und in String umwandeln
        $klasse = $User.Company.toString()
        $stufe = $User.Description.toString()
        $cn = $Prop.Name.toString()
        # Benutzerpfad festlegen
        $Userpath = "OU=$klasse,OU=$stufe," + "$Path"
        $Userpath2 = "CN=$cn," + $Userpath
        # Nur zur Kontrolle beim Testen
        # Write-Output $Userpath2
        #Abfrage, ob User schon existiert
        $o = $(try {Get-ADUser $Userpath2} catch {$null})
                if ($o -ne $null) {Write-Output "Benutzer existiert schon"    
                                    }
        # Wenn User noch nicht existiert, wird er angelegt
                else{
                    New-ADUser @Prop -Path $Userpath -Enabled:$true
                    "$($Prop.Displayname) in $Userpath erstellt"
                    }     
        }
