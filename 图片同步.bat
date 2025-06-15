@echo off
setlocal enabledelayedexpansion

REM 设置源文件夹和目标文件夹路径
set "sourceFolder=.\img"
set "destinationFolder=.\learns\img"

REM 初始化上一次检查的文件计数
set "lastCount=0"

:loop
REM 获取当前源文件夹中的文件计数
set "currentCount=0"
for /r "%sourceFolder%" %%a in (*) do (
    set /a currentCount+=1
)

REM 如果文件计数发生变化，则同步文件夹
if not "!currentCount!"=="!lastCount!" (
    echo 文件发生变化，同步文件夹...
    robocopy "%sourceFolder%" "%destinationFolder%" /mir
    set "lastCount=!currentCount!"
)

REM 等待5秒后重新检查
timeout /t 5 /nobreak >nul

REM 循环
goto loop
