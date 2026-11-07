Add-Type -AssemblyName System.Drawing

$dir = "C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets\marquee_logos"
$files = Get-ChildItem "$dir\logo_*.png"

foreach ($f in $files) {
    # Skip our newly generated 4 files and jnrt since they are already tightly cropped
    if ($f.Name -in @("logo_sahil.png", "logo_sarvmangala.png", "logo_ss_infinitus.png", "logo_orchid.png", "logo_jnrt.png")) {
        continue
    }
    
    $bmp = [System.Drawing.Bitmap]::FromFile($f.FullName)
    $minX = $bmp.Width; $minY = $bmp.Height; $maxX = 0; $maxY = 0
    
    for ($y = 0; $y -lt $bmp.Height; $y++) {
        for ($x = 0; $x -lt $bmp.Width; $x++) {
            $p = $bmp.GetPixel($x, $y)
            if ($p.A -gt 25) {
                if ($x -lt $minX) { $minX = $x }
                if ($x -gt $maxX) { $maxX = $x }
                if ($y -lt $minY) { $minY = $y }
                if ($y -gt $maxY) { $maxY = $y }
            }
        }
    }
    
    # Check if there is significant padding (more than 10px on any side relative to size)
    $padLeft = $minX
    $padRight = $bmp.Width - 1 - $maxX
    $padTop = $minY
    $padBottom = $bmp.Height - 1 - $maxY
    
    Write-Host "$($f.Name): Margins L=$padLeft, R=$padRight, T=$padTop, B=$padBottom"
    
    if ($padLeft -gt 15 -or $padRight -gt 15 -or $padTop -gt 15 -or $padBottom -gt 15) {
        $pad = 6
        $x1 = [Math]::Max(0, $minX - $pad)
        $y1 = [Math]::Max(0, $minY - $pad)
        $x2 = [Math]::Min($bmp.Width - 1, $maxX + $pad)
        $y2 = [Math]::Min($bmp.Height - 1, $maxY + $pad)
        $cropW = $x2 - $x1 + 1
        $cropH = $y2 - $y1 + 1
        
        $cropped = New-Object System.Drawing.Bitmap($cropW, $cropH, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
        $g = [System.Drawing.Graphics]::FromImage($cropped)
        $srcRect = New-Object System.Drawing.Rectangle($x1, $y1, $cropW, $cropH)
        $destRect = New-Object System.Drawing.Rectangle(0, 0, $cropW, $cropH)
        $g.DrawImage($bmp, $destRect, $srcRect, [System.Drawing.GraphicsUnit]::Pixel)
        $g.Dispose()
        $bmp.Dispose()
        
        $tempPath = "$($f.FullName).tmp.png"
        $cropped.Save($tempPath, [System.Drawing.Imaging.ImageFormat]::Png)
        $cropped.Dispose()
        
        Move-Item -Path $tempPath -Destination $f.FullName -Force
        Write-Host "  -> Tight-cropped $($f.Name) to $cropW x $cropH"
    } else {
        $bmp.Dispose()
    }
}
