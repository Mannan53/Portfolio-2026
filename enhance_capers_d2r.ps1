Add-Type -AssemblyName System.Drawing

$dir = "C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets\marquee_logos"

# 1. ENHANCE CAPERS
$pathCapers = Join-Path $dir "logo_capers.png"
$bmp = [System.Drawing.Bitmap]::FromFile($pathCapers)
$outCapers = New-Object System.Drawing.Bitmap($bmp.Width, $bmp.Height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
for ($y = 0; $y -lt $bmp.Height; $y++) {
    for ($x = 0; $x -lt $bmp.Width; $x++) {
        $p = $bmp.GetPixel($x, $y)
        if ($p.A -gt 20) {
            # Check if gold accent: R > 170 and G > 140
            if ($p.R -gt 170 -and $p.G -gt 140) {
                $outCapers.SetPixel($x, $y, $p) # preserve gold
            } else {
                # Dark olive green -> crisp white with original alpha
                $outCapers.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($p.A, 255, 255, 255))
            }
        }
    }
}
$bmp.Dispose()
$tmp = "$pathCapers.tmp.png"
$outCapers.Save($tmp, [System.Drawing.Imaging.ImageFormat]::Png)
$outCapers.Dispose()
Move-Item -Path $tmp -Destination $pathCapers -Force
Write-Host "Enhanced logo_capers.png"

# 2. ENHANCE D2R
$pathD2R = Join-Path $dir "logo_d2r.png"
$bmp = [System.Drawing.Bitmap]::FromFile($pathD2R)
$outD2R = New-Object System.Drawing.Bitmap($bmp.Width, $bmp.Height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
for ($y = 0; $y -lt $bmp.Height; $y++) {
    for ($x = 0; $x -lt $bmp.Width; $x++) {
        $p = $bmp.GetPixel($x, $y)
        if ($p.A -gt 20) {
            # Check if yellow/gold: R > 150 and G > 110 and B < 60
            if ($p.R -gt 150 -and $p.G -gt 110 -and $p.B -lt 70) {
                $outD2R.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($p.A, 255, 205, 50))
            } else {
                # Dark blue -> crisp white
                $outD2R.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($p.A, 255, 255, 255))
            }
        }
    }
}
$bmp.Dispose()
$tmp = "$pathD2R.tmp.png"
$outD2R.Save($tmp, [System.Drawing.Imaging.ImageFormat]::Png)
$outD2R.Dispose()
Move-Item -Path $tmp -Destination $pathD2R -Force
Write-Host "Enhanced logo_d2r.png"
