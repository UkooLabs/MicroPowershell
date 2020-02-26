$installPath = (Join-Path $env:ProgramData "micro")

New-Item -ItemType Directory -Force -Path $installPath

$files = @("micro.exe", "settings.json")
foreach ($file in $files) 
{
  $url = "https://github.com/UkooLabs/MicroPowershell/blob/master/$file?raw=true" 
  Write-Output "$url"
  $outFile = (Join-Path $installPath $file)
  curl $url -outfile $outFile
}

$regexInstallPath = [regex]::Escape($installPath)
$pathArray = $env:Path -split ';' | Where-Object {$_ -notMatch "^$regexInstallPath\\?"}
$env:Path = ($pathArray + $installPath) -join ';'
