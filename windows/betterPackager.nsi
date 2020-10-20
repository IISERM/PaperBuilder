############################################################################################
#      NSIS Installation Script created by NSIS Quick Setup Script Generator v1.09.18
#               Entirely Edited with NullSoft Scriptable Installation System                
#              by Vlasis K. Barkas aka Red Wine red_wine@freemail.gr Sep 2006               
############################################################################################
UNICODE True

!define APP_NAME "PaperBuilder"
!define COMP_NAME "IISER-M Students"
!define WEB_SITE "https://iiserm.github.io/PaperBuilder"
!define VERSION "00.01.00.00"
!define COPYRIGHT ""
!define DESCRIPTION "Create beautiful Latex projects with Markdown"
!define INSTALLER_NAME "..\release\PaperBuilder-Setup.exe"
!define MAIN_APP_EXE "PaperBuilder.bat"
!define INSTALL_TYPE "SetShellVarContext current"
!define REG_ROOT "HKCU"
!define REG_APP_PATH "Software\Microsoft\Windows\CurrentVersion\App Paths\${MAIN_APP_EXE}"
!define UNINSTALL_PATH "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}"

######################################################################

VIProductVersion  "${VERSION}"
VIAddVersionKey "ProductName"  "${APP_NAME}"
VIAddVersionKey "CompanyName"  "${COMP_NAME}"
VIAddVersionKey "LegalCopyright"  "${COPYRIGHT}"
VIAddVersionKey "FileDescription"  "${DESCRIPTION}"
VIAddVersionKey "FileVersion"  "${VERSION}"

######################################################################

SetCompressor ZLIB
Name "${APP_NAME}"
Caption "${APP_NAME}"
OutFile "${INSTALLER_NAME}"
BrandingText "${APP_NAME}"
XPStyle on
InstallDirRegKey "${REG_ROOT}" "${REG_APP_PATH}" ""
InstallDir "$PROGRAMFILES64\PaperBuilder"

######################################################################

!include "FileFunc.nsh"
!insertmacro GetParent

!include LogicLib.nsh

!include "MUI2.nsh"

!define MUI_ABORTWARNING
!define MUI_UNABORTWARNING
!define MUI_FINISHPAGE_NOAUTOCLOSE

!insertmacro MUI_PAGE_WELCOME

!ifdef LICENSE_TXT
!insertmacro MUI_PAGE_LICENSE "${LICENSE_TXT}"
!endif

!insertmacro MUI_PAGE_DIRECTORY

!ifdef REG_START_MENU
!define MUI_STARTMENUPAGE_NODISABLE
!define MUI_STARTMENUPAGE_DEFAULTFOLDER "PaperBuilder"
!define MUI_STARTMENUPAGE_REGISTRY_ROOT "${REG_ROOT}"
!define MUI_STARTMENUPAGE_REGISTRY_KEY "${UNINSTALL_PATH}"
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "${REG_START_MENU}"
!insertmacro MUI_PAGE_STARTMENU Application $SM_Folder
!endif

!insertmacro MUI_PAGE_INSTFILES

Page custom LatexPage

Page custom PandocPage

!define MUI_FINISHPAGE_RUN "$INSTDIR\${MAIN_APP_EXE}"
!define MUI_FINISHPAGE_LINK "See the Source Code/Contribute"
!define MUI_FINISHPAGE_LINK_LOCATION "https://github.com/IISERM/PaperBuilder"
!define MUI_FINISHPAGE_SHOWREADME ${WEB_SITE}
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM

!insertmacro MUI_UNPAGE_INSTFILES

!insertmacro MUI_UNPAGE_FINISH

!insertmacro MUI_LANGUAGE "English"

######################################################################

Function LatexPage
    !insertmacro MUI_HEADER_TEXT "LaTeX Compiler" "Install Latex Compiler Manually"
    
    Var /GLOBAL LDialog
    Var /GLOBAL LLabel

    nsDialogs::Create 1018
    Pop $LDialog

    ${If} $LDialog == error
		Abort
	${EndIf}

    ${NSD_CreateLabel} 0 0 100% 40u "To create a pdf from markdown, a latex document is first created, which is then compiled to pdf using a Latex compiler. Latex compilers are often large, and hence must be installed separately. Any latex compiler should work, but MikTex is preferred. Download and install from the link below. If skipped, only Latex can be generated."
	Pop $LLabel

    Var /GLOBAL Link
    ${NSD_CreateLink} 0 41u 100% -80u https://miktex.org/download
    Pop $Link
    ${NSD_OnClick} $Link onMiktexClick

    nsDialogs::Show
FunctionEnd

Function onMiktexClick
Pop $0
ExecShell "open" "https://miktex.org/download"
FunctionEnd

######################################################################

######################################################################

Function PandocPage
    !insertmacro MUI_HEADER_TEXT "Pandoc" "Install Pandoc"
    
    Var /GLOBAL PDialog
    Var /GLOBAL PLabel

    nsDialogs::Create 1018
    Pop $PDialog

    ${If} $PDialog == error
		Abort
	${EndIf}

    ${NSD_CreateLabel} 0 0 100% 40u "Click on the button below to install Pandoc. This app will not work without Pandoc."
	Pop $PLabel

    Var /GLOBAL Button
    ${NSD_CreateButton} 0 41u 100% -80u Install Pandoc
    Pop $Button
    ${NSD_OnClick} $Button onPandocClick

    nsDialogs::Show
