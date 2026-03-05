#!/bin/bash
# Wrapper para esp-clang do ESP-IDF
# Detecta automaticamente a versão instalada em ~/.espressif
#
# Override padrão: export ESPRESSIF_DIR=/caminho/customizado

ESPRESSIF_DIR="${ESPRESSIF_DIR:-$HOME/.espressif}"
TOOLS_DIR="$ESPRESSIF_DIR/tools"

# Detecta o esp-clang mais recente instalado
ESP_CLANG=$(ls "$TOOLS_DIR/esp-clang"/*/esp-clang/bin/clangd 2>/dev/null | sort -V | tail -1)

if [ -z "$ESP_CLANG" ]; then
    echo "ERROR: esp-clang not found in $TOOLS_DIR/esp-clang" >&2
    echo "Install it with: idf_tools.py install esp-clang" >&2
    exit 1
fi

# Query driver: xtensa (ESP32/S2/S3) + riscv32 (C3/C6/H2/P4)
QUERY_DRIVER="$TOOLS_DIR/xtensa-esp-elf/*/xtensa-esp-elf/bin/xtensa-esp*-elf-*"
QUERY_DRIVER="$QUERY_DRIVER,$TOOLS_DIR/riscv32-esp-elf/*/riscv32-esp-elf/bin/riscv32-esp*-elf-*"

exec "$ESP_CLANG" "--query-driver=$QUERY_DRIVER" "$@"
