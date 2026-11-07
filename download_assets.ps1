$destDir = "C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets\projects"
if (!(Test-Path $destDir)) { New-Item -ItemType Directory -Force -Path $destDir | Out-Null }

$itemsToDownload = @(
    @{ Name = "jahan_numa_palace.jpg"; Id = "1ILs1W6jwA8Aj0fKvyNHGvDSsCEQ9IwHA" },
    @{ Name = "jahan_numa_palace_2.jpg"; Id = "1PHvRZsXpjJqo2Aj8W6cPFVfX3Yao2ODi" },
    @{ Name = "kotak_neo.jpg"; Id = "1g1vqLfiZ3doepKv_wz6QThw520EGRzE0" },
    @{ Name = "kotak_neo_2.jpg"; Id = "1brsYTCLIERrDsJoElIAz1PKGReH3tflJ" },
    @{ Name = "enrise_bhopal.jpg"; Id = "102vsWAg6jI4l-LG0x0zlBHJzjpZ74E0_" },
    @{ Name = "enrise_bhopal_2.jpg"; Id = "1Wwk02snqBBcuHodl1Mycf_Pjd580w9OC" },
    @{ Name = "noor_us_subah.jpg"; Id = "1pBhSrTUegk6AMal3k-6oFyjUrNPog8ux" },
    @{ Name = "noor_us_subah_2.jpg"; Id = "1rVlcOUO4I8btS6M-zIET35fZp7V4Rzz9" },
    @{ Name = "jahan_numa_wilderness.jpg"; Id = "1RTh6WS_TSbUjoPCBwz_GemmiCoLnjm2G" },
    @{ Name = "jardin_hotel.jpg"; Id = "1xqTym1AArHLoPB8XmV15_MGtihvHX9-Q" },
    @{ Name = "sarvamangala.jpg"; Id = "12loOf_dnSJO3VV4Kun5Sz8w8UncGHs8r" },
    @{ Name = "the_ferns.jpg"; Id = "1nLdu8BBG_DDrd_zWY75SJRa1ziU0XgvY" },
    @{ Name = "pushya_mitra.jpg"; Id = "1CfBgofO6hwooeBIeqrm6CEy_w0hVevQY" },
    @{ Name = "orchid.jpg"; Id = "1cfAGEhPTU_ejA-lYxGV6lGRyk2WcgGGZ" }
)

foreach ($item in $itemsToDownload) {
    $outFile = Join-Path $destDir $item.Name
    $url = "https://lh3.googleusercontent.com/d/$($item.Id)=w1400"
    Write-Host "Downloading $($item.Name)..."
    try {
        Invoke-WebRequest -Uri $url -OutFile $outFile -UseBasicParsing -TimeoutSec 15
        $len = (Get-Item $outFile).Length
        Write-Host "  -> Saved: $len bytes"
    } catch {
        Write-Host "  -> Error: $_"
    }
}

Write-Host "Finished downloading assets."
