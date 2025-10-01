#!/bin/sh

# Скрипт для скачивания всех 4 файлов последнего релиза AmneziaWG IPK для текущей архитектуры

ARCH=$(uname -m)  # Используем raw архитектуру, так как пакеты часто используют прямые значения как aarch64_cortex-a53

RELEASE_URL="https://github.com/Slava-Shchipunov/awg-openwrt/releases/latest/download"

# 4 основных пакета AmneziaWG (на основе типичных для OpenWRT: tools, kmod, luci-app, luci-proto)
PACKAGES="amneziawg-tools kmod-amneziawg luci-app-amneziawg luci-proto-amneziawg"

for pkg in $PACKAGES; do
  IPK_FILE="${pkg}_${ARCH}.ipk"  # Формат имени файла; может включать версию и subtarget, проверьте на странице релиза
  wget -O "${IPK_FILE}" "${RELEASE_URL}/${IPK_FILE}" || echo "Ошибка скачивания ${IPK_FILE} - файл может иметь другой формат имени"
done

echo "Скачаны файлы для архитектуры ${ARCH}:"
ls *.ipk

echo "Хотите установить все скачанные пакеты? (y/n)"
read -r answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
  opkg install *.ipk
  echo "Установка завершена."
else
  echo "Установка отменена. Для ручной установки выполните: opkg install *.ipk"
fi
