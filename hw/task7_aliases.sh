#!/usr/bin/env bash
set -euo pipefail

cat << 'EOF'
Создание alias для "ls -la" с именем ll:

    alias ll='ls -la'

Временный alias (только до закрытия текущего shell) можно создать командой:
    alias ll='ls -la'

Чтобы сделать alias постоянным, необходимо добавить эту строку в файл ~/.bashrc:

    echo "alias ll='ls -la'" >> ~/.bashrc

Затем необходимо перезапустить терминал или выполнить:
    source ~/.bashrc

Автодополнение на примере cd:
- Наберём:  cd /et
- Нажмём Tab — bash попытается дополнить до директории /etc
- То же работает для поддиректорий, например:
    cd /etc/apt<Tab>

EOF
