#!/usr/bin/env bash
set -euo pipefail

say_hello() {
    local name="$1"
    echo "Hello, $name"
}

sum_two_numbers() {
    local a="$1"
    local b="$2"
    local result=$(( a + b ))
    echo "$result"
}

# 1-й аргумент скрипта — имя, по умолчанию Vladislav
name="${1:-Vladislav}"

# 2-й и 3-й аргументы — числа для суммы, по умолчанию 7 и 5
a="${2:-7}"
b="${3:-5}"

echo "=== Вызов функции say_hello ==="
say_hello "$name"

echo
echo "=== Вызов функции sum_two_numbers ==="
sum=$(sum_two_numbers "$a" "$b")
echo "Сумма $a и $b равна: $sum"