FunctionEnd

Function onPandocClick
Pop $0
ExecWait '"msiexec" /i "$INSTDIR\prereq\pandoc.msi"'
FunctionEnd

######################################################################


Section -MainProgram
${INSTALL_TYPE}
SetOverwrite ifnewer
SetOutPath "$INSTDIR"
File /r "..\build\*"
SectionEnd

######################################################################

Section -Icons_Reg
SetOutPath "$INSTDIR"
WriteUninstaller "$INSTDIR\bin\uninstall.exe"

EnVar::SetHKLM
EnVar::AddValueEx "Path" $INSTDIR
Pop $0
DetailPrint "EnVar::AddValue returned=|$0|"

!ifdef REG_START_MENU
!insertmacro MUI_STARTMENU_WRITE_BEGIN Application
CreateDirectory "$SMPROGRAMS\$SM_Folder"
CreateShortCut "$SMPROGRAMS\$SM_Folder\${APP_NAME}.lnk" "$INSTDIR\${MAIN_APP_EXE}"
CreateShortCut "$SMPROGRAMS\$SM_Folder\Uninstall ${APP_NAME}.lnk" "$INSTDIR\bin\uninstall.exe"

!ifdef WEB_SITE
WriteIniStr "$INSTDIR\${APP_NAME} website.url" "InternetShortcut" "URL" "${WEB_SITE}"
CreateShortCut "$SMPROGRAMS\$SM_Folder\${APP_NAME} Website.lnk" "$INSTDIR\${APP_NAME} website.url"
!endif
!insertmacro MUI_STARTMENU_WRITE_END
!endif

!ifndef REG_START_MENU
CreateDirectory "$SMPROGRAMS\PaperBuilder"
CreateShortCut "$SMPROGRAMS\PaperBuilder\${APP_NAME}.lnk" "$INSTDIR\${MAIN_APP_EXE}"
CreateShortCut "$SMPROGRAMS\PaperBuilder\Uninstall ${APP_NAME}.lnk" "$INSTDIR\bin\uninstall.exe"

!ifdef WEB_SITE
WriteIniStr "$INSTDIR\${APP_NAME} website.url" "InternetShortcut" "URL" "${WEB_SITE}"
CreateShortCut "$SMPROGRAMS\PaperBuilder\${APP_NAME} Website.lnk" "$INSTDIR\${APP_NAME} website.url"
!endif
!endif

WriteRegStr ${REG_ROOT} "${REG_APP_PATH}" "" "$INSTDIR\${MAIN_APP_EXE}"
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "DisplayName" "${APP_NAME}"
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "UninstallString" "$INSTDIR\bin\uninstall.exe"
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "DisplayIcon" "$INSTDIR\${MAIN_APP_EXE}"
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "DisplayVersion" "${VERSION}"
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "Publisher" "${COMP_NAME}"

!ifdef WEB_SITE
WriteRegStr ${REG_ROOT} "${UNINSTALL_PATH}"  "URLInfoAbout" "${WEB_SITE}"
!endif

SectionEnd

######################################################################

Section Uninstall

${GetParent} $INSTDIR $R0
Var /GLOBAL ROOT
StrCpy $ROOT $R0

Delete "$INSTDIR\bin\uninstall.exe"

Delete "$INSTDIR\..\default\*"
RMDir "$INSTDIR\..\default"

ExecWait '"msiexec" /i "$ROOT\prereq\pandoc.msi"'
Delete "$INSTDIR\..\prereq\*"
#RMDir "$INSTDIR\..\prereq"

Delete "$INSTDIR\..\bibliography.bib"
Delete "$INSTDIR\..\PaperBuilder website.url"
Delete "$INSTDIR\..\PaperBuilder.bat"
Delete "$INSTDIR\..\template.md"

RMDir /REBOOTOK /r $INSTDIR
RMDir "$INSTDIR\.."

!ifdef REG_START_MENU
!insertmacro MUI_STARTMENU_GETFOLDER "Application" $SM_Folder
Delete "$SMPROGRAMS\$SM_Folder\${APP_NAME}.lnk"
Delete "$SMPROGRAMS\$SM_Folder\Uninstall ${APP_NAME}.lnk"
!ifdef WEB_SITE
Delete "$SMPROGRAMS\$SM_Folder\${APP_NAME} Website.lnk"
!endif
RMDir "$SMPROGRAMS\$SM_Folder"
!endif

!ifndef REG_START_MENU
Delete "$SMPROGRAMS\PaperBuilder\${APP_NAME}.lnk"
Delete "$SMPROGRAMS\PaperBuilder\Uninstall ${APP_NAME}.lnk"
!ifdef WEB_SITE
Delete "$SMPROGRAMS\PaperBuilder\${APP_NAME} Website.lnk"
!endif
RMDir "$SMPROGRAMS\PaperBuilder"
!endif

DeleteRegKey ${REG_ROOT} "${REG_APP_PATH}"
DeleteRegKey ${REG_ROOT} "${UNINSTALL_PATH}"
SectionEnd

######################################################################
