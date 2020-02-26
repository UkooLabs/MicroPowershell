$installPath = (Join-Path $env:ProgramData "micro")

New-Item -ItemType Directory -Force -Path $installPath

$files = @("micro.exe", "settings.json")
foreach ($file in $files) 
{
  curl "https://github.com/UkooLabs/MicroPowershell/blob/master/$file?raw=true" -outfile (Join-Path $installPath $file)
}

$regexInstallPath = [regex]::Escape($installPath)
$pathArray = $env:Path -split ';' | Where-Object {$_ -notMatch "^$regexInstallPath\\?"}
$env:Path = ($pathArray + $installPath) -join ';'
