# Obter o logonHours do usuário de referência
[array]$horaLogon = (Get-ADUser maria.graca -Properties logonHours).logonHours

# Definir a base de busca (OU VND)
$ou = "OU=VND,DC=empresa,DC=local"

# Aplicar para todos os usuários da OU
foreach ($user in Get-ADUser -Filter * -SearchBase $ou) {
    try {
        Set-ADUser -Identity $user.SamAccountName -Replace @{logonHours = $horaLogon}
        Write-Host "Horario de logon aplicado para: $($user.SamAccountName)"
    }
    catch {
        Write-Warning "Erro ao aplicar para $($user.SamAccountName): $($_.Exception.Message)"
    }
}