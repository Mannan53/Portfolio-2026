Add-Type -AssemblyName System.Drawing

$crops = @{
    "logo_enrise.png"   = @{ X = 620; Y = 665; W = 3350; H = 3125 }
    "logo_sayaji.png"   = @{ X = 150; Y = 150; W = 900;  H = 840  }
    "logo_sheraton.png" = @{ X = 135; Y = 24;  W = 437;  H = 330  }
    "logo_kotak.png"    = @{ X = 55;  Y = 8;   W = 1090; H = 236  }
}

$dir = "C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets\marquee_logos"

foreach ($file in $crops.Keys) {
    $path = Join-Path $dir $file
    if (Test-Path $path) {
        $c = $crops[$file]
        $bmp = [System.Drawing.Bitmap]::FromFile($path)
        $cropped = New-Object System.Drawing.Bitmap($c.W, $c.H, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
        $g = [System.Drawing.Graphics]::FromImage($cropped)
        $srcRect = New-Object System.Drawing.Rectangle($c.X, $c.Y, $c.W, $c.H)
        $destRect = New-Object System.Drawing.Rectangle(0, 0, $c.W, $c.H)
        $g.DrawImage($bmp, $destRect, $srcRect, [System.Drawing.GraphicsUnit]::Pixel)
        $g.Dispose()
        $bmp.Dispose()
        
        $tmp = "$path.tmp.png"
        $cropped.Save($tmp, [System.Drawing.Imaging.ImageFormat]::Png)
        $cropped.Dispose()
        Move-Item -Path $tmp -Destination $path -Force
        Write-Host "Cropped $file to $($c.W)x$($c.H)"
    }
}
