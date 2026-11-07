$html = [System.IO.File]::ReadAllText("C:\Users\Mannan Ansari\.gemini\antigravity\scratch\robin-portfolio\gdrive_page.html")

# Look for variable names or script tags
$scriptMatches = [regex]::Matches($html, '<script[^>]*>(.*?)</script>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
Write-Host "Total script tags: $($scriptMatches.Count)"

foreach ($m in $scriptMatches) {
    $content = $m.Groups[1].Value
    if ($content -match '1QkP6D62yKTQnX5G5jc31QmAl6TcXkL_X') {
        Write-Host "Found script with folder ID! Length: $($content.Length)"
        # Print snippet around the folder ID
        $idx = $content.IndexOf('1QkP6D62yKTQnX5G5jc31QmAl6TcXkL_X')
        $start = [Math]::Max(0, $idx - 200)
        $len = [Math]::Min(1000, $content.Length - $start)
        Write-Host "Snippet: "
        Write-Host $content.Substring($start, $len)
    }
}
