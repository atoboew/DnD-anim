@echo off
chcp 65001 >nul

echo 1. Добавляем все файлы в список...
git add .

echo.
echo 2. Создаем коммит с датой и временем...
git commit -m "Auto-update: %date% %time%"

echo.
echo 3. Отправляем на GitHub...
git push

echo.
echo === Все готово! ===
pause