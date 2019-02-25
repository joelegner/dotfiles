REM Remove files
forfiles /p "C:\Users\Joe\Documents\Temp" /s /m *.* /c "cmd /c Del @path"
REM Remove folders
FOR /D %%p IN ("C:\Users\Joe\Documents\Temp\*.*") DO rmdir "%%p" /s /q
REM Create reminder file
echo .>"C:\Users\Joe\Documents\Temp\__files_deleted_daily_at_midnight"
