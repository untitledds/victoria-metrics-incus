# Базовый образ
FROM victoriametrics/victoria-logs:v1.17.0-victorialogs

# Копируем entrypoint.sh в контейнер
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Делаем скрипт исполняемым
RUN chmod +x /usr/local/bin/entrypoint.sh

# Устанавливаем entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]