#!/bin/sh

# Проверяем и устанавливаем DATASOURCE_URL
if [ -z "$DATASOURCE_URL" ]; then
    echo "Error: DATASOURCE_URL is not set. Exiting."
    exit 1
fi
DATASOURCE_ARG="--datasource.url=$DATASOURCE_URL"

# Проверяем и устанавливаем REMOTE_READ_URL
if [ -z "$REMOTE_READ_URL" ]; then
    echo "Error: REMOTE_READ_URL is not set. Exiting."
    exit 1
fi
REMOTE_READ_ARG="--remoteRead.url=$REMOTE_READ_URL"

# Проверяем и устанавливаем REMOTE_WRITE_URL
if [ -z "$REMOTE_WRITE_URL" ]; then
    echo "Error: REMOTE_WRITE_URL is not set. Exiting."
    exit 1
fi
REMOTE_WRITE_ARG="--remoteWrite.url=$REMOTE_WRITE_URL"

# Проверяем и устанавливаем NOTIFIER_URL
if [ -z "$NOTIFIER_URL" ]; then
    echo "Error: NOTIFIER_URL is not set. Exiting."
    exit 1
fi
NOTIFIER_ARG="--notifier.url=$NOTIFIER_URL"

# Устанавливаем EXTERNAL_URL с возможностью переопределения
EXTERNAL_URL=${EXTERNAL_URL:-"http://127.0.0.1:3000"}
EXTERNAL_URL_ARG="--external.url=$EXTERNAL_URL"

# Устанавливаем EXTERNAL_ALERT_SOURCE с возможностью переопределения
EXTERNAL_ALERT_SOURCE=${EXTERNAL_ALERT_SOURCE:-'explore?orgId=1&left={"datasource":"VictoriaMetrics","queries":[{"expr":{{.Expr|jsonEscape|queryEscape}},"refId":"A"}],"range":{"from":"{{ .ActiveAt.UnixMilli }}","to":"now"}}'}
EXTERNAL_ALERT_SOURCE_ARG="--external.alert.source=$EXTERNAL_ALERT_SOURCE"

# Логируем стартовые параметры
echo "Starting vmalert with the following parameters:"
echo "  Datasource URL: $DATASOURCE_ARG"
echo "  Remote Read URL: $REMOTE_READ_ARG"
echo "  Remote Write URL: $REMOTE_WRITE_ARG"
echo "  Notifier URL: $NOTIFIER_ARG"
echo "  External URL: $EXTERNAL_URL_ARG"
echo "  External Alert Source: $EXTERNAL_ALERT_SOURCE_ARG"

# Запускаем vmalert с переданными параметрами
exec /vmalert-prod \
    $DATASOURCE_ARG \
    $REMOTE_READ_ARG \
    $REMOTE_WRITE_ARG \
    $NOTIFIER_ARG \
    --rule=/etc/alerts/*.yml \
    $EXTERNAL_URL_ARG \
    $EXTERNAL_ALERT_SOURCE_ARG \
    "$@"