#
# Schulklassen anlegen - Teil 1 - Stufen
#
#
# OU Klassen anlegen
New-ADOrganizationalUnit -Name Klassen -Path "OU=Schulnetz,DC=Schulnetz,DC=local"
# OUs für Klassenstufen anlegen - KLasse 5 bis 9 (einstellig)
For($i=5;$i -le 9;$i++)
{
$j=$i.tostring()
New-ADOrganizationalUnit -Name "0$j.Klassen" -Path "OU=Klassen,OU=Schulnetz,DC=Schulnetz,DC=local"
Write-Output "0$j. Klassen angelegt"
# Klassen in Klassenstufen anlegen
        $buchstaben=@("a","b","c","d","e","f","g")  
        Foreach ($item in $buchstaben)
        {
            $b=$item.tostring()
            New-AdOrganizationalUnit -Name "$j$b" -Path "OU=0$j.Klassen,OU=Klassen,OU=Schulnetz, DC=Schulnetz,DC=local"
            Write-Output "$j$b angelegt"
        }
}
# OUs für Klassenstufen anlegen - Klasse 10 bis 12 (zweistellig)
For($i=10;$i -le 12;$i++)
{
$k=$i.tostring()
New-ADOrganizationalUnit -Name "$k.Klassen" -Path "OU=Klassen,OU=Schulnetz,DC=Schulnetz,DC=local"
# Klassen in Klassenstufen anlegen
$buchstaben=@("a","b","c")  
Foreach ($item in $buchstaben)
{
    $c=$item.tostring()
    New-AdOrganizationalUnit -Name "$k$c" -Path "OU=$k.Klassen,OU=Klassen,OU=Schulnetz, DC=Schulnetz,DC=local"
    Write-Output "$k$c angelegt"
}
Write-Output "$k. Klassen angelegt"
}
write-Output "Alle Stufenverzeichnisse und Klassenverzeichnisse angelegt"
#
#
# Schreibschutz für OUs aufheben; zum Testen, später auskommentieren
# Get-ADobject -Filter * -SearchBase „OU=Schulnetz,DC=Schulnetz,DC=local“ | Set-adobject -ProtectedFromAccidentalDeletion $false