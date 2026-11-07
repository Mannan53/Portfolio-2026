Add-Type -AssemblyName System.Drawing

$files = @(
    "C:\Users\Mannan Ansari\.gemini\antigravity\brain\25c37498-fc57-4e96-bba8-106b56c4ab06\.user_uploaded\media_1793810995297_d9092eca.jpg",
    "C:\Users\Mannan Ansari\.gemini\antigravity\brain\25c37498-fc57-4e96-bba8-106b56c4ab06\.user_uploaded\media_1793810995300_0c8058b7.jpg",
    "C:\Users\Mannan Ansari\.gemini\antigravity\brain\25c37498-fc57-4e96-bba8-106b56c4ab06\.user_uploaded\media_1793811007520_40277ec7.png",
    "C:\Users\Mannan Ansari\.gemini\antigravity\brain\25c37498-fc57-4e96-bba8-106b56c4ab06\.user_uploaded\media_1793811045203_c3ad9e35.jpg"
)

foreach ($f in $files) {
    if (Test-Path $f) {
        $bmp = [System.Drawing.Bitmap]::FromFile($f)
        # sample corner pixels to see background
        $c1 = $bmp.GetPixel(0, 0)
        $c2 = $bmp.GetPixel($bmp.Width - 1, 0)
        $c3 = $bmp.GetPixel(0, $bmp.Height - 1)
        Write-Host "File: $([System.IO.Path]::GetFileName($f)) - $($bmp.Width)x$($bmp.Height) - Corner: R=$($c1.R),G=$($c1.G),B=$($c1.B),A=$($c1.A)"
        
        # Find bounding box of content (pixels different from background)
        $bgR = $c1.R; $bgG = $c1.G; $bgB = $c1.B
        $minX = $bmp.Width; $minY = $bmp.Height; $maxX = 0; $maxY = 0
        $step = 2
        for ($y = 0; $y -lt $bmp.Height; $y += $step) {
            for ($x = 0; $x -lt $bmp.Width; $x += $step) {
                $p = $bmp.GetPixel($x, $y)
                # Check if different from white/transparent
                $diff = [Math]::Abs($p.R - 255) + [Math]::Abs($p.G - 255) + [Math]::Abs($p.B - 255)
                if ($p.A -gt 20 -and $diff -gt 30) {
                    if ($x -lt $minX) { $minX = $x }
                    if ($x -gt $maxX) { $maxX = $x }
                    if ($y -lt $minY) { $minY = $y }
                    if ($y -gt $maxY) { $maxY = $y }
                }
            }
        }
        Write-Host "  Content bounds: X=$minX..$maxX (W=$($maxX-$minX)), Y=$minY..$maxY (H=$($maxY-$minY))"
        $bmp.Dispose()
    }
}
