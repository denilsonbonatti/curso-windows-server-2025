# Define caminho do instalador temporário
$gitInstaller = "$env:TEMP\Git-64-bit.exe"

# URL da versão mais recente (verifique se há versão mais nova em: https://github.com/git-for-windows/git/releases)
$gitUrl = "https://github.com/git-for-windows/git/releases/download/v2.49.0.windows.1/Git-2.49.0-64-bit.exe"

Write-Host "Baixando Git de $gitUrl..."
Invoke-WebRequest -Uri $gitUrl -OutFile $gitInstaller

# Verifica se o download foi concluído
if (-Not (Test-Path $gitInstaller)) {
    Write-Error "Falha ao baixar o instalador do Git."
    exit 1
}

Write-Host "Instalando Git silenciosamente..."
Start-Process -FilePath $gitInstaller -ArgumentList "/VERYSILENT", "/NORESTART" -Wait

# Verifica se o Git foi instalado
$gitCmdPath = "C:\Program Files\Git\cmd\git.exe"
if (Test-Path $gitCmdPath) {
    # Adiciona temporariamente o caminho do Git à sessão atual
    $env:Path += ";C:\Program Files\Git\cmd"

    $gitVersion = & git --version
    Write-Host "Git instalado com sucesso: $gitVersion"
} else {
    Write-Error "Instalação do Git falhou."
}
