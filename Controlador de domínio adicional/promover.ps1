Install-ADDSDomainController `
    -DomainName "empresa.local" `
    -Credential (Get-Credential) `
    -InstallDns `
    -SafeModeAdministratorPassword (ConvertTo-SecureString "Senha123" -AsPlainText -Force) `
    -Force