Add-Type -AssemblyName System.Drawing

$src = "C:\Users\Mannan Ansari\.gemini\antigravity\brain\25c37498-fc57-4e96-bba8-106b56c4ab06\.user_uploaded\media_1793810657921_19e3b7cb.png"
$bmp = [System.Drawing.Bitmap]::FromFile($src)

# Sample text: around x=250, y=300 (where "JEHAN" is)
$sampleText = $bmp.GetPixel(250, 290)
Write-Host "Text Sample: A=$($sampleText.A), R=$($sampleText.R), G=$($sampleText.G), B=$($sampleText.B)"

# Sample bird body: around x=150, y=230
$sampleBird = $bmp.GetPixel(150, 230)
Write-Host "Bird Sample: A=$($sampleBird.A), R=$($sampleBird.R), G=$($sampleBird.G), B=$($sampleBird.B)"

$bmp.Dispose()
