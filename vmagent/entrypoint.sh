#!/bin/sh

# Проверяем, задана ли переменная PROMSCRAPE_CONFIG
if [ -n "$PROMSCRAPE_CONFIG" ]; then
    PROMSCRAPE_ARG="--promscrape.config=$PROMSCRAPE_CONFIG"
else
    echo "Error: PROMSCRAPE_CONFIG is not set. Exiting."
    exit 1
fi

# Проверяем, задана ли переменная REMOTE_WRITE_URL
if [ -n "$REMOTE_WRITE_URL" ]; then
    REMOTE_WRITE_ARG="--remoteWrite.url=$REMOTE_WRITE_URL"
else
    echo "Error: REMOTE_WRITE_URL is not set. Exiting."
    exit 1
fi

# Запускаем vmagent с переданными параметрами
exec /vmagent-prod $PROMSCRAPE_ARG $REMOTE_WRITE_ARG "$@"