rem Disable non-essential ASUS services
sc stop ASUSLinkNear
sc stop ASUSLinkNearExt
sc stop ASUSLinkRemote
sc stop ASUSSoftwareManager
sc stop ASUSSystemAnalysis
sc stop ASUSSystemDiagnosis

rem Delete ASUS services (yet again)
sc delete ASUSLinkNear
sc delete ASUSLinkNearExt
sc delete ASUSLinkRemote
sc delete ASUSSoftwareManager
sc delete ASUSSystemAnalysis
sc delete ASUSSystemDiagnosis

rem Disable AMD Crash Defender
sc stop "AMD Crash Defender Service"
sc config "AMD Crash Defender Service" start=disabled

rem Kill GoogleCrashHandler*.exe process
taskkill /IM "GoogleCrashHandler.exe" /F
taskkill /IM "GoogleCrashHandler64.exe" /F

rem Delete GoogleCrashHandler*.exe
cd "C:\Program Files (x86)\Google\Update"
del /s GoogleCrashHandler*.exe

pause
