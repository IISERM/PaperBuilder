if ($args.length -eq 0) {
    Write-Output "Version required"
    Return
}
if ($args[0] -notmatch "^v(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)$") {
    Write-Output "Version type incorrect"
    Return
}

Remove-Item -r -fo build -ErrorAction Ignore
Remove-Item -r -fo release -ErrorAction Ignore
mkdir build >> $null
mkdir release >> $null

nuitka --follow-imports "src\PaperBuilder.py" --remove-output --output-dir="build" --standalone >> $null

Rename-Item .\build\PaperBuilder.dist bin
Copy-Item -Recurse prereq build\
Copy-Item -Recurse .\src\* .\build\
Remove-Item .\build\PaperBuilder.py
Copy-Item .\windows\PaperBuilder.bat .\build
& 'C:\Program Files (x86)\NSIS\Bin\makensis.exe' .\windows\betterPackager.nsi

$linuxtemplate = Get-Content -Path '.\linux\install.sh'
$linuxinstall = $linuxtemplate -replace '{version}', $args[0]
($linuxinstall -join "`n") | Out-File -Encoding utf8 .\release\PaperBuilder-Setup.sh

7z.exe -tzip a .\release\source-files.zip .\src\
7z.exe -ttar a .\release\source-files.tar .\src\
7z.exe -tgzip a .\release\source-files.tar.gz .\release\source-files.tar
