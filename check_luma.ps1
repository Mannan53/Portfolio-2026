Add-Type -AssemblyName System.Drawing

$dir = "C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets\marquee_logos"
$files = Get-ChildItem "$dir\*.png"

foreach ($f in $files) {
    $bmp = [System.Drawing.Bitmap]::FromFile($f.FullName)
    # Sample non-transparent pixels to see average brightness
    $totalLuma = 0
    $count = 0
    $stepX = [Math]::Max(1, [int]($bmp.Width / 20))
    $stepY = [Math]::Max(1, [int]($bmp.Height / 20))
    for ($y = 0; $y -lt $bmp.Height; $y += $stepY) {
        for ($x = 0; $x -lt $bmp.Width; $x += $stepX) {
            $p = $bmp.GetPixel($x, $y)
            if ($p.A -gt 30) {
                $luma = ($p.R * 0.299) + ($p.G * 0.587) + ($p.B * 0.114)
                $totalLuma += $luma
                $count++
            }
        }
    }
    $avgLuma = if ($count -gt 0) { [int]($totalLuma / $count) } else { 0 }
    Write-Host "$($f.Name) -> Count: $count, Avg Luma: $avgLuma (Width: $($bmp.Width), Height: $($bmp.Height))"
    $bmp.Dispose()
}
