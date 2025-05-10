$caminhoCSV = ".\users_ad.csv"
$senhaPadrao = ConvertTo-SecureString "Senha123" -AsPlainText -Force
$usuarios = Import-Csv -Path $caminhoCSV -Encoding UTF8

foreach ($user in $usuarios) {
    $nomeUsuario = $user.NomeUsuario
    $nomeCompleto = $user.NomeCompleto
    $ou = $user.OU.Trim()

    $ouPath = "OU=$ou,DC=empresa,DC=local"

    try {
        New-ADUser -Name $nomeCompleto `
                   -SamAccountName $nomeUsuario `
                   -AccountPassword $senhaPadrao `
                   -ChangePasswordAtLogon $false `
                   -Enabled $true `
                   -Path $ouPath
        Write-Host "Usuario $nomeUsuario criado com sucesso na OU $ou"
    }
    catch {
        Write-Warning "Erro ao tentar criar os usuarios $($_.Exception.Message)"
    }
}
