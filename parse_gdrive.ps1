$uri = "https://drive.google.com/drive/folders/1QkP6D62yKTQnX5G5jc31QmAl6TcXkL_X?usp=sharing"
$res = Invoke-WebRequest -Uri $uri -UseBasicParsing
$html = $res.Content

# Search for file names or IDs
# In Google Drive folder HTML, items are often in JSON blobs or data attributes or meta tags
$matches = [regex]::Matches($html, 'https://drive\.google\.com/[^"''\s\\]+')
Write-Host "Found matches: $($matches.Count)"
foreach ($m in $matches | Select-Object -First 10) {
    Write-Host $m.Value
}

# Look for drive items or json data
$matches2 = [regex]::Matches($html, '\["([^"]+)",\["([^"]+)"\],"[^"]*","([^"]+)"')
Write-Host "JSON matches: $($matches2.Count)"
foreach ($m in $matches2 | Select-Object -First 10) {
    Write-Host "$($m.Groups[1].Value) -> $($m.Groups[3].Value)"
}

# Save raw HTML to inspect if needed
[System.IO.File]::WriteAllText("C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\gdrive_page.html", $html)
Write-Host "Saved gdrive_page.html, size: $($html.Length)"
