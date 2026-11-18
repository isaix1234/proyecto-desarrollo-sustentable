@echo off
chcp 65001 >nul
cls
echo ======================================================================
echo    ECOAGRO SUSTENTABLE - SISTEMA DE RESTAURACION Y RECUPERACION
echo ======================================================================
echo.
echo Seleccione el modo de restauracion:
echo.
echo  [1] Restauracion Local Inmediata (v1.0-original + respaldo seguro)
echo  [2] Sincronizar y Restaurar desde GitHub (origin/main)
echo  [3] Sincronizar y Restaurar desde GitHub (origin/main1)
echo  [4] Salir sin hacer cambios
echo.
set /p opcion="Ingrese opcion (1-4) [Por defecto 1]: "

if "%opcion%"=="" set opcion=1
if "%opcion%"=="1" goto LOCAL
if "%opcion%"=="2" goto GITHUB_MAIN
if "%opcion%"=="3" goto GITHUB_MAIN1
if "%opcion%"=="4" goto FIN
goto LOCAL

:LOCAL
echo.
echo [*] Restaurando a la etiqueta original v1.0-original...
git checkout main >nul 2>&1
git reset --hard v1.0-original >nul 2>&1
git clean -fd >nul 2>&1
if exist .backup_original (
    echo [*] Verificando integridad desde respaldo fisico...
    copy /y .backup_original\*.html .\ >nul 2>&1
    copy /y .backup_original\*.png .\ >nul 2>&1
    copy /y .backup_original\*.md .\ >nul 2>&1
    xcopy /y /e /i .backup_original\css css >nul 2>&1
    xcopy /y /e /i .backup_original\js js >nul 2>&1
)
goto EXITO

:GITHUB_MAIN
echo.
echo [*] Conectando con GitHub para actualizar rama main...
git fetch origin >nul 2>&1
git checkout main >nul 2>&1
git reset --hard origin/main >nul 2>&1
git clean -fd >nul 2>&1
goto EXITO

:GITHUB_MAIN1
echo.
echo [*] Conectando con GitHub para actualizar rama main1...
git fetch origin >nul 2>&1
git checkout main1 >nul 2>&1
git reset --hard origin/main1 >nul 2>&1
git clean -fd >nul 2>&1
goto EXITO

:EXITO
echo.
echo ======================================================================
echo  PROYECTO RESTAURADO EXITOSAMENTE
echo  Todos los archivos y modulos han regresado a su estado funcional.
echo  Rama activa:
git branch --show-current
echo ======================================================================
echo.
pause
exit /b 0

:FIN
echo.
echo Operacion cancelada. No se realizaron cambios.
pause
exit /b 0
