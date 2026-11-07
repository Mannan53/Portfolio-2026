Add-Type -AssemblyName System.Drawing

$files = @(
    "C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets\marquee_logos\logo_capers.png",
    "C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets\marquee_logos\logo_d2r.png"
)

foreach ($f in $files) {
    $bmp = [System.Drawing.Bitmap]::FromFile($f)
    Write-Host "=== $($bmp.Width)x$($bmp.Height) for $([System.IO.Path]::GetFileName($f)) ==="
    $count = 0
    for ($y = 0; $y -lt $bmp.Height; $y += [int]($bmp.Height/10)) {
        for ($x = 0; $x -lt $bmp.Width; $x += [int]($bmp.Width/10)) {
            $p = $bmp.GetPixel($x, $y)
            if ($p.A -gt 30) {
                Write-Host "Pixel ($x, $y): R=$($p.R), G=$($p.G), B=$($p.B), A=$($p.A)"
                $count++
                if ($count -ge 5) { break }
            }
        }
        if ($count -ge 5) { break }
    }
    $bmp.Dispose()
}
