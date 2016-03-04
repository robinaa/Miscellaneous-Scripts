@echo off
::CONFIGURATION
SET REPO_URL=http://CA3EYGSWINAPP01.dev.local/svn/iiab
SET REPO_PATH=E:\csvn\data\repositories\iiab
SET DUMP_DIR=\\10.101.2.18\Files\csvn\data\Backup\IIAB\Weekly
SET LAST_DELTA_FILE=C:\BackupScripts_SVN\IIAB\DeltaFile\svn_backup_delta.txt
:END_CONFIGURATION
echo.
echo Starting SVN backup
echo Using following configuration:
echo  -Repository URL: "%REPO_URL%"
echo  -Repository full path: "%REPO_PATH%"
echo  -File to keep track of last revision backed up: %LAST_DELTA_FILE%
SET DUMP_FILE=""
SET Today=%Date: =0%
SET Today=%Today:~-4%%Date:~-7,2%%Date:~-10,2%
SET Now=%Time: =0%
FOR /F "tokens=1,2 delims=:.," %%A IN ("%Now%") DO SET Now=%%A%%B
mkdir "%DUMP_DIR%"
svn info "%REPO_URL%" > %TEMP%.\repoinfo.tmp
SET LAST_REV=
for /f "usebackq tokens=1,2 delims=: " %%i in (`find "Revision: " "%TEMP%\repoinfo.tmp"`) do (
SET LAST_REV=%%j
)
echo Last revision:%LAST_REV%
echo Last delta file: %LAST_DELTA_FILE%
:FULL
SET DUMP_FILE_NAME=%Today%-%Now%-INITIAL-R%LAST_REV%.dump
SET DUMP_FILE=%DUMP_DIR%\%DUMP_FILE_NAME%
echo Dump file name: %DUMP_FILE_NAME%
echo Dump file: %DUMP_FILE% 
svnadmin dump "%REPO_PATH%" -r 0:%LAST_REV% > "%DUMP_FILE%"
7z a -tzip "%DUMP_FILE%".zip "%DUMP_FILE%"
del "%DUMP_FILE%"
echo Date: %Today%-%Now% > "%LAST_DELTA_FILE%"
echo Revision: %LAST_REV% > "%LAST_DELTA_FILE%"
goto END
:END
rem pause
rem exit
:END
