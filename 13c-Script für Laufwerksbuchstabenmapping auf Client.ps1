New-SmbMapping -LocalPath H: -RemotePath \\DC01.Schulnetz.local\Austausch
New-SmbMapping -LocalPath V: -RemotePath \\DC01.Schulnetz.local\Vorgaben
#
#
# Liste aller Freigaben anzeigen
Get-SmbMapping
#
#
# Alle geöffneten Verbindungen anzeigen
Get-SmbConnection
#
#
# Ausführlich
Get-SmbConnection -ServerName DC01.Schulnetz.local | Select-Object -Property *
#
#
# Von Client aus Freigaben auf Server anzeigen lassen
# Alle geöffneten Verbindungen anzeigen - Auf dem Domänencontroller gibt es
# immer die Adminfreigaben \SYSVOL \NETLOGON und die Null Session Verbindung IPC$
$DC01CS = New-CimSession -ComputerName DC01
Get-SmbShare -CimSession $DC01CS