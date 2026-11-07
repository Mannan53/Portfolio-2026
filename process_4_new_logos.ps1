Add-Type -AssemblyName System.Drawing

$outDir = "C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets\marquee_logos"
if (-not (Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir -Force }

# 1. PROCESS SAHIL (media_1793810995297_d9092eca.jpg)
$fSahil = "C:\Users\Mannan Ansari\.gemini\antigravity\brain\25c37498-fc57-4e96-bba8-106b56c4ab06\.user_uploaded\media_1793810995297_d9092eca.jpg"
if (Test-Path $fSahil) {
    $src = [System.Drawing.Bitmap]::FromFile($fSahil)
    # Bounds: X=142..678, Y=396..560
    # Add small 8px padding
    $pad = 8
    $x1 = [Math]::Max(0, 142 - $pad)
    $y1 = [Math]::Max(0, 396 - $pad)
    $x2 = [Math]::Min($src.Width - 1, 678 + $pad)
    $y2 = [Math]::Min($src.Height - 1, 560 + $pad)
    $w = $x2 - $x1 + 1
    $h = $y2 - $y1 + 1
    
    $outBmp = New-Object System.Drawing.Bitmap($w, $h, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    for ($y = 0; $y -lt $h; $y++) {
        for ($x = 0; $x -lt $w; $x++) {
            $p = $src.GetPixel($x1 + $x, $y1 + $y)
            $luma = ($p.R * 0.299) + ($p.G * 0.587) + ($p.B * 0.114)
            # Invert: black (luma near 0) -> white alpha=255. White (luma near 255) -> alpha=0
            if ($luma -gt 245) {
                $outBmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(0, 0, 0, 0))
            } else {
                $alpha = [int][Math]::Min(255, [Math]::Max(0, (255 - $luma) * 1.15))
                $outBmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($alpha, 255, 255, 255))
            }
        }
    }
    $dest = Join-Path $outDir "logo_sahil.png"
    $outBmp.Save($dest, [System.Drawing.Imaging.ImageFormat]::Png)
    $src.Dispose()
    $outBmp.Dispose()
    Write-Host "Created logo_sahil.png ($w x $h)"
}

# 2. PROCESS SARVMANGALA (media_1793810995300_0c8058b7.jpg)
$fSarv = "C:\Users\Mannan Ansari\.gemini\antigravity\brain\25c37498-fc57-4e96-bba8-106b56c4ab06\.user_uploaded\media_1793810995300_0c8058b7.jpg"
if (Test-Path $fSarv) {
    $src = [System.Drawing.Bitmap]::FromFile($fSarv)
    # Bounds: X=188..632, Y=314..708
    $pad = 8
    $x1 = [Math]::Max(0, 188 - $pad)
    $y1 = [Math]::Max(0, 314 - $pad)
    $x2 = [Math]::Min($src.Width - 1, 632 + $pad)
    $y2 = [Math]::Min($src.Height - 1, 708 + $pad)
    $w = $x2 - $x1 + 1
    $h = $y2 - $y1 + 1
    
    $outBmp = New-Object System.Drawing.Bitmap($w, $h, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    for ($y = 0; $y -lt $h; $y++) {
        for ($x = 0; $x -lt $w; $x++) {
            $p = $src.GetPixel($x1 + $x, $y1 + $y)
            $luma = ($p.R * 0.299) + ($p.G * 0.587) + ($p.B * 0.114)
            if ($luma -gt 245) {
                $outBmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(0, 0, 0, 0))
            } else {
                $alpha = [int][Math]::Min(255, [Math]::Max(0, (255 - $luma) * 1.2))
                # Make the building mark and typography crisp white with slight warm/teal undertone or pure white
                $outBmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($alpha, 255, 255, 255))
            }
        }
    }
    $dest = Join-Path $outDir "logo_sarvmangala.png"
    $outBmp.Save($dest, [System.Drawing.Imaging.ImageFormat]::Png)
    $src.Dispose()
    $outBmp.Dispose()
    Write-Host "Created logo_sarvmangala.png ($w x $h)"
}

