#!/usr/bin/env bash

# Использование:
#   ./task8_backup_manager.sh ИСХОДНАЯ_ПАПКА [ПАПКА_ДЛЯ_БЭКАПА]
#
# Если вторая папка не указана, бэкап создаётся в ИСХОДНАЯ_ПАПКА/backup

if [[ $# -lt 1 || $# -gt 2 ]]; then
    echo "Использование: $0 SOURCE_DIR [BACKUP_DIR]"
    exit 1
fi

SOURCE_DIR=$1
BACKUP_DIR=${2:-"$SOURCE_DIR/backup"}

if [[ ! -d "$SOURCE_DIR" ]]; then
    echo "Ошибка: директория '$SOURCE_DIR' не существует" >&2
    exit 1
fi

# Создаём папку для бэкапа, если её ещё нет
mkdir -p "$BACKUP_DIR"

# Текущая дата
DATE_STR=$(date +"%Y-%m-%d")

# Файл лога — один на запуск
LOG_FILE="$BACKUP_DIR/backup_${DATE_STR}.log"

count=0

echo "[$(date +"%F %T")] Старт резервного копирования из ${SOURCE_DIR} в ${BACKUP_DIR}" | tee -a "$LOG_FILE"

# Чтобы цикл не обрабатывал буквальный *. если файлов нет
shopt -s nullglob

for path in "$SOURCE_DIR"/*; do
    # Пропускаем саму папку бэкапа и подкаталоги
    [[ "$path" == "$BACKUP_DIR" ]] && continue
    [[ -f "$path" ]] || continue

    filename=$(basename "$path")

    # Разделим имя и расширение, чтобы получить file_1970-12-01.txt
    base="$filename"
    ext=""
    if [[ "$filename" == *.* ]]; then
        base="${filename%.*}"
        ext=".${filename##*.}"
    fi

    dest="${BACKUP_DIR}/${base}_${DATE_STR}${ext}"

    if cp -- "$path" "$dest"; then
        ((count++))
        echo "[$(date +"%F %T")] Копирование '$filename' -> '$(basename "$dest")'" >> "$LOG_FILE"
    else
        echo "[$(date +"%F %T")] Ошибка копирования '$filename'" >> "$LOG_FILE"
    fi
done

shopt -u nullglob

echo "[$(date +"%F %T")] Завершено. Всего файлов: $count" | tee -a "$LOG_FILE"

echo
echo "Резервное копирование успешно завершено."
echo "Скопировано файлов: $count"
echo "Лог операций: $LOG_FILE"