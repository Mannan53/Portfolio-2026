Add-Type -AssemblyName System.Drawing

$sourcePath = "C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets\reference.png"
$img = [System.Drawing.Bitmap]::FromFile($sourcePath)

Write-Host "Image Size: $($img.Width) x $($img.Height)"
$img.Dispose()
