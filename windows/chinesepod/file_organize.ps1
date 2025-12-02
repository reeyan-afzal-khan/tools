$files = Get-ChildItem -File

# Create folders if missing
if (!(Test-Path "dg")) { New-Item -ItemType Directory -Name "dg" | Out-Null }
if (!(Test-Path "pd")) { New-Item -ItemType Directory -Name "pd" | Out-Null }

foreach ($file in $files) {

    if ($file.Name -match "_dg") {
        Move-Item $file.FullName "dg\" -Force
    }
    elseif ($file.Name -match "_pd") {
        Move-Item $file.FullName "pd\" -Force
    }

}

Write-Host "✅ Organization complete!"
pause
