$icons = @('icon_photoshop.png', 'icon_illustrator.png', 'icon_premiere.png', 'icon_lightroom.png', 'icon_canva.png', 'icon_capcut.png', 'icon_figma.png', 'icon_aitools.png')
foreach ($ic in $icons) {
    $code = (Invoke-WebRequest -Uri ("http://localhost:5500/assets/software_icons/" + $ic) -UseBasicParsing).StatusCode
    Write-Host "$ic -> $code"
}
