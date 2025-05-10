# Nome da GPO
$gpoName = "Wallpaper ADM"
$domain = "empresa.local"
$ouDn = "OU=ADM,DC=empresa,DC=local"

# Caminho da imagem
$wallpaperPath = "\\SERVER1\script-users$\imagem2.jpg"

# Cria a GPO
New-GPO -Name $gpoName -Comment "Define wallpaper for ADM users" -Domain $domain

# Liga a GPO à OU ADM
New-GPLink -Name $gpoName -Target $ouDn -Enforced "No"

# Define a política de papel de parede
Set-GPRegistryValue -Name $gpoName -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" -ValueName "Wallpaper" -Type String -Value $wallpaperPath

# Define o estilo do papel de parede (2 = Stretch | 0 = Center | 6 = Fit | 10 = Fill | 1 = Tile)
Set-GPRegistryValue -Name $gpoName -Key "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" -ValueName "WallpaperStyle" -Type String -Value "10"


Write-Host "GPO '$gpoName' aplicada à OU ADM com imagem de wallpaper definida."


#==================================================================================

#Caso seja necessário excluir a GPO:

#Remove-GPO -Name "Wallpaper ADM" -Domain "empresa.local" -Confirm:$false