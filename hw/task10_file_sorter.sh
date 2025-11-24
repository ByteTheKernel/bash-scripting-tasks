#!/usr/bin/env bash

# Использование:
#   ./task10_file_sorter.sh /path/to/dir
#
# Сортирует файлы:
#   *.jpg *.png *.gif  -> Images/
#   *.txt *.pdf *.docx -> Documents/
# Ведёт лог всех перемещений

if [[ $# -ne 1 ]]; then
    echo "Использование: $0 DIRECTORY"
    exit 1
fi

TARGET_DIR=$1

if [[ ! -d "$TARGET_DIR" ]]; then
    echo "Ошибка: директория '$TARGET_DIR' не существует"
    exit 1
fi

IMAGES_DIR="$TARGET_DIR/Images"
DOCS_DIR="$TARGET_DIR/Documents"
LOG_FILE="$TARGET_DIR/file_sorter.log"

mkdir -p "$IMAGES_DIR" "$DOCS_DIR"

timestamp() {
    date +"%F %T"
}

echo "[$(timestamp)] Запуск сортировки в '$TARGET_DIR'" >> "$LOG_FILE"

shopt -s nullglob nocaseglob

# ---------- Изображения ----------
for file in "$TARGET_DIR"/*.jpg "$TARGET_DIR"/*.png "$TARGET_DIR"/*.gif; do
    [[ -f "$file" ]] || continue
    base=$(basename "$file")
    mv "$file" "$IMAGES_DIR/"
    echo "[$(timestamp)] MOVED '$base' -> Images/" >> "$LOG_FILE"
done

# ---------- Документы ----------
for file in "$TARGET_DIR"/*.txt "$TARGET_DIR"/*.pdf "$TARGET_DIR"/*.docx; do
    [[ -f "$file" ]] || continue
    base=$(basename "$file")
    mv "$file" "$DOCS_DIR/"
    echo "[$(timestamp)] MOVED '$base' -> Documents/" >> "$LOG_FILE"
done

shopt -u nullglob nocaseglob

echo "[$(timestamp)] Сортировка завершена" >> "$LOG_FILE"