#!/bin/sh

# Проверяем и устанавливаем STORAGE_DATA_PATH
if [ -z "$STORAGE_DATA_PATH" ]; then
    echo "Error: STORAGE_DATA_PATH is not set. Exiting."
    exit 1
fi
STORAGE_ARG="--storageDataPath=$STORAGE_DATA_PATH"

# Устанавливаем HTTP_LISTEN_ADDR с возможностью переопределения
HTTP_LISTEN_ADDR=${HTTP_LISTEN_ADDR:-":9428"}
HTTP_ARG="--httpListenAddr=$HTTP_LISTEN_ADDR"


# Логируем стартовые параметры
echo "Starting VictoriaLogs with the following parameters:"
echo "  Storage Data Path: $STORAGE_ARG"
echo "  HTTP Listen Addr: $HTTP_ARG"


# Запускаем VictoriaLogs с переданными параметрами
exec /victoria-logs-prod \
    $STORAGE_ARG \
    $HTTP_ARG \
    "$@"