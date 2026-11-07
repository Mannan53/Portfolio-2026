Add-Type -AssemblyName System.Drawing

$assetsDir = "C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets"
$files = @("project_lawyer1.png", "project_trava.png", "project_hebrew.png", "project_lawyer2.png")

foreach ($file in $files) {
    $src = Join-Path $assetsDir $file
    $dest = Join-Path $assetsDir ($file.Replace(".png", "_hq.png"))
    
    $orig = [System.Drawing.Bitmap]::FromFile($src)
    $newW = 700
    $newH = 500
    $hq = New-Object System.Drawing.Bitmap($newW, $newH, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $g = [System.Drawing.Graphics]::FromImage($hq)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    
    $g.DrawImage($orig, 0, 0, $newW, $newH)
    $g.Dispose()
    $orig.Dispose()
    
    $hq.Save($dest, [System.Drawing.Imaging.ImageFormat]::Png)
    $hq.Dispose()
    Write-Host "Upscaled: $dest"
}
