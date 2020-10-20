Remove-Item -r -fo build -ErrorAction Ignore
mkdir build >> $null
mkdir release -ErrorAction Ignore >> $null

nuitka --follow-imports "src\PaperBuilder.py" --remove-output --output-dir="build" --standalone >> $null

Rename-Item .\build\PaperBuilder.dist bin
Copy-Item -Recurse prereq build\
Copy-Item -Recurse .\src\* .\build\
Remove-Item .\build\PaperBuilder.py
Copy-Item .\windows\PaperBuilder.bat .\build
& 'C:\Program Files (x86)\NSIS\Bin\makensis.exe' .\windows\betterPackager.nsi
