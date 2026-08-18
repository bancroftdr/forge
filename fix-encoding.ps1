<#
    Repair mojibake introduced by PowerShell 5.1 reading a UTF-8 script as Windows-1252.
    Run from the repo root:  .\fix-encoding.ps1

    This file is pure ASCII so PS 5.1 cannot misread it.
    Safe to re-run.
#>

$ErrorActionPreference = "Stop"

if (-not (Test-Path ".git")) {
    Write-Host "ERROR: no .git here. cd to the repo root first." -ForegroundColor Red
    exit 1
}

# Build mojibake sequences from code points so this script stays ASCII.
$A  = [char]0x00E2                        # a-circumflex: first byte of any mangled U+2xxx
$EM = $A + [char]0x20AC + [char]0x201D    # was em dash    U+2014
$EN = $A + [char]0x20AC + [char]0x201C    # was en dash    U+2013
$ST = $A + [char]0x02DC + [char]0x2026    # was black star U+2605

$map = [ordered]@{}
$map[$EM] = " - "
$map[$EN] = "-"
$map[$ST] = "*"

$utf8NoBom = New-Object System.Text.UTF8Encoding $false

$files = Get-ChildItem -Recurse -Include *.md, *.json -File |
         Where-Object { $_.FullName -notmatch '\\build\\|\\\.git\\|\\tracker\\' }

Write-Host ""
$fixed = 0
foreach ($f in $files) {
    $text = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
    $orig = $text

    foreach ($k in $map.Keys) { $text = $text.Replace($k, $map[$k]) }
    $text = $text.Replace($A, "")   # strip any surviving fragment

    [System.IO.File]::WriteAllText($f.FullName, $text, $utf8NoBom)

    if ($text -ne $orig) {
        Write-Host ("  fixed  " + $f.FullName.Substring($PWD.Path.Length + 1)) -ForegroundColor Green
        $fixed++
    }
}

Write-Host ""
Write-Host ("Repaired " + $fixed + " file(s). BOM stripped from " + $files.Count + ".") -ForegroundColor Cyan

Write-Host ""
Write-Host "Remaining non-ASCII (review):" -ForegroundColor Cyan
$found = $false
foreach ($f in $files) {
    $n = 0
    foreach ($line in [System.IO.File]::ReadAllLines($f.FullName, [System.Text.Encoding]::UTF8)) {
        $n++
        if ($line -cmatch '[^\x00-\x7F]') {
            Write-Host ("  " + $f.Name + ":" + $n + "  " + $line.Trim()) -ForegroundColor DarkYellow
            $found = $true
        }
    }
}
if (-not $found) { Write-Host "  none - all clean ASCII." -ForegroundColor Green }

Write-Host ""
Write-Host "Next:" -ForegroundColor Cyan
Write-Host "  git add ."
Write-Host '  git commit -m "Fix text encoding in scaffolded documents"'
Write-Host "  git push"
Write-Host ""
