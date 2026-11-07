$html = [System.IO.File]::ReadAllText("C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\gdrive_page.html")

# Look for image extensions
$extMatches = [regex]::Matches($html, '["'']([^"'']+\.(?:png|jpg|jpeg|svg|webp|gif|pdf|ai|psd))["'']', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
Write-Host "Extension matches: $($extMatches.Count)"
$uniqueFiles = @()
foreach ($m in $extMatches) {
    $val = $m.Groups[1].Value
    if ($uniqueFiles -notcontains $val) {
        $uniqueFiles += $val
        Write-Host "Found file: $val"
    }
}

# Look for Drive item IDs (28-44 chars alphanumeric with _ -)
# Usually formatted in _DRIVE_DATA or items array
$idMatches = [regex]::Matches($html, '\["([a-zA-Z0-9_-]{25,45})",\["([^"]+)"\]')
Write-Host "Drive item patterns: $($idMatches.Count)"
foreach ($m in $idMatches | Select-Object -First 20) {
    Write-Host "$($m.Groups[1].Value) -- $($m.Groups[2].Value)"
}
