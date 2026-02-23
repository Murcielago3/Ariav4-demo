# Read SVG
$svgRaw = [System.IO.File]::ReadAllText('w:\werk\Freelance\Rajvi Bhatt\Ariav5\files2\Stamp_1_Black.svg', [System.Text.Encoding]::UTF8)

# Strip XML declaration
$svgRaw = [regex]::Replace($svgRaw, '^\s*<\?xml[^?]*\?>\s*', '')

# Strip internal <script>...</script> block
$svgRaw = [regex]::Replace($svgRaw, '(?s)\s*<script[^>]*>.*?</script>', '')

# Strip CDATA wrappers  
$svgRaw = $svgRaw.Replace('<![CDATA[', '').Replace(']]>', '')

# Add id and class to opening <svg> tag
$svgRaw = $svgRaw.Replace('id="Layer_2"', 'id="aria-loading-svg" class="aria-loading-stamp"')

$svgRaw = $svgRaw.Trim()

# Read HTML
$html = [System.IO.File]::ReadAllText('w:\werk\Freelance\Rajvi Bhatt\Ariav5\files2\aria-preview-v2.html', [System.Text.Encoding]::UTF8)

# Replace img tag with inline SVG
$imgTag = '    <img class="aria-loading-stamp" src="Stamp_1_Black.svg" alt="' + [char]256 + 'ria" />'
$html = $html.Replace($imgTag, '    ' + $svgRaw)

# Save
[System.IO.File]::WriteAllText('w:\werk\Freelance\Rajvi Bhatt\Ariav5\files2\aria-preview-v2.html', $html, [System.Text.Encoding]::UTF8)
Write-Host "Done. Total HTML length: $($html.Length)"
