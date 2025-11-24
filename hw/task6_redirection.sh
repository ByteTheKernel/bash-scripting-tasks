#!/usr/bin/env bash
set -euo pipefail

# Убедимся, что input.txt существует (если нет — создадим простой пример)
if [ ! -f input.txt ]; then
     echo "Файл input.txt не найден, создадим простой пример..."
     printf "строка 1\nстрока 2\nстрока 3\n" > input.txt
fi

echo "=== Подсчёт строк в input.txt и запись результата в output.txt ==="
wc -l < input.txt > output.txt
echo "Результат записан в output.txt:"
cat output.txt

echo
echo "=== Перенаправление ошибок ls для несуществующего файла в error.log ==="
ls some_non_existing_file 2> error.log || true
echo "Ошибки (если были) записаны в error.log:"
cat error.log