Add-Type -AssemblyName System.Drawing

$f1 = "C:\Users\Mannan Ansari\.gemini\antigravity\brain\25c37498-fc57-4e96-bba8-106b56c4ab06\.user_uploaded\media_1793810995297_d9092eca.jpg"
$f2 = "C:\Users\Mannan Ansari\.gemini\antigravity\brain\25c37498-fc57-4e96-bba8-106b56c4ab06\.user_uploaded\media_1793810995300_0c8058b7.jpg"
$f3 = "C:\Users\Mannan Ansari\.gemini\antigravity\brain\25c37498-fc57-4e96-bba8-106b56c4ab06\.user_uploaded\media_1793811007520_40277ec7.png"
$f4 = "C:\Users\Mannan Ansari\.gemini\antigravity\brain\25c37498-fc57-4e96-bba8-106b56c4ab06\.user_uploaded\media_1793811045203_c3ad9e35.jpg"

function Sample-Points($path, $name) {
    $bmp = [System.Drawing.Bitmap]::FromFile($path)
    Write-Host "=== $name ($($bmp.Width)x$($bmp.Height)) ==="
    # Sample center area
    $cx = [int]($bmp.Width / 2)
    $cy = [int]($bmp.Height / 2)
    for ($dy = -50; $dy -le 50; $dy += 25) {
        $p = $bmp.GetPixel($cx, $cy + $dy)
        Write-Host "Pixel at ($cx, $($cy+$dy)): R=$($p.R), G=$($p.G), B=$($p.B), A=$($p.A)"
    }
    $bmp.Dispose()
}

Sample-Points $f1 "SAHIL"
Sample-Points $f2 "SARVMANGALA"
Sample-Points $f3 "SS INFINITUS"
Sample-Points $f4 "ORCHID"
