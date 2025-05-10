Rename-Computer -NewName "ADM2"

# Configurar grupo de trabalho
Add-Computer -WorkGroupName "EMPRESA" -Force -Restart:$false

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



# Mapear unidade de rede para todos os usuários

New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" `
  -Name "MapPublica" `
  -Value 'net use P: \\server1\Publica /persistent:yes' `
  -PropertyType String



New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" `
  -Name "MapADM" `
  -Value 'net use Z: \\server1\ADM /persistent:yes' `
  -PropertyType String
