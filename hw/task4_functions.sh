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

echo "=== Вызов функции say_hello ==="
say_hello "Vladislav"

echo
echo "=== Вызов функции sum_two_numbers ==="
a=7
b=5
sum=$(sum_two_numbers "$a" "$b")
echo "Сумма $a и $b равна: $sum"