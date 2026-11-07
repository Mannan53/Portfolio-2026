$destDir = "C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets\projects"
if (!(Test-Path $destDir)) { New-Item -ItemType Directory -Force -Path $destDir | Out-Null }

$items = @(
    # Social Media (Vertical & Instagram)
    @{ Name = "social_kotak_v1.jpg"; Id = "1brsYTCLIERrDsJoElIAz1PKGReH3tflJ" },
    @{ Name = "social_kotak_v2.jpg"; Id = "1ioAasrKN6ZiICLqVBlR74YC5eiWDAS_4" },
    @{ Name = "social_kotak_v3.jpg"; Id = "1cSsIog7tRCPZbzrEyRxegOZmgPpFdbj2" },
    @{ Name = "social_kotak_v4.jpg"; Id = "1Z1FewXIaqRZfTnQRHawpGYJrkuXwksgt" },
    @{ Name = "social_ferns_1.jpg"; Id = "1AVV9pFtT005JfiuR685rGmN8J4Fny2dN" },
    @{ Name = "social_ferns_2.jpg"; Id = "1h25dvPREXeDlYOm8y68Reyj0_P05jpCy" },

    # Thumbnails (Horizontal 16:9 YouTube & Finance)
    @{ Name = "thumb_kotak_h1.jpg"; Id = "1g1vqLfiZ3doepKv_wz6QThw520EGRzE0" },
    @{ Name = "thumb_kotak_h2.jpg"; Id = "1-bzaTgqZHUitRFfWrMlSu9tM51VETwA1" },
    @{ Name = "thumb_kotak_h3.jpg"; Id = "1SpCiRVOAwBn6c_BdGd3Lr7rEXoWwDoVV" },
    @{ Name = "thumb_kotak_h4.jpg"; Id = "1q9Zlj1G-v7V_GqSG_3x_QD3X2SnkeNjg" },

    # Posters
    @{ Name = "poster_pmb_1.jpg"; Id = "1CfBgofO6hwooeBIeqrm6CEy_w0hVevQY" },
    @{ Name = "poster_pmb_2.jpg"; Id = "1FtNZxueuYiiu0UA92cuaRKDRvB-jFHo6" },
    @{ Name = "poster_pmb_3.jpg"; Id = "1lT3LChJVLesIQeWvRzxJIolYa78NTgFt" },
    @{ Name = "poster_pmb_4.jpg"; Id = "10K1iC8WecO4x_OIeZ-JxnyyxtoB-_pcx" },
    @{ Name = "poster_jardin_2.jpg"; Id = "1Ez40HXvPBjEUHN2SghlTywz-0ORZ9CDq" },
    @{ Name = "poster_jnr_1.jpg"; Id = "1_0rrU-Vfjna-TZ8riXZl2doJsjLZoNV4" },

    # Logo Design
    @{ Name = "logo_sarvamangala_1.jpg"; Id = "12loOf_dnSJO3VV4Kun5Sz8w8UncGHs8r" },
    @{ Name = "logo_sarvamangala_2.jpg"; Id = "1Ha6hIKllVnbXs2jOcrsFUA34gusP0V_x" },
    @{ Name = "logo_jnp_1.jpg"; Id = "1ILs1W6jwA8Aj0fKvyNHGvDSsCEQ9IwHA" },
    @{ Name = "logo_jnw_0.jpg"; Id = "1RTh6WS_TSbUjoPCBwz_GemmiCoLnjm2G" },
    @{ Name = "logo_enrise_1.jpg"; Id = "102vsWAg6jI4l-LG0x0zlBHJzjpZ74E0_" },
    @{ Name = "logo_jardin_1.jpg"; Id = "1xqTym1AArHLoPB8XmV15_MGtihvHX9-Q" },

    # Print Design
    @{ Name = "print_nusp_1.jpg"; Id = "1pBhSrTUegk6AMal3k-6oFyjUrNPog8ux" },
    @{ Name = "print_nusp_2.jpg"; Id = "1rVlcOUO4I8btS6M-zIET35fZp7V4Rzz9" },
    @{ Name = "print_nusp_3.jpg"; Id = "1gK1xGf_62WBLM86J5YONEBuS9kwOrsNb" },
    @{ Name = "print_jnp_2.jpg"; Id = "1PHvRZsXpjJqo2Aj8W6cPFVfX3Yao2ODi" },
    @{ Name = "print_enrise_2.jpg"; Id = "1Wwk02snqBBcuHodl1Mycf_Pjd580w9OC" },
    @{ Name = "print_orchid.jpg"; Id = "1cfAGEhPTU_ejA-lYxGV6lGRyk2WcgGGZ" }
)

foreach ($item in $items) {
    $outFile = Join-Path $destDir $item.Name
    if (Test-Path $outFile) {
        Write-Host "Already exists: $($item.Name)"
        continue
    }
    $url = "https://lh3.googleusercontent.com/d/$($item.Id)=w1400"
    Write-Host "Downloading $($item.Name)..."
    try {
        Invoke-WebRequest -Uri $url -OutFile $outFile -UseBasicParsing -TimeoutSec 15
        Write-Host "  -> OK: $((Get-Item $outFile).Length) bytes"
    } catch {
        Write-Host "  -> Error: $_"
    }
}
Write-Host "Done downloading category assets!"
