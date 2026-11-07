$fileId = "1g1vqLfiZ3doepKv_wz6QThw520EGRzE0" # Kotak Thumbnail H1
$dest = "C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets\gdrive_assets\test_kotak.jpg"

$urls = @(
    "https://lh3.googleusercontent.com/d/$fileId=w1200",
    "https://drive.google.com/thumbnail?id=$fileId&sz=w1200",
    "https://drive.google.com/uc?export=download&id=$fileId"
)

foreach ($u in $urls) {
    Write-Host "Trying $u..."
    try {
        Invoke-WebRequest -Uri $u -OutFile $dest -UseBasicParsing -TimeoutSec 10
        $fi = Get-Item $dest
        Write-Host "Success! Size: $($fi.Length) bytes"
        break
    } catch {
        Write-Host "Failed: $_"
    }
}
