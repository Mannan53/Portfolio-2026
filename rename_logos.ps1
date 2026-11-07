Add-Type -AssemblyName System.Drawing

$dir = "C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\assets\marquee_logos"

$mappings = @{
    "kotak-neo-hlogo-blackbg_1__1___2_.png" = "logo_kotak.png"
    "sheraton_logo_white_.png"              = "logo_sheraton.png"
    "the_fern_budhni_white.png"             = "logo_thefern.png"
    "jardin_logo_white.png"                  = "logo_jardin.png"
    "enrise_all_unit_logo__enrise_bhopal_w.png" = "logo_enrise.png"
    "crescent_logo_white_.png"               = "logo_crescent.png"
    "egniter_white.png"                      = "logo_egniter.png"
    "sayaji_indore_4x.png"                   = "logo_sayaji.png"
    "capers_logo_.png"                       = "logo_capers.png"
    "jnrt_footer.png"                        = "logo_jnrt.png"
    "d2r-logo-long.png"                      = "logo_d2r.png"
    "kalyan_sampat_heights_logo.png"         = "logo_kalyan.png"
    "kalaghoda.png"                          = "logo_kalaghoda.png"
    "kebabsvilla.png"                        = "logo_kebabsvilla.png"
    "malt.png"                               = "logo_malt.png"
    "portico_logo.png"                       = "logo_portico.png"
}

foreach ($orig in $mappings.Keys) {
    $src = Join-Path $dir $orig
    $new = Join-Path $dir $mappings[$orig]
    if (Test-Path $src) {
        Move-Item -Path $src -Destination $new -Force
        $bmp = [System.Drawing.Bitmap]::FromFile($new)
        Write-Host "Renamed to: $($mappings[$orig]) ($($bmp.Width) x $($bmp.Height))"
        $bmp.Dispose()
    }
}
