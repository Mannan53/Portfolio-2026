$html = [System.IO.File]::ReadAllText("C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\gdrive_page.html")

# Find window['_DRIVE_ivd'] = '...'
if ($html -match "window\['_DRIVE_ivd'\]\s*=\s*'([^']+)'") {
    $raw = $matches[1]
    # Decode \x.. and \u.. hex escapes
    $decoded = [regex]::Replace($raw, '\\x([0-9a-fA-F]{2})', { param($m) [char][Convert]::ToInt32($m.Groups[1].Value, 16) })
    $decoded = [regex]::Replace($decoded, '\\u([0-9a-fA-F]{4})', { param($m) [char][Convert]::ToInt32($m.Groups[1].Value, 16) })
    
    [System.IO.File]::WriteAllText("C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\gdrive_ivd.json", $decoded)
    Write-Host "Decoded IVD JSON saved. Length: $($decoded.Length)"
    
    # Parse JSON
    try {
        $json = $decoded | ConvertFrom-Json
        Write-Host "Parsed JSON successfully!"
        
        # In Google Drive IVD, it's an array of item rows
        # Let's inspect the items
        function Inspect-Items($arr) {
            foreach ($item in $arr) {
                if ($item -is [Array]) {
                    # Check if first element is an ID string
                    if ($item.Count -gt 2 -and ($item[0] -is [string]) -and ($item[0].Length -gt 20)) {
                        $id = $item[0]
                        $name = $item[2]
                        $mime = $item[3]
                        Write-Host "ITEM: ID=$id | Name=$name | Mime=$mime"
                    } else {
                        Inspect-Items $item
                    }
                }
            }
        }
        Inspect-Items $json
    } catch {
        Write-Host "JSON Parse error: $_"
        # Regex search for ["ID",["parent"],"Name","mime"]
        $itemMatches = [regex]::Matches($decoded, '\["([a-zA-Z0-9_-]{20,50})",\["[^"]*"\],"([^"]+)","([^"]+)"')
        Write-Host "Regex matches found: $($itemMatches.Count)"
        foreach ($im in $itemMatches) {
            Write-Host "ITEM: ID=$($im.Groups[1].Value) | Name=$($im.Groups[2].Value) | Mime=$($im.Groups[3].Value)"
        }
    }
} else {
    Write-Host "window['_DRIVE_ivd'] not found"
}
