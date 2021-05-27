# Schule anlegen
New-ADOrganizationalUnit -Name Schule -Path "OU=Schulnetz,DC=Schulnetz,DC=local"
#
# Räume mit PCs anlegen
# Raumliste muss angepasst werden
#
#
$rooms=@("Medienraum","Computerraum A","Computerraum B","Notebookwagen","Tabletklasse","SurfacePro")  
        Foreach ($item in $rooms)
        {
            $raum=$item.tostring()
            New-AdOrganizationalUnit -Name "$raum" -Path "OU=Schule,OU=Schulnetz, DC=Schulnetz,DC=local"
            Write-Output "OU $raum angelegt"
        }
# Lehrer OU anlegen
New-ADOrganizationalUnit -Name Lehrer -Path "OU=Schulnetz,DC=Schulnetz,DC=local"