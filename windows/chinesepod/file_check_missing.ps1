# === CONFIG ===
$root = Get-Location
$dgFolder = Join-Path $root "dg"
$pdFolder = Join-Path $root "pd"

# === COLLECT HTML IDS (MASTER LIST) ===
$htmlIDs = Get-ChildItem -Filter *.html | ForEach-Object {
    $_.Name.Substring(0, 5)
} | Sort-Object -Unique

# === COLLECT DG IDS ===
$dgIDs = @()
if (Test-Path $dgFolder) {
    $dgIDs = Get-ChildItem $dgFolder -Filter *.mp3 | ForEach-Object {
        $_.Name.Substring(0, 5)
    } | Sort-Object -Unique
}

# === COLLECT PD IDS ===
$pdIDs = @()
if (Test-Path $pdFolder) {
    $pdIDs = Get-ChildItem $pdFolder -Filter *.mp3 | ForEach-Object {
        $_.Name.Substring(0, 5)
    } | Sort-Object -Unique
}

# === FIND MISSING ===
$missingDG = $htmlIDs | Where-Object { $_ -notin $dgIDs }
$missingPD = $htmlIDs | Where-Object { $_ -notin $pdIDs }

# === DISPLAY RESULTS ===
Write-Host "`n====== ✅ MISSING FILES REPORT ======" -ForegroundColor Cyan

Write-Host "`n❌ Missing DG files:"
if ($missingDG.Count -eq 0) {
    Write-Host "None ✅"
} else {
    $missingDG | ForEach-Object { Write-Host $_ }
}

Write-Host "`n❌ Missing PD files:"
if ($missingPD.Count -eq 0) {
    Write-Host "None ✅"
} else {
    $missingPD | ForEach-Object { Write-Host $_ }
}

# === SAVE CSV REPORT ===
$report = @()

foreach ($id in $missingDG) {
    $report += [PSCustomObject]@{
        ID = $id
        MissingIn = "DG"
    }
}

foreach ($id in $missingPD) {
    $report += [PSCustomObject]@{
        ID = $id
        MissingIn = "PD"
    }
}

pause
