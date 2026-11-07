Add-Type -AssemblyName System.Drawing

$src = "C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets\reference.png"
$img = [System.Drawing.Bitmap]::FromFile($src)

# Let's crop Robin Ahmed portrait cutout
# The web container starts around y=105 to y=1024, x=30 to x=480
# Robin is centered roughly x=180 to x=330, y=130 to y=350
function Crop-Image($x, $y, $w, $h, $destPath) {
    $rect = New-Object System.Drawing.Rectangle($x, $y, $w, $h)
    $cropped = $img.Clone($rect, $img.PixelFormat)
    $cropped.Save($destPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $cropped.Dispose()
    Write-Host "Saved: $destPath ($w x $h)"
}

$assetsDir = "C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets"

# Robin portrait
Crop-Image 170 120 175 220 "$assetsDir\robin_hero.png"

# Project 1: Lawyer Alexander
Crop-Image 75 600 175 125 "$assetsDir\project_lawyer1.png"

# Project 2: Trava Phone Mockup
Crop-Image 260 645 175 125 "$assetsDir\project_trava.png"

# Project 3: Hebrew Marketing
Crop-Image 75 780 175 125 "$assetsDir\project_hebrew.png"

# Project 4: Robert Legal
Crop-Image 260 825 175 125 "$assetsDir\project_lawyer2.png"

# Ratings card
Crop-Image 340 280 90 60 "$assetsDir\rating_badge.png"

$img.Dispose()
