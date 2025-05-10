# Script PowerShell para adicionar todos os usuários do domínio empresa.local
# ao grupo local "Remote Desktop Users"

$grupoDominio = "empresa\Domain Users"
$grupoLocal = "Remote Desktop Users"

Try {
    Add-LocalGroupMember -Group $grupoLocal -Member $grupoDominio -ErrorAction Stop
    Write-Host "Grupo $grupoDominio adicionado ao grupo local $grupoLocal com sucesso."
} Catch {
    Write-Warning "Erro ao adicionar o grupo: $_"
}