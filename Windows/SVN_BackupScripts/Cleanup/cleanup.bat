@echo off 
:: set folder path 
pushd \\10.101.2.18\Files\csvn\data\Backup\
set dump_path1=IIAB\Daily
set dump_path2=IIAB\Weekly
set dump_path3=RRM\Daily
set dump_path4=RRM\Weekly

:: set min age of files and folders to delete 
set max_days=21

:: remove files from %dump_path% 
forfiles -p %dump_path1% -m *.* -d -%max_days% -c "cmd /c del /q @path"
forfiles -p %dump_path2% -m *.* -d -%max_days% -c "cmd /c del /q @path"
forfiles -p %dump_path3% -m *.* -d -%max_days% -c "cmd /c del /q @path" 
forfiles -p %dump_path4% -m *.* -d -%max_days% -c "cmd /c del /q @path" 
popd