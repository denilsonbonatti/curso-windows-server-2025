# Mapear unidade de rede para todos os usuários

New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" `
  -Name "MapPublica" `
  -Value 'net use P: \\server1\Publica /persistent:yes' `
  -PropertyType String



New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" `
  -Name "MapADM" `
  -Value 'net use Z: \\server1\ADM /persistent:yes' `
  -PropertyType String
