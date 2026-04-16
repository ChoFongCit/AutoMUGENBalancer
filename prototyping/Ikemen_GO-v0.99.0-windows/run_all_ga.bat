@echo off
setlocal enabledelayedexpansion

set CHARS_DIR=%~dp0chars
set FAILED=

for /d %%C in ("%CHARS_DIR%\*") do (
    if exist "%%C\run_ga.py" (
        echo =========================================
        echo Running GA for: %%~nxC
        echo =========================================

        pushd "%%C"
        python run_ga.py
        if errorlevel 1 (
            echo [FAILED] %%~nxC exited with an error.
            set FAILED=!FAILED! %%~nxC
        ) else (
            echo [OK] %%~nxC finished successfully.
        )
        popd

        echo.
    )
)

echo =========================================
echo All characters processed.
if defined FAILED (
    echo Failed characters: %FAILED%
    exit /b 1
) else (
    echo All runs completed successfully.
)
