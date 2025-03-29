#!/bin/sh

# Проверяем и устанавливаем STORAGE_DATA_PATH
if [ -z "$STORAGE_DATA_PATH" ]; then
    echo "Error: STORAGE_DATA_PATH is not set. Exiting."
    exit 1
fi
STORAGE_ARG="--storageDataPath=$STORAGE_DATA_PATH"

# Устанавливаем GRAPHITE_LISTEN_ADDR с возможностью переопределения
GRAPHITE_LISTEN_ADDR=${GRAPHITE_LISTEN_ADDR:-":2003"}
GRAPHITE_ARG="--graphiteListenAddr=$GRAPHITE_LISTEN_ADDR"

# Устанавливаем OPENTSDB_LISTEN_ADDR с возможностью переопределения
OPENTSDB_LISTEN_ADDR=${OPENTSDB_LISTEN_ADDR:-":4242"}
OPENTSDB_ARG="--opentsdbListenAddr=$OPENTSDB_LISTEN_ADDR"

# Устанавливаем HTTP_LISTEN_ADDR с возможностью переопределения
HTTP_LISTEN_ADDR=${HTTP_LISTEN_ADDR:-":8428"}
HTTP_ARG="--httpListenAddr=$HTTP_LISTEN_ADDR"

# Устанавливаем INFLUX_LISTEN_ADDR с возможностью переопределения
INFLUX_LISTEN_ADDR=${INFLUX_LISTEN_ADDR:-":8089"}
INFLUX_ARG="--influxListenAddr=$INFLUX_LISTEN_ADDR"

# Устанавливаем VMALERT_PROXY_URL (необязательный параметр)
if [ -n "$VMALERT_PROXY_URL" ]; then
    PROXY_ARG="--vmalert.proxyURL=$VMALERT_PROXY_URL"
else
    PROXY_ARG=""
    echo "Info: VMALERT_PROXY_URL is not set. Skipping proxy configuration."
fi

# Логируем стартовые параметры
echo "Starting VictoriaMetrics with the following parameters:"
echo "  Storage Data Path: $STORAGE_ARG"
echo "  Graphite Listen Addr: $GRAPHITE_ARG"
echo "  OpenTSDB Listen Addr: $OPENTSDB_ARG"
echo "  HTTP Listen Addr: $HTTP_ARG"
echo "  Influx Listen Addr: $INFLUX_ARG"
if [ -n "$PROXY_ARG" ]; then
    echo "  VMAlert Proxy URL: $PROXY_ARG"
fi

# Запускаем VictoriaMetrics с переданными параметрами
exec /victoria-metrics-prod \
    $STORAGE_ARG \
    $GRAPHITE_ARG \
    $OPENTSDB_ARG \
    $HTTP_ARG \
    $INFLUX_ARG \
    $PROXY_ARG \
    "$@"