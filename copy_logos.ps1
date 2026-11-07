$destDir = "C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets\marquee_logos"
if (!(Test-Path $destDir)) { New-Item -ItemType Directory -Force -Path $destDir | Out-Null }

$sourceDir1 = "C:\Users\Mannan Ansari\OneDrive\Documents\Downloads\Logos"
$sourceDir2 = "C:\Users\Mannan Ansari\OneDrive\Documents\Downloads\Logos\logos"

$preferredLogos = @(
    "Kotak-Neo-hlogo-blackbg 1 (1) (2).png",
    "Sheraton Logo White .png",
    "The Fern Budhni White.png",
    "Jardin Logo White.png",
    "Enrise all unit logo _Enrise Bhopal W.png",
    "CRESCENT LOGO white_.png",
    "Egniter White.png",
    "sayaji indore@4x.png",
    "The Fern Jaipur logo.png",
    "Capers Logo .png",
    "JNRT_FOOTER.png",
    "D2R-Logo-Long.png",
    "Kalyan sampat Heights_logo.png",
    "Kalaghoda.png",
    "kebabsvilla.png",
    "Malt.png",
    "Portico logo.png",
    "SS-Logo-PNG (1) (1).png"
)

foreach ($name in $preferredLogos) {
    $src = Join-Path $sourceDir1 $name
    if (!(Test-Path $src)) {
        $src = Join-Path $sourceDir2 $name
    }
    if (Test-Path $src) {
        $cleanName = ($name -replace '[^a-zA-Z0-9_.-]', '_').ToLower()
        # Make short clean name
        $destFile = Join-Path $destDir $cleanName
        Copy-Item -Path $src -Destination $destFile -Force
        Write-Host "Copied: $name -> $cleanName ($((Get-Item $destFile).Length) bytes)"
    } else {
        Write-Host "Not found: $name"
    }
}

Get-ChildItem $destDir | Format-Table Name, Length
