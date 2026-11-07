Add-Type -AssemblyName System.Drawing

$destDir = "C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets\software_icons"

function Add-RoundedRect($path, $x, $y, $w, $h, $radius) {
    $d = $radius * 2
    $path.AddArc($x, $y, $d, $d, 180, 90)
    $path.AddArc($x + $w - $d, $y, $d, $d, 270, 90)
    $path.AddArc($x + $w - $d, $y + $h - $d, $d, $d, 0, 90)
    $path.AddArc($x, $y + $h - $d, $d, $d, 90, 90)
    $path.CloseFigure()
}

# CAPCUT ICON
$bmpCc = New-Object System.Drawing.Bitmap(512, 512, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$gCc = [System.Drawing.Graphics]::FromImage($bmpCc)
$gCc.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias

$pathCc = New-Object System.Drawing.Drawing2D.GraphicsPath
Add-RoundedRect $pathCc 16 16 480 480 110

$brushCc = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    (New-Object System.Drawing.Point 0, 0),
    (New-Object System.Drawing.Point 512, 512),
    [System.Drawing.Color]::FromArgb(255, 24, 24, 28),
    [System.Drawing.Color]::FromArgb(255, 10, 10, 12)
)
$gCc.FillPath($brushCc, $pathCc)
$penCc = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(60, 255, 255, 255), 4)
$gCc.DrawPath($penCc, $pathCc)

$brushWhite = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
[System.Drawing.Point[]]$ptsLeft = @(
    (New-Object System.Drawing.Point 135, 160),
    (New-Object System.Drawing.Point 256, 246),
    (New-Object System.Drawing.Point 135, 352),
    (New-Object System.Drawing.Point 185, 352),
    (New-Object System.Drawing.Point 286, 246),
    (New-Object System.Drawing.Point 185, 160)
)
$gCc.FillPolygon($brushWhite, $ptsLeft)

[System.Drawing.Point[]]$ptsRight = @(
    (New-Object System.Drawing.Point 377, 160),
    (New-Object System.Drawing.Point 256, 246),
    (New-Object System.Drawing.Point 377, 352),
    (New-Object System.Drawing.Point 327, 352),
    (New-Object System.Drawing.Point 226, 246),
    (New-Object System.Drawing.Point 327, 160)
)
$gCc.FillPolygon($brushWhite, $ptsRight)

$gCc.Dispose()
$bmpCc.Save("$destDir\icon_capcut.png", [System.Drawing.Imaging.ImageFormat]::Png)
$bmpCc.Dispose()
Write-Host "Created icon_capcut.png"

# AI TOOLS ICON
$bmpAi = New-Object System.Drawing.Bitmap(512, 512, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$gAi = [System.Drawing.Graphics]::FromImage($bmpAi)
$gAi.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias

$pathAi = New-Object System.Drawing.Drawing2D.GraphicsPath
Add-RoundedRect $pathAi 16 16 480 480 110

$brushAi = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    (New-Object System.Drawing.Point 0, 0),
    (New-Object System.Drawing.Point 512, 512),
    [System.Drawing.Color]::FromArgb(255, 45, 18, 6),
    [System.Drawing.Color]::FromArgb(255, 15, 6, 2)
)
$gAi.FillPath($brushAi, $pathAi)
$penAi = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(255, 255, 120, 30), 6)
$gAi.DrawPath($penAi, $pathAi)

[System.Drawing.Point[]]$ptsStar = @(
    (New-Object System.Drawing.Point 256, 115),
    (New-Object System.Drawing.Point 284, 218),
    (New-Object System.Drawing.Point 385, 256),
    (New-Object System.Drawing.Point 284, 294),
    (New-Object System.Drawing.Point 256, 397),
    (New-Object System.Drawing.Point 228, 294),
    (New-Object System.Drawing.Point 127, 256),
    (New-Object System.Drawing.Point 228, 218)
)
$brushStar = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    (New-Object System.Drawing.Point 127, 115),
    (New-Object System.Drawing.Point 385, 397),
    [System.Drawing.Color]::FromArgb(255, 255, 190, 80),
    [System.Drawing.Color]::FromArgb(255, 255, 90, 0)
)
$gAi.FillPolygon($brushStar, $ptsStar)

[System.Drawing.Point[]]$ptsSmall = @(
    (New-Object System.Drawing.Point 375, 135),
    (New-Object System.Drawing.Point 388, 160),
    (New-Object System.Drawing.Point 415, 175),
    (New-Object System.Drawing.Point 388, 190),
    (New-Object System.Drawing.Point 375, 215),
    (New-Object System.Drawing.Point 362, 190),
    (New-Object System.Drawing.Point 335, 175),
    (New-Object System.Drawing.Point 362, 160)
)
$brushSmall = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255, 255, 220, 140))
$gAi.FillPolygon($brushSmall, $ptsSmall)

$gAi.Dispose()
$bmpAi.Save("$destDir\icon_aitools.png", [System.Drawing.Imaging.ImageFormat]::Png)
$bmpAi.Dispose()
Write-Host "Created icon_aitools.png"
