# For installing everything you need to run Astral, only run this if DONT have Luvit, Discordia, or Astral installed
# Open a powershell instance as administrator and run these sets of commands
PowerShell -NoProfile -ExecutionPolicy unrestricted -Command "[Net.ServicePointManager]::SecurityProtocol = 'Tls12'; iex ((new-object net.webclient).DownloadString('https://github.com/luvit/lit/raw/master/get-lit.ps1'))";
Start-Sleep -Seconds 2;
lit install SinisterRectus/discordia;
Start-Sleep -Seconds 2;
$url = "https://github.com/dehoisted/Astral/archive/refs/heads/main.zip"
$output = "Astral-Bot_Main.zip"
$start_time = Get-Date
Invoke-WebRequest -Uri $url -OutFile $output
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)";
