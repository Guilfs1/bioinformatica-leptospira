# Coleta as especificacoes REAIS da maquina Windows para a secao 3 do relatorio.
# Rodar no PowerShell (nao precisa ser admin):
#   powershell -ExecutionPolicy Bypass -File coletar_hardware.ps1
# Gera o arquivo hardware_windows.txt na pasta atual.

$out = "hardware_windows.txt"
"=== CPU ===" | Out-File $out
Get-CimInstance Win32_Processor |
  Select-Object Name, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed |
  Format-List | Out-File $out -Append

"=== MEMORIA RAM (por pente) ===" | Out-File $out -Append
Get-CimInstance Win32_PhysicalMemory |
  Select-Object @{N='CapacidadeGB';E={[math]::Round($_.Capacity/1GB,0)}},
                Speed, SMBIOSMemoryType, Manufacturer, PartNumber |
  Format-List | Out-File $out -Append
"Nota: SMBIOSMemoryType 24=DDR3, 26=DDR4, 34=DDR5" | Out-File $out -Append

"=== RAM TOTAL ===" | Out-File $out -Append
Get-CimInstance Win32_ComputerSystem |
  Select-Object @{N='RAMTotalGB';E={[math]::Round($_.TotalPhysicalMemory/1GB,1)}} |
  Format-List | Out-File $out -Append

"=== ARMAZENAMENTO FISICO ===" | Out-File $out -Append
Get-PhysicalDisk |
  Select-Object FriendlyName, MediaType, BusType,
                @{N='TamanhoGB';E={[math]::Round($_.Size/1GB,0)}} |
  Format-List | Out-File $out -Append
"Nota: MediaType=SSD + BusType=NVMe significa SSD NVMe; BusType=SATA com MediaType=SSD e SSD SATA; MediaType=HDD e disco mecanico" | Out-File $out -Append

"=== SISTEMA OPERACIONAL ===" | Out-File $out -Append
Get-CimInstance Win32_OperatingSystem |
  Select-Object Caption, Version, BuildNumber, OSArchitecture |
  Format-List | Out-File $out -Append

Write-Host "Pronto. Arquivo gerado: $out"
Get-Content $out
