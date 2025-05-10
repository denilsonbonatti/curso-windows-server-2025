# Permitir execução de scripts
Set-ExecutionPolicy Unrestricted -Force

# Definir variáveis
$domain = "empresa.local"
$user = "Administrator"
$password = "Senha123"
$ou = "OU=VND,DC=empresa,DC=local"

# Alterar o nome do computador
#Rename-Computer -NewName "VND1" -Force

# Converter senha para formato seguro e criar credencial
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential("$domain\$user", $securePassword)

# Adicionar computador ao domínio e reiniciar
Add-Computer -DomainName $domain -OUPath $ou -Credential $credential -Force -Restart

