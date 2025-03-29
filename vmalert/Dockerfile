# Базовый образ
FROM victoriametrics/vmalert:v1.94.0

# Копируем entrypoint.sh в контейнер
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Делаем скрипт исполняемым
RUN chmod +x /usr/local/bin/entrypoint.sh

# Устанавливаем entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]