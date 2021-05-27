# Alle Benutzer aus der OU Klassen in die Gruppe Schueler aufnehmen
    $SB = 'OU=Klassen,OU=Schulnetz,DC=Schulnetz,DC=local'
    $Schueler = Get-ADUser -Filter * -SearchBase $SB
    Add-ADGroupmember -Identity 'Schuelergruppe' -Members $Schueler