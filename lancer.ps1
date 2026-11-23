# Lanceur de "Interpretation ORL"
# 1. Verifie sur GitHub s'il existe une nouvelle version (5 s maximum, sinon on continue hors ligne).
# 2. Telecharge la nouvelle version, controle son empreinte SHA-256, puis remplace l'ancienne.
# 3. Ouvre le logiciel dans Edge (ou Chrome) en mode application.
# Sans connexion internet, le logiciel s'ouvre normalement avec la version deja installee.

$ErrorActionPreference = 'SilentlyContinue'
$dest  = Join-Path $env:LOCALAPPDATA 'InterpretationORL'
$depot = 'https://raw.githubusercontent.com/c2kgyvg6f8-lab/interpretation-orl/main'
$html  = Join-Path $dest 'Interpretation_ORL.html'
$verLocal = Join-Path $dest 'version.txt'
$journal  = Join-Path $dest 'mises_a_jour.log'

function Note($t) { Add-Content -Path $journal -Value ("{0}  {1}" -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), $t) }

try {
  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
  $anti = [DateTime]::UtcNow.Ticks
  $distant = (Invoke-WebRequest "$depot/version.txt?x=$anti" -UseBasicParsing -TimeoutSec 5).Content.Trim()
  $local = ''
  if (Test-Path $verLocal) { $local = (Get-Content $verLocal -Raw).Trim() }
  $parts = $distant -split '\s+'
  if ($parts.Count -ge 2 -and $distant -ne $local) {
    $tmp = "$html.tmp"
    Invoke-WebRequest "$depot/Interpretation_ORL.html?x=$anti" -UseBasicParsing -TimeoutSec 120 -OutFile $tmp
    $h = (Get-FileHash $tmp -Algorithm SHA256).Hash.ToLower()
    if ($h -eq $parts[1].ToLower()) {
      if (Test-Path $html) { Copy-Item $html "$html.precedente" -Force }
      Move-Item $tmp $html -Force
      Set-Content -Path $verLocal -Value $distant
      Note "Mise a jour installee : version $($parts[0])"
      # le lanceur lui-meme peut aussi etre mis a jour (pris en compte au prochain demarrage)
      $l = "$dest\lancer.ps1.tmp"
      Invoke-WebRequest "$depot/lancer.ps1?x=$anti" -UseBasicParsing -TimeoutSec 30 -OutFile $l
      if ((Test-Path $l) -and (Get-Item $l).Length -gt 500 -and (Select-String -Path $l -Pattern 'Interpretation ORL' -SimpleMatch -Quiet)) { Move-Item $l (Join-Path $dest 'lancer.ps1') -Force } else { Remove-Item $l }
    } else {
      Remove-Item $tmp
      Note "Telechargement refuse (empreinte differente), version actuelle conservee."
    }
  }
} catch { }

$candidats = @(
  "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe",
  "$env:ProgramFiles\Microsoft\Edge\Application\msedge.exe",
  "$env:ProgramFiles\Google\Chrome\Application\chrome.exe",
  "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe",
  "$env:LOCALAPPDATA\Google\Chrome\Application\chrome.exe"
)
$nav = $candidats | Where-Object { $_ -and (Test-Path $_) } | Select-Object -First 1
$url  = ([System.Uri]$html).AbsoluteUri
$prof = Join-Path $dest 'profil'
Start-Process -FilePath $nav -ArgumentList "--app=`"$url`" --user-data-dir=`"$prof`" --no-first-run --no-default-browser-check"