# 3. PROCESS SS INFINITUS (media_1793811007520_40277ec7.png)
$fSS = "C:\Users\Mannan Ansari\.gemini\antigravity\brain\25c37498-fc57-4e96-bba8-106b56c4ab06\.user_uploaded\media_1793811007520_40277ec7.png"
if (Test-Path $fSS) {
    $src = [System.Drawing.Bitmap]::FromFile($fSS)
    # Bounds: X=118..906, Y=106..320
    $pad = 6
    $x1 = [Math]::Max(0, 118 - $pad)
    $y1 = [Math]::Max(0, 106 - $pad)
    $x2 = [Math]::Min($src.Width - 1, 906 + $pad)
    $y2 = [Math]::Min($src.Height - 1, 320 + $pad)
    $w = $x2 - $x1 + 1
    $h = $y2 - $y1 + 1
    
    $outBmp = New-Object System.Drawing.Bitmap($w, $h, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    for ($y = 0; $y -lt $h; $y++) {
        for ($x = 0; $x -lt $w; $x++) {
            $p = $src.GetPixel($x1 + $x, $y1 + $y)
            if ($p.A -lt 15) {
                $outBmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(0, 0, 0, 0))
            } else {
                # Check if it's the neutral grey text ("SS" or "Live the life")
                # Grey has low saturation: |R-G| < 25 and |G-B| < 25
                $rgDiff = [Math]::Abs($p.R - $p.G)
                $gbDiff = [Math]::Abs($p.G - $p.B)
                $isGrey = ($rgDiff -lt 25 -and $gbDiff -lt 25 -and $p.R -lt 160)
                if ($isGrey) {
                    # Brighten grey to crisp white
                    $outBmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($p.A, 255, 255, 255))
                } else {
                    # Vibrant red/purple "Infinitus" and red "101" -> keep vibrant, slightly boost brightness
                    $r = [Math]::Min(255, [int]($p.R * 1.15))
                    $g = [Math]::Min(255, [int]($p.G * 1.1))
                    $b = [Math]::Min(255, [int]($p.B * 1.15))
                    $outBmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($p.A, $r, $g, $b))
                }
            }
        }
    }
    $dest = Join-Path $outDir "logo_ss_infinitus.png"
    $outBmp.Save($dest, [System.Drawing.Imaging.ImageFormat]::Png)
    $src.Dispose()
    $outBmp.Dispose()
    Write-Host "Created logo_ss_infinitus.png ($w x $h)"
}

# 4. PROCESS ORCHID ENCLAVE (media_1793811045203_c3ad9e35.jpg)
$fOrchid = "C:\Users\Mannan Ansari\.gemini\antigravity\brain\25c37498-fc57-4e96-bba8-106b56c4ab06\.user_uploaded\media_1793811045203_c3ad9e35.jpg"
if (Test-Path $fOrchid) {
    $src = [System.Drawing.Bitmap]::FromFile($fOrchid)
    # Bounds: X=184..838, Y=352..672
    $pad = 8
    $x1 = [Math]::Max(0, 184 - $pad)
    $y1 = [Math]::Max(0, 352 - $pad)
    $x2 = [Math]::Min($src.Width - 1, 838 + $pad)
    $y2 = [Math]::Min($src.Height - 1, 672 + $pad)
    $w = $x2 - $x1 + 1
    $h = $y2 - $y1 + 1
    
    $outBmp = New-Object System.Drawing.Bitmap($w, $h, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    for ($y = 0; $y -lt $h; $y++) {
        for ($x = 0; $x -lt $w; $x++) {
            $p = $src.GetPixel($x1 + $x, $y1 + $y)
            $luma = ($p.R * 0.299) + ($p.G * 0.587) + ($p.B * 0.114)
            if ($luma -gt 246) {
                # White background -> transparent
                $outBmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(0, 0, 0, 0))
            } else {
                # Distinguish between:
                # 1. Pink flower (High R, moderate G, moderate B, R > G+40)
                # 2. Yellow center (High R, High G, low B)
                # 3. Gold "ENCLAVE" (R > 130, G > 120, B < 80)
                # 4. Dark green "ORCHID" (G >= R, low overall luma, B moderate)
                $isPink = ($p.R -gt 170 -and $p.R -gt ($p.G + 30) -and $p.B -gt 90)
                $isYellow = ($p.R -gt 180 -and $p.G -gt 150 -and $p.B -lt 100)
                $isGold = ($p.R -gt 120 -and $p.G -gt 100 -and $p.B -lt 80)
                
                if ($isPink) {
                    $alpha = [int][Math]::Min(255, (255 - [Math]::Abs($luma - 160)) * 2.5)
                    $outBmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(255, [Math]::Min(255, [int]($p.R * 1.1)), $p.G, [Math]::Min(255, [int]($p.B * 1.1))))
                } elseif ($isYellow) {
                    $outBmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(255, 255, 215, 0))
                } elseif ($isGold) {
                    # Gold text "ENCLAVE" - boost brightness to metallic gold
                    $outBmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(255, 230, 195, 80))
                } else {
                    # Dark green "ORCHID" text -> crisp bright white
                    $alpha = [int][Math]::Min(255, [Math]::Max(0, (255 - $luma) * 1.3))
                    $outBmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($alpha, 255, 255, 255))
                }
            }
        }
    }
    $dest = Join-Path $outDir "logo_orchid.png"
    $outBmp.Save($dest, [System.Drawing.Imaging.ImageFormat]::Png)
    $src.Dispose()
    $outBmp.Dispose()
    Write-Host "Created logo_orchid.png ($w x $h)"
}
