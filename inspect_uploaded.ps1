Add-Type -AssemblyName System.Drawing

$src = "C:\Users\Mannan Ansari\.gemini\antigravity\brain\25c37498-fc57-4e96-bba8-106b56c4ab06\.user_uploaded\media_1793433026168_fef9c284.png"
$img = [System.Drawing.Bitmap]::FromFile($src)
Write-Host "Uploaded image size: $($img.Width) x $($img.Height)"
$img.Dispose()
