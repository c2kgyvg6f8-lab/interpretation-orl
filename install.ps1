# Installation de "Interpretation ORL" (hors ligne, avec mise a jour automatique depuis GitHub)
# Copie le logiciel dans le dossier de l'utilisateur et cree les raccourcis (Bureau + menu Demarrer).
# Le raccourci passe par lancer.ps1, qui installe la derniere version publiee avant d'ouvrir le logiciel.

$ErrorActionPreference = 'Stop'
$nom  = 'Interpretation ORL'
$dest = Join-Path $env:LOCALAPPDATA 'InterpretationORL'
New-Item -ItemType Directory -Force -Path $dest | Out-Null
foreach ($f in 'Interpretation_ORL.html','interpretation_orl.ico','lancer.ps1','version.txt') {
  $src = Join-Path $PSScriptRoot $f
  if (Test-Path $src) { Copy-Item $src $dest -Force }
}
Get-ChildItem $dest -Filter *.ps1 | Unblock-File

$ps = Join-Path $env:WINDIR 'System32\WindowsPowerShell\v1.0\powershell.exe'
$arguments = "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File `"$(Join-Path $dest 'lancer.ps1')`""

$sh = New-Object -ComObject WScript.Shell
$dossiers = @(
  [Environment]::GetFolderPath('Desktop'),
  [Environment]::GetFolderPath('Programs')
)
foreach ($d in $dossiers) {
  $lnk = $sh.CreateShortcut((Join-Path $d "$nom.lnk"))
  $lnk.TargetPath       = $ps
  $lnk.Arguments        = $arguments
  $lnk.IconLocation     = (Join-Path $dest 'interpretation_orl.ico') + ',0'
  $lnk.WorkingDirectory = $dest
  $lnk.WindowStyle      = 7
  $lnk.Description      = 'Interpretation audiogramme, VHIT, VNG, PEA, PEO, polygraphie, PSG - hors ligne, mise a jour automatique'
  $lnk.Save()
}

Write-Host ''
Write-Host "Installation terminee." -ForegroundColor Green
Write-Host "Une icone '$nom' est sur le Bureau et dans le menu Demarrer."
Write-Host "A chaque ouverture, le logiciel installe tout seul la derniere version publiee sur GitHub (si internet est disponible)."
Start-Process -FilePath $ps -ArgumentList $arguments -WindowStyle Hidden
Start-Sleep -Seconds 2
