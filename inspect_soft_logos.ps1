Add-Type -AssemblyName System.Drawing

$files = @(
    "C:\Users\Mannan Ansari\.gemini\antigravity\brain\25c37498-fc57-4e96-bba8-106b56c4ab06\.user_uploaded\media_1793945525549_898c31f8.png",
    "C:\Users\Mannan Ansari\.gemini\antigravity\brain\25c37498-fc57-4e96-bba8-106b56c4ab06\.user_uploaded\media_1793945550129_3098abe1.png",
    "C:\Users\Mannan Ansari\.gemini\antigravity\brain\25c37498-fc57-4e96-bba8-106b56c4ab06\.user_uploaded\media_1793945560033_6ac9b332.png",
    "C:\Users\Mannan Ansari\.gemini\antigravity\brain\25c37498-fc57-4e96-bba8-106b56c4ab06\.user_uploaded\media_1793945572057_3c03e342.png",
    "C:\Users\Mannan Ansari\.gemini\antigravity\brain\25c37498-fc57-4e96-bba8-106b56c4ab06\.user_uploaded\media_1793945593110_5655218a.png"
)

foreach ($f in $files) {
    if (Test-Path $f) {
        $bmp = [System.Drawing.Bitmap]::FromFile($f)
        Write-Host "$([System.IO.Path]::GetFileName($f)): $($bmp.Width) x $($bmp.Height)"
        $bmp.Dispose()
    }
}
