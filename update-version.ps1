# update-version.ps1
# Usage: .\update-version.ps1 1.0.14

param(
  [Parameter(Mandatory)][string]$NewVersion
)

$file = "$PSScriptRoot\download.html"
$content = Get-Content $file -Raw

# Replace all version references
$updated = $content -replace 'v\d+\.\d+\.\d+/', "v$NewVersion/" `
                    -replace '-\d+\.\d+\.\d+-', "-$NewVersion-" `
                    -replace '-\d+\.\d+\.\d+\.dmg', "-$NewVersion.dmg" `
                    -replace 'Setup\.\d+\.\d+\.\d+\.exe', "Setup.$NewVersion.exe" `
                    -replace 'v\d+\.\d+\.\d+ ·', "v$NewVersion ·"

Set-Content $file $updated -NoNewline

Write-Host "Updated download.html to v$NewVersion" -ForegroundColor Green
Write-Host ""
Write-Host "Now run:" -ForegroundColor Yellow
Write-Host "  git add download.html"
Write-Host "  git commit -m `"Update download links to v$NewVersion`""
Write-Host "  git push"
