# define installer name
Name "PaperBuilder Setup"
OutFile "PaperBuilder-Setup.exe"

RequestExecutionLevel admin
ShowInstDetails Show
Unicode True

# set desktop as install directory
InstallDir $PROGRAMFILES64\PaperBuilder

# default section start
Section
    # define output path
    SetOutPath $INSTDIR
    EnVar::SetHKLM
    EnVar::AddValueEx "Path" $INSTDIR
    Pop $0
    DetailPrint "EnVar::AddValue returned=|$0|"
    # specify file to go in output path
    File /r build\*
    ExecWait '"msiexec" /i "$INSTDIR\prereq\pandoc.msi"'
    RMDir /r /REBOOTOK $INSTDIR\prereq
    # define uninstaller name
    WriteUninstaller $INSTDIR\bin\PaperBuilder-uninstaller.exe
SectionEnd

Section "Uninstall"
    # Always delete uninstaller first
    Delete $INSTDIR\bin\PaperBuilder-uninstaller.exe
    EnVar::SetHKLM
    EnVar::DeleteValue "Path" $INSTDIR
    # Delete the directory
    # This is unsafe, use https://nsis.sourceforge.io/Uninstall_only_installed_files
    RMDir /REBOOTOK /r $INSTDIR
SectionEnd
