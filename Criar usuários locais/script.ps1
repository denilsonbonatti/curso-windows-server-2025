# Configurar grupo de trabalho
Add-Computer -WorkGroupName "EMPRESA" -Force -Restart:$false

# Mapear unidade de rede
$publicaPath = "\\server1\Publica"
New-PSDrive -Name "P" -PSProvider FileSystem -Root $publicaPath -Persist

# Criar senha segura
$senhaSegura = ConvertTo-SecureString "Senha123" -AsPlainText -Force

# Criar usuários locais
New-LocalUser -Name "carlos" -Password $senhaSegura -FullName "Carlos" -Description "Usuário do Depto de Vendas"
New-LocalUser -Name "maria" -Password $senhaSegura -FullName "Maria" -Description "Usuária do Depto ADM"

# Adicionar usuários ao grupo "Users"
Add-LocalGroupMember -Group "Users" -Member "carlos"
Add-LocalGroupMember -Group "Users" -Member "maria"

# Adicionar usuários ao grupo de acesso remoto
Add-LocalGroupMember -Group "Remote Desktop Users" -Member "carlos"
Add-LocalGroupMember -Group "Remote Desktop Users" -Member "maria"


