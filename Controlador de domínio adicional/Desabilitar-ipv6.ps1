New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" `
                 -Name "DisabledComponents" `
                 -PropertyType DWord `
                 -Value 0xFF `
                 -Force
