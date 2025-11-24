#!/usr/bin/env bash
set -euo pipefail

# Использование:
#   ./task9_system_monitor.sh [THRESHOLD]
#
# THRESHOLD — порог по памяти в %, по умолчанию 80

THRESHOLD=${1:-80}

echo "========== Мониторинг системы =========="

# ---------- CPU ----------
echo
echo "=== Загрузка процессора (load average) ==="
# uptime показывает среднюю загрузку за 1, 5 и 15 минут
uptime

# ---------- Память ----------
echo
echo "=== Использование оперативной памяти ==="
# Берем строку 'Mem:' из free -m: used / total (в MiB)
read -r used total <<< "$(free -m | awk '/^Mem:/ {print $3, $2}')"
mem_percent=$(( used * 100 / total ))

echo "Использовано: ${used} MiB из ${total} MiB (${mem_percent}%)"

# ---------- Диск ----------
echo
echo "=== Использование дискового пространства (/) ==="
df -h / | sed -n '1p;2p'

# ---------- Проверка порога по памяти ----------
echo
if (( mem_percent > THRESHOLD )); then
    echo "!!! ВНИМАНИЕ: использование памяти выше порога ${THRESHOLD}% (${mem_percent}%)"
    echo
    echo "Процессы, потребляющие больше всего памяти:"
    ps -eo pid,comm,%mem,%cpu --sort=-%mem | head -n 1
else
    echo "Использование памяти ниже порога ${THRESHOLD}% (${mem_percent}%)."
fi

echo
echo "========== Мониторинг завершён =========="