Add-Type -AssemblyName System.Drawing

$src = "C:\Users\Mannan Ansari\.gemini\antigravity\brain\25c37498-fc57-4e96-bba8-106b56c4ab06\.user_uploaded\media_1793810657921_19e3b7cb.png"
$bmp = [System.Drawing.Bitmap]::FromFile($src)

Write-Host "Size: $($bmp.Width) x $($bmp.Height)"

$corner = $bmp.GetPixel(10, 10)
Write-Host "Corner pixel: A=$($corner.A), R=$($corner.R), G=$($corner.G), B=$($corner.B)"

$bmp.Dispose()
