# ===============================================
# Script de Enumeração de Máquina Windows
# ===============================================

# 1. Informações Básicas do Sistema
function Get-SystemInfo {
    Write-Host "--- Informações do Sistema ---" -ForegroundColor Green
    Get-ComputerInfo -Property "CsName", "OsName", "OsVersion", "OsProductKey" | Format-List
    Write-Host ""
}

# 2. Informações de Rede
function Get-NetworkInfo {
    Write-Host "--- Informações de Rede ---" -ForegroundColor Green
    Get-NetIPAddress | Select-Object InterfaceAlias, IPAddress, PrefixLength | Format-List
    Write-Host ""
}

# 3. Informações de Usuários e Grupos
function Get-UserAndGroupInfo {
    Write-Host "--- Usuários e Grupos ---" -ForegroundColor Green
    Write-Host "Usuários Locais:"
    Get-LocalUser | Select-Object Name, Enabled, AccountExpires | Format-Table -AutoSize
    Write-Host ""

    Write-Host "Membros do grupo de Administradores:"
    Get-LocalGroupMember -Group "Administradores" | Select-Object Name, PrincipalSource | Format-Table -AutoSize
    Write-Host ""
}

# 4. Processos em Execução
function Get-RunningProcesses {
    Write-Host "--- Processos em Execução ---" -ForegroundColor Green
    Get-Process | Sort-Object CPU -Descending | Select-Object -First 10 ProcessName, Id, CPU | Format-Table -AutoSize
    Write-Host "Mostrando os 10 processos que mais consomem CPU."
    Write-Host ""
}

# 5. Serviços em Execução
function Get-RunningServices {
    Write-Host "--- Serviços em Execução ---" -ForegroundColor Green
    Get-Service | Where-Object {$_.Status -eq "Running"} | Select-Object Name, DisplayName, Status | Format-Table -AutoSize
    Write-Host "Mostrando todos os serviços ativos."
    Write-Host ""
}

# Executa todas as funções para iniciar a enumeração
Get-SystemInfo
Get-NetworkInfo
Get-UserAndGroupInfo
Get-RunningProcesses
Get-RunningServices
