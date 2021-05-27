# Schülergruppe anlegen
$NGHT1 = @{
    Name = 'Schuelergruppe'
    Path = 'OU=Schulnetz,DC=Schulnetz,DC=local'
    Description = 'Alle Schüler der Schule'
    GroupScope = 'DomainLocal'
    }
    New-ADGroup @NGHT1
# Lehrergruppe anlegen
$NGHT2 = @{
    Name = 'Lehrergruppe'
    Path = 'OU=Schulnetz,DC=Schulnetz,DC=local'
    Description = 'Alle Lehrer der Schule'
    GroupScope = 'DomainLocal'
    }
    New-ADGroup @NGHT2
# Gruppe aller Benutzer anlegen
$NGHT3 = @{
    Name = 'Alle'
    Path = 'OU=Schulnetz,DC=Schulnetz,DC=local'
    Description = 'Alle Benutzer der Schule'
    GroupScope = 'DomainLocal'
    }
    New-ADGroup @NGHT3
# Alle Benutzer in Alle hinzufügen
$SB = 'OU=Schulnetz,DC=Schulnetz,DC=local'
$Alle = Get-ADUser -Filter * -SearchBase $SB
Add-ADGroupmember -Identity 'Alle' -Members $Alle
# Alternative mit nur Lehrer und Schueleraccounts
$Gruppe01 = 'CN=Lehrergruppe,OU=Schulnetz,DC=Schulnetz,DC=local'
Add-ADGroupmember -Identity 'Alle' -Members $Gruppe01
$Gruppe02 = 'CN=Schuelergruppe,OU=Schulnetz,DC=Schulnetz,DC=local'
Add-ADGroupmember -Identity 'Alle' -Members $Gruppe02
