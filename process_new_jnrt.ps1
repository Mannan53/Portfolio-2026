Add-Type -AssemblyName System.Drawing

$src = "C:\Users\Mannan Ansari\.gemini\antigravity\brain\25c37498-fc57-4e96-bba8-106b56c4ab06\.user_uploaded\media_1793810657921_19e3b7cb.png"
$bmp = [System.Drawing.Bitmap]::FromFile($src)

$minX = $bmp.Width
$maxX = 0
$minY = $bmp.Height
$maxY = 0

for ($y = 0; $y -lt $bmp.Height; $y++) {
    for ($x = 0; $x -lt $bmp.Width; $x++) {
        $p = $bmp.GetPixel($x, $y)
        if ($p.A -gt 15) {
            if ($x -lt $minX) { $minX = $x }
            if ($x -gt $maxX) { $maxX = $x }
            if ($y -lt $minY) { $minY = $y }
            if ($y -gt $maxY) { $maxY = $y }
        }
    }
}

Write-Host "Tight Bounding Box: X=$minX..$maxX (W=$($maxX - $minX + 1)), Y=$minY..$maxY (H=$($maxY - $minY + 1))"

$cropW = $maxX - $minX + 1
$cropH = $maxY - $minY + 1

$cropped = New-Object System.Drawing.Bitmap($cropW, $cropH, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)

# Now, for the text:
# The bird is primarily on the left (x < minX + cropW * 0.40) or has strong orange/gold color (R > 180, G > 70, B < 100).
# The text "JEHAN NUMA RETREAT" is neutral dark grey (R ~ G ~ B, luma < 120).
# If we turn the neutral dark grey text into clean white (#FFFFFF) with original alpha, it will be readable on dark backgrounds!
for ($cy = 0; $cy -lt $cropH; $cy++) {
    for ($cx = 0; $cx -lt $cropW; $cx++) {
        $origX = $minX + $cx
        $origY = $minY + $cy
        $p = $bmp.GetPixel($origX, $origY)
        
        if ($p.A -eq 0) {
            $cropped.SetPixel($cx, $cy, [System.Drawing.Color]::FromArgb(0, 0, 0, 0))
            continue
        }

        # Check if pixel is part of dark grey text:
        # Text has R, G, B close to each other and R < 140, G < 140, B < 140
        $diffRG = [Math]::Abs($p.R - $p.G)
        $diffRB = [Math]::Abs($p.R - $p.B)
        $isNeutral = ($diffRG -lt 25) -and ($diffRB -lt 25)
        $isDark = ($p.R -lt 140) -and ($p.G -lt 140) -and ($p.B -lt 140)

        # Is it in the text region? Text is predominantly on the right half or lower right
        if ($isNeutral -and $isDark -and ($cx -gt ($cropW * 0.20))) {
            # Turn into crisp white text with the same anti-aliasing alpha
            $cropped.SetPixel($cx, $cy, [System.Drawing.Color]::FromArgb($p.A, 255, 255, 255))
        } else {
            # Keep original bird colors (terracotta orange & ornate gold pattern)
            $cropped.SetPixel($cx, $cy, $p)
        }
    }
}

$destPath = "C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets\marquee_logos\logo_jnrt.png"
$cropped.Save($destPath, [System.Drawing.Imaging.ImageFormat]::Png)

$cropped.Dispose()
$bmp.Dispose()

Write-Host "Saved cropped & enhanced JNRT logo to: $destPath"
