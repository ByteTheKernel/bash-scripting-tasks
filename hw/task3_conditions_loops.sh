#!/usr/bin/env bash
set -euo pipefail

read -rp "Введите целое число: " num

echo "=== Проверка знака числа ==="
if (( num > 0 )); then
    echo "Число положительное"
elif (( num < 0 )); then
    echo "Число отрицательное"
else
    echo "Число равно нулю"
fi

echo
echo "=== Подсчёт от 1 до введённого числа (если оно положительное) ==="
if (( num > 0 )); then
    i=1
    while (( i <= num )); do
        echo "$i"
        (( i++ ))
    done
else
    echo "Число не положительное, цикл while не выполняется."
fi