##DistinguishedName = "CN=Joao Silva,OU=ADM,DC=empresa,DC=local"

$caminhoCSV = ".\usuarios_dominio.csv"

# Cabeçalho manual
"Título: NomeUsuario,NomeCompleto,UO" | Set-Content -Path $caminhoCSV

# Coleta os dados
Get-ADUser -Filter * -Properties Name, DistinguishedName | ForEach-Object {
    $login = $_.SamAccountName
    $nome = $_.Name
    $ou = ($_.DistinguishedName -replace '^CN=.*?,OU=(.*?),DC=.*$', '$1')

    "$login,$nome,$ou" | Add-Content -Path $caminhoCSV
}

Write-Host "Arquivo criado: $caminhoCSV"