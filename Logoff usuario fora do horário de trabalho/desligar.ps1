
# Script: Força logoff se o horário atual estiver fora de 9h-17h
# Versão: Compatível com Windows 10/11 e Server 2025

# Horário permitido de logon
$horaInicioPermitida = 9
$horaFimPermitida = 17

# Obtem a hora atual
$horaAtual = (Get-Date).Hour

# Verifica se está fora do intervalo permitido
if ($horaAtual -lt $horaInicioPermitida -or $horaAtual -ge $horaFimPermitida) {
    Write-Host "Fora do horário permitido. Iniciando logoff..."
    shutdown.exe /l
} else {
    Write-Host "Usuário dentro do horário permitido. Nenhuma ação necessária."
}




======================================================================================

powershell.exe -ExecutionPolicy Bypass -File "\\SERVER1\script-users$\desligar.ps1"

