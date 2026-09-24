#!/usr/bin/env bash
# Переключатель записи экрана с обратным отсчётом

RECORD_DIR="$HOME/Videos/recordings"
mkdir -p "$RECORD_DIR"

# Если wf-recorder уже запущен — останавливаем
if pgrep -x "wf-recorder" > /dev/null; then
    kill -SIGINT $(pgrep -x "wf-recorder")
    notify-send "Запись" "Сохранено в $RECORD_DIR"
    exit 0
fi

# Иначе — выделяем область и запускаем с отсчётом
GEOMETRY=$(slurp)
if [ -z "$GEOMETRY" ]; then
    exit 1
fi

# Обратный отсчёт
for i in 3 2 1; do
    notify-send -t 800 "Запись через $i..."
    sleep 1
done

FILENAME="$RECORD_DIR/recording_$(date +%Y%m%d_%H%M%S).mp4"
notify-send "Запись" "Началась: $FILENAME"

# Запускаем в фоне, чтобы скрипт завершился
wf-recorder -g "$GEOMETRY" -f "$FILENAME" --audio &