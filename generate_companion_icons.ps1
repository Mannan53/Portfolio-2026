Add-Type -AssemblyName System.Drawing

$destDir = "C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets\software_icons"

# Function to draw rounded rectangle path
function Add-RoundedRect($path, $x, $y, $w, $h, $radius) {
    $d = $radius * 2
    $path.AddArc($x, $y, $d, $d, 180, 90)
    $path.AddArc($x + $w - $d, $y, $d, $d, 270, 90)
    $path.AddArc($x + $w - $d, $y + $h - $d, $d, $d, 0, 90)
    $path.AddArc($x, $y + $h - $d, $d, $d, 90, 90)
    $path.CloseFigure()
}

# 1. PREMIERE PRO ICON (512x512)
$bmpPr = New-Object System.Drawing.Bitmap(512, 512, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$gPr = [System.Drawing.Graphics]::FromImage($bmpPr)
$gPr.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$gPr.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

$pathPr = New-Object System.Drawing.Drawing2D.GraphicsPath
Add-RoundedRect $pathPr 12 12 488 488 110

# Dark purple gradient
$brushPr = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    (New-Object System.Drawing.Point(0, 0)),
    (New-Object System.Drawing.Point(512, 512)),
    [System.Drawing.Color]::FromArgb(255, 15, 0, 45),
    [System.Drawing.Color]::FromArgb(255, 5, 0, 20)
)
$gPr.FillPath($brushPr, $pathPr)

# Border
$penPr = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(255, 234, 119, 255), 10)
$gPr.DrawPath($penPr, $pathPr)

# Text "Pr"
$fontPr = New-Object System.Drawing.Font("Arial", 210, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Pixel)
$textBrushPr = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255, 234, 119, 255))
$sf = New-Object System.Drawing.StringFormat
$sf.Alignment = [System.Drawing.StringAlignment]::Center
$sf.LineAlignment = [System.Drawing.StringAlignment]::Center
$gPr.DrawString("Pr", $fontPr, $textBrushPr, (New-Object System.Drawing.RectangleF(0, 10, 512, 512)), $sf)

$gPr.Dispose()
$bmpPr.Save("$destDir\icon_premiere.png", [System.Drawing.Imaging.ImageFormat]::Png)
$bmpPr.Dispose()
Write-Host "Created icon_premiere.png"

# 2. CAPCUT ICON (512x512)
$bmpCc = New-Object System.Drawing.Bitmap(512, 512, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$gCc = [System.Drawing.Graphics]::FromImage($bmpCc)
$gCc.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias

$pathCc = New-Object System.Drawing.Drawing2D.GraphicsPath
Add-RoundedRect $pathCc 12 12 488 488 110

# Dark sleek gradient
$brushCc = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    (New-Object System.Drawing.Point(0, 0)),
    (New-Object System.Drawing.Point(512, 512)),
    [System.Drawing.Color]::FromArgb(255, 20, 20, 24),
    [System.Drawing.Color]::FromArgb(255, 8, 8, 10)
)
$gCc.FillPath($brushCc, $pathCc)
$penCc = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(70, 255, 255, 255), 6)
$gCc.DrawPath($penCc, $pathCc)

# CapCut Ribbon Symbol
$brushWhite = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
# Left chevron
$ptsLeft = @(
    New-Object System.Drawing.Point(120, 160),
    New-Object System.Drawing.Point(260, 256),
    New-Object System.Drawing.Point(120, 352),
    New-Object System.Drawing.Point(170, 352),
    New-Object System.Drawing.Point(290, 256),
    New-Object System.Drawing.Point(170, 160)
)
$gCc.FillPolygon($brushWhite, $ptsLeft)

# Right chevron
$ptsRight = @(
    New-Object System.Drawing.Point(392, 160),
    New-Object System.Drawing.Point(252, 256),
    New-Object System.Drawing.Point(392, 352),
    New-Object System.Drawing.Point(342, 352),
    New-Object System.Drawing.Point(222, 256),
    New-Object System.Drawing.Point(342, 160)
)
$gCc.FillPolygon($brushWhite, $ptsRight)

$gCc.Dispose()
$bmpCc.Save("$destDir\icon_capcut.png", [System.Drawing.Imaging.ImageFormat]::Png)
$bmpCc.Dispose()
Write-Host "Created icon_capcut.png"

# 3. AI TOOLS ICON (512x512)
$bmpAi = New-Object System.Drawing.Bitmap(512, 512, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$gAi = [System.Drawing.Graphics]::FromImage($bmpAi)
$gAi.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias

$pathAi = New-Object System.Drawing.Drawing2D.GraphicsPath
Add-RoundedRect $pathAi 12 12 488 488 110

$brushAi = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    (New-Object System.Drawing.Point(0, 0)),
    (New-Object System.Drawing.Point(512, 512)),
    [System.Drawing.Color]::FromArgb(255, 45, 18, 6),
    [System.Drawing.Color]::FromArgb(255, 15, 6, 2)
)
$gAi.FillPath($brushAi, $pathAi)
$penAi = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(255, 255, 120, 30), 8)
$gAi.DrawPath($penAi, $pathAi)

# Main Sparkle / Star
$ptsStar = @(
    New-Object System.Drawing.Point(256, 110),
    New-Object System.Drawing.Point(286, 216),
    New-Object System.Drawing.Point(392, 256),
    New-Object System.Drawing.Point(286, 296),
    New-Object System.Drawing.Point(256, 402),
    New-Object System.Drawing.Point(226, 296),
    New-Object System.Drawing.Point(120, 256),
    New-Object System.Drawing.Point(226, 216)
)
$brushStar = New-Object System.Drawing.Drawing2D.LinearGradientBrush(
    (New-Object System.Drawing.Point(120, 110)),
    (New-Object System.Drawing.Point(392, 402)),
    [System.Drawing.Color]::FromArgb(255, 255, 180, 80),
    [System.Drawing.Color]::FromArgb(255, 255, 90, 0)
)
$gAi.FillPolygon($brushStar, $ptsStar)

# Small secondary star
$ptsSmall = @(
    New-Object System.Drawing.Point(380, 130),
    New-Object System.Drawing.Point(395, 160),
    New-Object System.Drawing.Point(425, 175),
    New-Object System.Drawing.Point(395, 190),
    New-Object System.Drawing.Point(380, 220),
    New-Object System.Drawing.Point(365, 190),
    New-Object System.Drawing.Point(335, 175),
    New-Object System.Drawing.Point(365, 160)
)
$brushSmall = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255, 255, 210, 120))
$gAi.FillPolygon($brushSmall, $ptsSmall)

$gAi.Dispose()
$bmpAi.Save("$destDir\icon_aitools.png", [System.Drawing.Imaging.ImageFormat]::Png)
$bmpAi.Dispose()
Write-Host "Created icon_aitools.png"
