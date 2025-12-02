@echo off
setlocal enabledelayedexpansion

for %%F in (file_name_*) do (
    set "filename=%%F"
    set "newname=!filename:{file_name}=!"
    ren "%%F" "!newname!"
)

echo Done!
pause 
