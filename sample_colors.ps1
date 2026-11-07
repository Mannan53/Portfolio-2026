Add-Type -AssemblyName System.Drawing

$img = [System.Drawing.Bitmap]::FromFile("C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets\hero_anchor.png")

Write-Host "Width: $($img.Width), Height: $($img.Height)"

# Sample top-left corner (background)
$bgSample1 = $img.GetPixel(50, 50)
Write-Host "Top-Left Background RGB: R=$($bgSample1.R), G=$($bgSample1.G), B=$($bgSample1.B)"

# Sample top-right corner (background)
$bgSample2 = $img.GetPixel(750, 50)
Write-Host "Top-Right Background RGB: R=$($bgSample2.R), G=$($bgSample2.G), B=$($bgSample2.B)"

# Sample hair (top center)
$hairSample = $img.GetPixel(400, 100)
Write-Host "Hair RGB: R=$($hairSample.R), G=$($hairSample.G), B=$($hairSample.B)"

# Sample face (nose/forehead)
$faceSample = $img.GetPixel(400, 250)
Write-Host "Face RGB: R=$($faceSample.R), G=$($faceSample.G), B=$($faceSample.B)"

# Sample shirt
$shirtSample = $img.GetPixel(400, 550)
Write-Host "Shirt RGB: R=$($shirtSample.R), G=$($shirtSample.G), B=$($shirtSample.B)"

$img.Dispose()
