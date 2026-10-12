@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: Счетчик для файлов без цифр
set "z_count=1"

:: Перебор всех файлов в текущей папке
for %%F in (*) do (
    :: Пропускаем сам файл скрипта, чтобы не переименовать его
    if "%%~nxF" NEQ "%~nx0" (
        
        :: Получаем имя и расширение
        set "orig_name=%%~nF"
        set "ext=%%~xF"
        
        :: Вызываем процедуру очистки имени (оставляем только цифры)
        call :KeepDigits "!orig_name!" clean_name
        
        :: Если после очистки имя пустое (цифр не было)
        if "!clean_name!"=="" (
            set "clean_name=Z-!z_count!"
            set /a z_count+=1
        )
        
        :: Формируем конечное имя
        set "final_name=!clean_name!!ext!"
        
        :: Проверка на дубликаты (если файл с таким именем уже есть)
        if exist "!final_name!" (
            :: Если файл не является самим собой (на случай повторного запуска)
            if /i "!final_name!" NEQ "%%~nxF" (
                set "final_name=!clean_name!-b!ext!"
            )
        )
        
        :: Финальное переименование, если имя изменилось
        if /i "%%~nxF" NEQ "!final_name!" (
            echo Renaming "%%~nxF" to "!final_name!"
            ren "%%F" "!final_name!"
        )
    )
)

echo Готово!
pause
goto :eof

:: ----------------------------------------------
:: Подпрограмма для удаления всего, кроме цифр
:: ----------------------------------------------
:KeepDigits
set "str=%~1"
set "res="

:loop_char
if "%str%"=="" (
    set "%2=!res!"
    exit /b
)

:: Берем первый символ строки
set "char=%str:~0,1%"
:: Убираем первый символ из строки для следующего цикла
set "str=%str:~1%"

:: Проверяем, является ли символ цифрой (0-9)
for /L %%d in (0,1,9) do (
    if "%%d"=="!char!" set "res=!res!!char!"
)

goto :loop_char