# Definir senha padrão
$senhaPadrao = ConvertTo-SecureString "Senha123" -AsPlainText -Force

# Lista de usuários para ADM
$usuariosADM = @(
    @{Nome="joao.mendes"; NomeCompleto="João Mendes"},
    @{Nome="maria.oliveira"; NomeCompleto="Maria Oliveira"}
)

# Lista de usuários para VND
$usuariosVND = @(
    @{Nome="carlos.ventania"; NomeCompleto="Carlos Ventania"},
    @{Nome="ana.braga"; NomeCompleto="Ana Braga"}
)

# Criar usuários na OU ADM

foreach ($user in $usuariosADM) {
    New-ADUser -Name $user.NomeCompleto `
               -SamAccountName $user.Nome `
               -AccountPassword $senhaPadrao `
               -ChangePasswordAtLogon $true `
               -Enabled $true `
               -Path "OU=ADM,DC=empresa,DC=local"
}

# Criar usuários na OU VND
foreach ($user in $usuariosVND) {
    New-ADUser -Name $user.NomeCompleto `
               -SamAccountName $user.Nome `
               -AccountPassword $senhaPadrao `
               -ChangePasswordAtLogon $true `
               -Enabled $true `
               -Path "OU=VND,DC=empresa,DC=local"
}
