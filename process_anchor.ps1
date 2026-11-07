Add-Type -AssemblyName System.Drawing

$src = "C:\Users\Mannan Ansari\.gemini\antigravity\brain\25c37498-fc57-4e96-bba8-106b56c4ab06\.user_uploaded\media_1793433026168_fef9c284.png"
$img = [System.Drawing.Bitmap]::FromFile($src)

# Man is centered around x=512, width around 600, y from 60 to 576 (height ~ 516)
$cropX = 220
$cropY = 50
$cropW = 580
$cropH = 526

$rect = New-Object System.Drawing.Rectangle($cropX, $cropY, $cropW, $cropH)
$cropped = $img.Clone($rect, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$img.Dispose()

# Create high-res feathered portrait (e.g. 800 x 725)
$targetW = 800
$targetH = [int](800 * ($cropH / $cropW))
$feathered = New-Object System.Drawing.Bitmap($targetW, $targetH, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($feathered)
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$g.DrawImage($cropped, 0, 0, $targetW, $targetH)
$g.Dispose()
$cropped.Dispose()

# Feather the bottom so it fades completely into transparency/dark background
$fadeStartY = [int]($targetH * 0.70)
for ($y = $fadeStartY; $y -lt $targetH; $y++) {
    $progress = ($y - $fadeStartY) / ($targetH - $fadeStartY)
    $alphaFactor = [Math]::Max(0.0, [Math]::Min(1.0, 1.0 - $progress))
    for ($x = 0; $x -lt $targetW; $x++) {
        $p = $feathered.GetPixel($x, $y)
        $newA = [int]($p.A * $alphaFactor)
        $feathered.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($newA, $p.R, $p.G, $p.B))
    }
}

# Also feather left and right outer 10% edges so there is no hard rectangular cut
$edgeWidth = [int]($targetW * 0.12)
for ($y = 0; $y -lt $targetH; $y++) {
    # Left edge
    for ($x = 0; $x -lt $edgeWidth; $x++) {
        $alphaFactor = $x / $edgeWidth
        $p = $feathered.GetPixel($x, $y)
        $newA = [int]($p.A * $alphaFactor)
        $feathered.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($newA, $p.R, $p.G, $p.B))
    }
    # Right edge
    for ($x = ($targetW - $edgeWidth); $x -lt $targetW; $x++) {
        $alphaFactor = ($targetW - $x) / $edgeWidth
        $p = $feathered.GetPixel($x, $y)
        $newA = [int]($p.A * $alphaFactor)
        $feathered.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($newA, $p.R, $p.G, $p.B))
    }
}

$destPath = "C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets\hero_anchor.png"
$feathered.Save($destPath, [System.Drawing.Imaging.ImageFormat]::Png)
$feathered.Dispose()

Write-Host "Created hero anchor portrait at $destPath"
