Add-Type -AssemblyName System.Drawing

$dir = "C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets\software_icons"
$files = Get-ChildItem "$dir\*.png"

foreach ($f in $files) {
    $bmp = [System.Drawing.Bitmap]::FromFile($f.FullName)
    $c0 = $bmp.GetPixel(0, 0)
    $cMid = $bmp.GetPixel([int]($bmp.Width/2), [int]($bmp.Height/2))
    Write-Host "$($f.Name): $($bmp.Width)x$($bmp.Height), TopLeft Alpha: $($c0.A), Center: R=$($cMid.R), G=$($cMid.G), B=$($cMid.B)"
    $bmp.Dispose()
}
