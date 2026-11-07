Add-Type -AssemblyName System.Drawing

$dir = "C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets\marquee_logos"
$files = Get-ChildItem "$dir\*.png"

foreach ($f in $files) {
    $bmp = [System.Drawing.Bitmap]::FromFile($f.FullName)
    # Find bounding box of non-transparent pixels
    $minX = $bmp.Width; $minY = $bmp.Height; $maxX = 0; $maxY = 0
    $step = [Math]::Max(1, [int]($bmp.Width / 100))
    for ($y = 0; $y -lt $bmp.Height; $y += $step) {
        for ($x = 0; $x -lt $bmp.Width; $x += $step) {
            $p = $bmp.GetPixel($x, $y)
            if ($p.A -gt 25) {
                if ($x -lt $minX) { $minX = $x }
                if ($x -gt $maxX) { $maxX = $x }
                if ($y -lt $minY) { $minY = $y }
                if ($y -gt $maxY) { $maxY = $y }
            }
        }
    }
    $cropW = [Math]::Max(1, $maxX - $minX)
    $cropH = [Math]::Max(1, $maxY - $minY)
    $ratio = [Math]::Round($cropW / $cropH, 2)
    Write-Host "$($f.Name): Total=$($bmp.Width)x$($bmp.Height), Content=$cropW x $cropH (Ratio=$ratio), Margins: L=$minX, R=$($bmp.Width-$maxX), T=$minY, B=$($bmp.Height-$maxY)"
    $bmp.Dispose()
}
