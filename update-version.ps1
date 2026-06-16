# update-version.ps1
# Usage: .\update-version.ps1 1.0.17

param(
  [Parameter(Mandatory)][string]$NewVersion
)

function Update-File($filePath) {
  $content = Get-Content $filePath -Raw
  $updated = $content `
    -replace 'v\d+\.\d+\.\d+/', "v$NewVersion/" `
    -replace 'directors-prep-\d+\.\d+\.\d+-arm64\.dmg', "directors-prep-$NewVersion-arm64.dmg" `
    -replace 'directors-prep-\d+\.\d+\.\d+-x64\.dmg', "directors-prep-$NewVersion-x64.dmg" `
    -replace 'directors-prep-setup-\d+\.\d+\.\d+\.exe', "directors-prep-setup-$NewVersion.exe" `
    -replace 'v\d+\.\d+\.\d+ ·', "v$NewVersion ·"
  Set-Content $filePath $updated -NoNewline
  Write-Host "Updated $([System.IO.Path]::GetFileName($filePath))" -ForegroundColor Green
}

Update-File "$PSScriptRoot\download.html"
Update-File "$PSScriptRoot\windows-install.html"

Write-Host ""
Write-Host "Both files updated to v$NewVersion" -ForegroundColor Green
Write-Host ""
Write-Host "Now run:" -ForegroundColor Yellow
Write-Host "  git add download.html windows-install.html"
Write-Host "  git commit -m `"Update download links to v$NewVersion`""
Write-Host "  git push"
