Add-Type -AssemblyName System.Drawing

$dir = "C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets\software_icons"
$files = Get-ChildItem "$dir\*.png"

foreach ($f in $files) {
    $bmp = [System.Drawing.Bitmap]::FromFile($f.FullName)
    $minX = $bmp.Width; $minY = $bmp.Height; $maxX = 0; $maxY = 0
    $step = 4
    for ($y = 0; $y -lt $bmp.Height; $y += $step) {
        for ($x = 0; $x -lt $bmp.Width; $x += $step) {
            $p = $bmp.GetPixel($x, $y)
            if ($p.A -gt 20) {
                if ($x -lt $minX) { $minX = $x }
                if ($x -gt $maxX) { $maxX = $x }
                if ($y -lt $minY) { $minY = $y }
                if ($y -gt $maxY) { $maxY = $y }
            }
        }
    }
    Write-Host "$($f.Name): Total=$($bmp.Width)x$($bmp.Height), Content bounds: X=$minX..$maxX (W=$($maxX-$minX)), Y=$minY..$maxY (H=$($maxY-$minY))"
    $bmp.Dispose()
}
