$files = Get-ChildItem -Filter *.mp3

# Create folders if they don’t exist
if (!(Test-Path "dg")) { New-Item -ItemType Directory -Name "dg" | Out-Null }
if (!(Test-Path "pd")) { New-Item -ItemType Directory -Name "pd" | Out-Null }

foreach ($file in $files) {

    # Read MP3 metadata using Windows Shell
    $shell = New-Object -ComObject Shell.Application
    $folder = $shell.Namespace($file.DirectoryName)
    $item = $folder.ParseName($file.Name)

    $title = $folder.GetDetailsOf($item, 21)  # 21 = Title field

    # If title is empty, use placeholder
    if ([string]::IsNullOrWhiteSpace($title)) {
        $title = "Empty-Title"
    }

    # Replace illegal Windows filename characters
    $title = $title -replace '[:\\\/\*\?"<>\|]', '-'

    # Get base filename (without .mp3)
    $basename = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)

    if ($basename -match "dg$") {

        $newName = $basename -replace "dg$", "_dg"
        $finalName = "$newName - $title.mp3"
        Move-Item $file.FullName "dg\$finalName"

    }
    elseif ($basename -match "pr$") {

        $newName = $basename -replace "pr$", "_pd"
        $finalName = "$newName - $title.mp3"
        Move-Item $file.FullName "pd\$finalName"

    }

}

Write-Host "✅ Renaming + Sorting Completed!"
pause
