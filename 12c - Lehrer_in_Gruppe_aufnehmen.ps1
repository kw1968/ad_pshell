# Alle Benutzer aus der OU Klassen in die GRuppe Schueler aufnehmen
$SB = 'OU=Lehrer,OU=Schulnetz,DC=Schulnetz,DC=local'
$Lehrer = Get-ADUser -Filter * -SearchBase $SB
Add-ADGroupmember -Identity 'Lehrergruppe' -Members $Lehrer