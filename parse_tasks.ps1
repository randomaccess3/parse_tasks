
param (
    [string]$inputFolder,
    [string]$outputFile
)

function Convert-XmlToDictionary {
    param ($node)

    $result = @{}

    # Add attributes
    if ($node.Attributes) {
        foreach ($attr in $node.Attributes) {
            $result[$attr.Name] = $attr.Value
        }
    }

    # Add child elements
    foreach ($child in $node.ChildNodes) {
        if ($child.NodeType -eq 'Element') {
            $childName = $child.Name
            $childValue = Convert-XmlToDictionary -node $child

            if ($result.ContainsKey($childName)) {
                if ($result[$childName] -isnot [System.Collections.ArrayList]) {
                    $result[$childName] = @($result[$childName])
                }
                $result[$childName] += $childValue
            } else {
                $result[$childName] = $childValue
            }
        } elseif ($child.NodeType -eq 'Text' -and $child.Value.Trim()) {
            $result = $child.Value.Trim()
        }
    }

    return $result
}

$results = @()
Write-host ("Input: " + $inputFolder)
Get-ChildItem -Path $inputFolder -Recurse -File | ForEach-Object {
    $filePath = $_.FullName
    Write-host ($filePath)
    $rawContent = Get-Content -Path $filePath -Raw -ErrorAction SilentlyContinue
    if ($rawContent) {
        try {
            $xml = [xml]$rawContent
            $jsonObject = Convert-XmlToDictionary -node $xml.DocumentElement
			$results += [PSCustomObject]@{
			Path = $filePath
			Created = (Get-Item $filePath).CreationTimeUtc.ToString("o")
			Modified = (Get-Item $filePath).LastWriteTimeUtc.ToString("o")
			Task = $jsonObject
			}
        } catch {
            Write-Warning "Failed to parse XML from $filePath"
        }
    }
}

$results | ConvertTo-Json -Depth 20 -Compress  | Set-Content -Path $outputFile -Encoding UTF8
