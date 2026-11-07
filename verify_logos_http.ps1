$files = @('logo_sahil.png', 'logo_sarvmangala.png', 'logo_ss_infinitus.png', 'logo_orchid.png', 'logo_capers.png', 'logo_d2r.png')
foreach ($f in $files) {
    $code = (Invoke-WebRequest -Uri ("http://localhost:5500/assets/marquee_logos/" + $f) -UseBasicParsing).StatusCode
    Write-Host "$f -> $code"
}
