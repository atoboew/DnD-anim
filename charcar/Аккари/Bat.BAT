@echo off
chcp 65001 >nul
echo Запуск переименования файлов...

powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-ChildItem -Filter *.jpg | ForEach-Object { if ($_.BaseName -match '(?<!\d)\d{3}(?!\d)') { $num = $matches[0]; $newName = \"ii-$num.jpg\"; $newPath = Join-Path $_.DirectoryName $newName; if ($_.FullName -eq $newPath) { return }; if (Test-Path $newPath) { $newName = \"ii-$num-b.jpg\" }; Rename-Item -Path $_.FullName -NewName $newName -ErrorAction SilentlyContinue } }"

echo Готово!
pause