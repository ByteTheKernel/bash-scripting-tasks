#!/usr/bin/env bash
set -euo pipefail

NEW_DIR="${1:-}"

echo "Текущее значение PATH:"
echo "$PATH"
echo

if [ -z "$NEW_DIR" ]; then
    echo "Не указана директория. Использование:"
    echo " $0 /path/to/dir"
    exit 1
fi

echo "Добавляю директорию '$NEW_DIR' во временный PATH (на время текущего процесса)..."
export PATH="$PATH:$NEW_DIR"
echo "Новое значение PATH:"
echo "$PATH"