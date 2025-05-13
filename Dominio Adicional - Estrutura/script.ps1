Import-Module ActiveDirectory

$senhaPadrao = ConvertTo-SecureString "Senha123" -AsPlainText -Force

Write-Host "Criando Unidades Organizacionais..."
New-ADOrganizationalUnit -Name "EDU" -Path "DC=empresa,DC=local" -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name "SEC" -Path "DC=empresa,DC=local" -ProtectedFromAccidentalDeletion $false

Write-Host "Criando Grupos..."
New-ADGroup -Name "GRP_EDU" -GroupScope Global -Path "OU=EDU,DC=empresa,DC=local"
New-ADGroup -Name "GRP_SEC" -GroupScope Global -Path "OU=SEC,DC=empresa,DC=local"

Write-Host "Importando usuários do CSV..."
$usuarios = Import-Csv -Path "C:\Scripts\user_ad2.csv" -Delimiter ";"

foreach ($user in $usuarios) {
    $ou = $user.OU
    $sam = $user.NomeUsuario
    $nome = $user.NomeCompleto
    $ouPath = "OU=$ou,DC=empresa,DC=local"

    New-ADUser -SamAccountName $sam -Name $nome -AccountPassword $senhaPadrao -Enabled $true -Path $ouPath

    if ($ou -eq "EDU") {
        Add-ADGroupMember -Identity "GRP_EDU" -Members $sam
    }
    elseif ($ou -eq "SEC") {
        Add-ADGroupMember -Identity "GRP_SEC" -Members $sam
    }
}

Write-Host "Criando pastas e definindo permissões..."
New-Item -Path "C:\EDU" -ItemType Directory
New-Item -Path "C:\SEC" -ItemType Directory

icacls "C:\EDU" /grant "GRP_EDU:(OI)(CI)F" /T
icacls "C:\SEC" /grant "GRP_SEC:(OI)(CI)F" /T

Write-Host "Criando GPOs e definindo políticas..."

# GPO para mapear \\server1\publica
New-GPO -Name "MapPublica2"
New-GPLink -Name "MapPublica2" -Target "OU=EDU,DC=empresa,DC=local"
New-GPLink -Name "MapPublica2" -Target "OU=SEC,DC=empresa,DC=local"

# GPO para mapear C:\EDU
New-GPO -Name "MapEDU"
New-GPLink -Name "MapEDU" -Target "OU=EDU,DC=empresa,DC=local"

# GPO para mapear C:\SEC
New-GPO -Name "MapSEC"
New-GPLink -Name "MapSEC" -Target "OU=SEC,DC=empresa,DC=local"

# GPO para papel de parede
New-GPO -Name "WallpaperEDUSEC"
New-GPLink -Name "WallpaperEDUSEC" -Target "OU=EDU,DC=empresa,DC=local"
New-GPLink -Name "WallpaperEDUSEC" -Target "OU=SEC,DC=empresa,DC=local"

Set-GPRegistryValue -Name "WallpaperEDUSEC" -Key "HKCU\Control Panel\Desktop" -ValueName Wallpaper -Type String -Value "\\SERVER1\script-users$\imagem1.jpg"
Set-GPRegistryValue -Name "WallpaperEDUSEC" -Key "HKCU\Control Panel\Desktop" -ValueName WallpaperStyle -Type String -Value "2"
Set-GPRegistryValue -Name "WallpaperEDUSEC" -Key "HKCU\Control Panel\Desktop" -ValueName TileWallpaper -Type String -Value "0"
