Add-Type -AssemblyName System.Drawing

$src = "C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets\hero_anchor.png"
$img = [System.Drawing.Bitmap]::FromFile($src)
$w = $img.Width
$h = $img.Height

$out = New-Object System.Drawing.Bitmap($w, $h, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)

# Man center is around x=400, y=360
# Radius for person protection
for ($y = 0; $y -lt $h; $y++) {
    for ($x = 0; $x -lt $w; $x++) {
        $p = $img.GetPixel($x, $y)
        $r = [double]$p.R
        $g = [double]$p.G
        $b = [double]$p.B
        $origA = $p.A

        if ($origA -eq 0) {
            $out.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(0, 0, 0, 0))
            continue
        }

        # Check if pixel is background red smoke:
        # Background has high R relative to G and B, and G/B are low
        # e.g., (R > 75) and (G < 45) and (B < 35) and (R > (G * 2.5))
        $isBgSmoke = ($r -gt 65) -and ($g -lt 55) -and ($b -lt 40) -and ($r -gt ($g * 2.0))
        
        # Protect face / skin: skin has substantial G and B (e.g. G > 65 and B > 45)
        $isSkin = ($g -gt 65) -and ($b -gt 45) -and ($r -gt $g)

        # Hair / Beard: very dark, R < 70, G < 60, B < 60
        $isDarkHair = ($r -lt 70) -and ($g -lt 60) -and ($b -lt 60)

        # Shirt: R < 75, G < 65, B < 65
        $isShirt = ($r -lt 75) -and ($g -lt 65) -and ($b -lt 65)

        if ($isSkin -or $isDarkHair -or $isShirt) {
            # Keep person fully opaque (or keep current alpha)
            $out.SetPixel($x, $y, $p)
        } elseif ($isBgSmoke) {
            # Smoothly fade out red smoke based on distance from center or red intensity
            $redDiff = $r - [Math]::Max($g * 2.0, $b * 2.0)
            $alphaRatio = [Math]::Max(0.0, 1.0 - ($redDiff / 70.0))
            # feather
            $newA = [int]($origA * $alphaRatio * 0.4)
            $out.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($newA, [int]$r, [int]$g, [int]$b))
        } else {
            # Transition edge: soften
            $out.SetPixel($x, $y, $p)
        }
    }
}

$destPath = "C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets\hero_anchor_transparent.png"
$out.Save($destPath, [System.Drawing.Imaging.ImageFormat]::Png)

$out.Dispose()
$img.Dispose()
Write-Host "Created transparent anchor cutout at $destPath"
