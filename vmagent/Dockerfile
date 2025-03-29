# Базовый образ
FROM victoriametrics/vmagent:v1.114.0

# Копируем entrypoint.sh в контейнер
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Делаем скрипт исполняемым
RUN chmod +x /usr/local/bin/entrypoint.sh

# Устанавливаем entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]