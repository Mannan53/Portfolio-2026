Add-Type -AssemblyName System.Drawing

function Check-Colors($path) {
    $bmp = [System.Drawing.Bitmap]::FromFile($path)
    Write-Host "Colors in $([System.IO.Path]::GetFileName($path)):"
    $colors = @{}
    for ($y = 0; $y -lt $bmp.Height; $y += 20) {
        for ($x = 0; $x -lt $bmp.Width; $x += 20) {
            $p = $bmp.GetPixel($x, $y)
            if ($p.A -gt 50) {
                $key = "$([int]($p.R/20)*20),$([int]($p.G/20)*20),$([int]($p.B/20)*20)"
                $colors[$key] = ($colors[$key] + 1)
            }
        }
    }
    $colors.GetEnumerator() | Sort-Object Value -Descending | Select-Object -First 5 | ForEach-Object {
        Write-Host "  Color $($_.Key): $($_.Value) pixels"
    }
    $bmp.Dispose()
}

Check-Colors "C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets\marquee_logos\logo_capers.png"
Check-Colors "C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets\marquee_logos\logo_d2r.png"
