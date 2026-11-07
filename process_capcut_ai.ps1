Add-Type -AssemblyName System.Drawing

$dir = "C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets\software_icons"

# Process CapCut (black on white -> white on transparent)
$pathCC = Join-Path $dir "icon_capcut.png"
$bmp = [System.Drawing.Bitmap]::FromFile($pathCC)
$out = New-Object System.Drawing.Bitmap($bmp.Width, $bmp.Height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
for ($y = 0; $y -lt $bmp.Height; $y++) {
    for ($x = 0; $x -lt $bmp.Width; $x++) {
        $p = $bmp.GetPixel($x, $y)
        $luma = ($p.R * 0.299) + ($p.G * 0.587) + ($p.B * 0.114)
        if ($luma -gt 240) {
            $out.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(0, 0, 0, 0))
        } else {
            $alpha = [int][Math]::Min(255, [Math]::Max(0, (255 - $luma) * 1.2))
            $out.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($alpha, 255, 255, 255))
        }
    }
}
$bmp.Dispose()
$tmp = "$pathCC.tmp.png"
$out.Save($tmp, [System.Drawing.Imaging.ImageFormat]::Png)
$out.Dispose()
Move-Item -Path $tmp -Destination $pathCC -Force
Write-Host "Processed icon_capcut.png"

# Process AI Tools (black on white -> white on transparent)
$pathAI = Join-Path $dir "icon_aitools.png"
$bmp2 = [System.Drawing.Bitmap]::FromFile($pathAI)
$out2 = New-Object System.Drawing.Bitmap($bmp2.Width, $bmp2.Height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
for ($y = 0; $y -lt $bmp2.Height; $y++) {
    for ($x = 0; $x -lt $bmp2.Width; $x++) {
        $p = $bmp2.GetPixel($x, $y)
        $luma = ($p.R * 0.299) + ($p.G * 0.587) + ($p.B * 0.114)
        if ($luma -gt 240) {
            $out2.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(0, 0, 0, 0))
        } else {
            $alpha = [int][Math]::Min(255, [Math]::Max(0, (255 - $luma) * 1.2))
            $out2.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($alpha, 255, 255, 255))
        }
    }
}
$bmp2.Dispose()
$tmp2 = "$pathAI.tmp.png"
$out2.Save($tmp2, [System.Drawing.Imaging.ImageFormat]::Png)
$out2.Dispose()
Move-Item -Path $tmp2 -Destination $pathAI -Force
Write-Host "Processed icon_aitools.png"
