$folders = @(
    @{ Name = "Enrise Bhopal"; Id = "1L4WY06Si47anOadLSB5bqNQMevXqSr6Q" },
    @{ Name = "Jahan Numa Palace"; Id = "1Al0qtQfGcrCrT4zf7Q_mj5Oe329Ta8I5" },
    @{ Name = "Jahan Numa Retreat"; Id = "1gCR0_hGhN9LwVZzM9kprdbuLE-43SZVy" },
    @{ Name = "Jahan Numa Wilderness"; Id = "1cHaKDCX8_UPJXDTwB0xMf4nfDlfvq7n1" },
    @{ Name = "Jardin Hotel"; Id = "1rKUxKoMCoLwfyDmbyFpHXrgpQXX6M_g2" },
    @{ Name = "Kotak neo"; Id = "1Rfwn6Xwt7zKj043uBet2L-mTrqb80Fa5" },
    @{ Name = "Noor Us Subah Palace"; Id = "1T8EKC-5hIltMK5gOC2OrAWGYNNU2cSNJ" },
    @{ Name = "Orchid"; Id = "18RPaRVzi_j6LNvz0dBHR3DWyrFB3gS_x" },
    @{ Name = "Pushya Mitra Bhargav"; Id = "1vP468GmfYHYMBqmTWeQcUeStSDtsi_MW" },
    @{ Name = "Sarvamangala"; Id = "15KYF1CfO2yr7fY5xvPDlOe4DysilK_5T" },
    @{ Name = "The Ferns"; Id = "1i6Q3bP7_G0rvKzkOfLtOFCoWpMcOHH9L" }
)

$destDir = "C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets\gdrive_assets"
if (!(Test-Path $destDir)) { New-Item -ItemType Directory -Force -Path $destDir | Out-Null }

$allFiles = @()

foreach ($f in $folders) {
    $url = "https://drive.google.com/drive/folders/$($f.Id)?usp=sharing"
    Write-Host "Fetching $($f.Name)..."
    try {
        $res = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 15
        $html = $res.Content
        if ($html -match "window\['_DRIVE_ivd'\]\s*=\s*'([^']+)'") {
            $raw = $matches[1]
            $decoded = [regex]::Replace($raw, '\\x([0-9a-fA-F]{2})', { param($m) [char][Convert]::ToInt32($m.Groups[1].Value, 16) })
            $decoded = [regex]::Replace($decoded, '\\u([0-9a-fA-F]{4})', { param($m) [char][Convert]::ToInt32($m.Groups[1].Value, 16) })
            
            $itemMatches = [regex]::Matches($decoded, '\["([a-zA-Z0-9_-]{20,50})",\["[^"]*"\],"([^"]+)","([^"]+)"')
            foreach ($im in $itemMatches) {
                $fileId = $im.Groups[1].Value
                $fileName = $im.Groups[2].Value
                $fileMime = $im.Groups[3].Value
                
                # Check if image or pdf
                if ($fileMime -match "image" -or $fileName -match "\.(png|jpg|jpeg|webp)$") {
                    $allFiles += [PSCustomObject]@{
                        Folder = $f.Name
                        FileId = $fileId
                        FileName = $fileName
                        Mime = $fileMime
                    }
                    Write-Host "  -> Found image: $fileName ($fileId)"
                }
            }
        }
    } catch {
        Write-Host "Error fetching $($f.Name): $_"
    }
}

$allFiles | Export-Csv -Path "$destDir\files_list.csv" -NoTypeInformation
Write-Host "Total images found: $($allFiles.Count)"
