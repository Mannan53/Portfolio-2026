Add-Type -AssemblyName System.Drawing

$f = "C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets\marquee_logos\logo_kotak.png"
$bmp = [System.Drawing.Bitmap]::FromFile($f)
$corner = $bmp.GetPixel(0, 0)
Write-Host "Corner pixel: A=$($corner.A), R=$($corner.R), G=$($corner.G), B=$($corner.B)"
$bmp.Dispose()
