@echo off
If "%1"=="uninstall" ("%~dp0bin\uninstall.exe") else ("%~dp0bin\PaperBuilder.exe" %*)
