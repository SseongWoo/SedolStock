@echo off
cd /d %~dp0  || exit /b 1  REM 현재 배치파일이 위치한 디렉토리로 이동

:: EXE 파일이 있는 경로로 이동 (상대경로)
cd ..\build\windows\x64\runner\Release || exit /b 1

:: 파일 존재 여부 확인 후 이름 변경
if exist stockpj.exe (
    rename stockpj.exe SedolStock.exe
    echo 파일명이 SedolStock.exe 로 변경되었습니다.
) else (
    echo ❌ 오류: runner.exe 파일을 찾을 수 없습니다!
    exit /b 1
)

pause