Add-Type -AssemblyName System.Drawing

$srcPath = "C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets\robin_hero.png"
$orig = [System.Drawing.Bitmap]::FromFile($srcPath)

$newW = 700
$newH = 880
$highRes = New-Object System.Drawing.Bitmap($newW, $newH, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($highRes)
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

$g.DrawImage($orig, 0, 0, $newW, $newH)
$g.Dispose()
$orig.Dispose()

# Now create feathered alpha at the bottom so it fades perfectly into the dark website background #0b0704
for ($y = [int]($newH * 0.70); $y -lt $newH; $y++) {
    $progress = ($y - ($newH * 0.70)) / ($newH * 0.30)
    # alpha decreases to 0
    $alphaFactor = [Math]::Max(0.0, [Math]::Min(1.0, 1.0 - $progress))
    for ($x = 0; $x -lt $newW; $x++) {
        $pixel = $highRes.GetPixel($x, $y)
        $newAlpha = [int]($pixel.A * $alphaFactor)
        $highRes.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($newAlpha, $pixel.R, $pixel.G, $pixel.B))
    }
}

$destPath = "C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets\robin_hero_hq.png"
$highRes.Save($destPath, [System.Drawing.Imaging.ImageFormat]::Png)
$highRes.Dispose()

Write-Host "Created feathered HQ portrait: $destPath"
