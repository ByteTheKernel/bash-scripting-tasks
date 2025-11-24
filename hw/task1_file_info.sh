#!/usr/bin/env bash
set -euo pipefail

# Скрипт:
# 1. Создает список всех файлов/каталогов в текущей директории с указанием типа
# 2. Проверяет наличие файла, переданного как аргумент
# 3. С помощью цикла for выводит имя и права доступа для каждого объекта

TARGET_FILE="${1:-}"

echo "=== 1) Список объектов в текущей директории с типом ==="
for item in *; do
    if [ -h "$item" ]; then
        type="symbolic link"
    elif [ -d "$item" ]; then
        type="directory"
    elif [ -f "$item" ]; then
        type="regular file"
    else
        type="other"
    fi
    echo "$item - $type"
done

echo
echo "=== 2) Проверка наличия файла, переданного как аргумент ==="
if [ -z "$TARGET_FILE" ]; then
    echo "Файл не указан (нужно передать имя файла как аргумент)."
else
    if [ -e "$TARGET_FILE" ]; then
        echo "Файл '$TARGET_FILE' существует."
    else
        echo "Файл '$TARGET_FILE' НЕ найден."
    fi
fi

echo
echo "=== 3) Имя и права доступа для каждого объекта ==="
for item in *; do
    perms=$(ls -ld "$item" | awk '{print $1}')
    echo "$item - права: $perms"
done