# Remover a entrada MapADM do registro de inicialização
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "MapADM" -ErrorAction SilentlyContinue

# Remover a entrada MapPublica do registro de inicialização
Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "MapPublica" -ErrorAction SilentlyContinue
