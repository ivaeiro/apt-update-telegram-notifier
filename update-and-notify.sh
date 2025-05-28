#!/bin/bash

# Variables de Telegram
BOT_TOKEN="TU_TOKEN_AQUI"
CHAT_ID="TU_CHAT_ID_AQUI"

# Actualizar índice de paquetes
sudo apt update

# Verificar si hay actualizaciones pendientes
UPGRADES=$(apt list --upgradable 2>/dev/null | grep -v "Listing..." | wc -l)

# Variables del sistema
HOST=$(hostname)
IP=$(hostname -I | awk '{print $1}')
FECHA=$(date "+%a %d %b %Y - %T")

# Evaluar si hay actualizaciones
if [ "$UPGRADES" -gt 0 ]; then
    sudo apt upgrade -y
    ESTADO="✅ Estado: Sistema actualizado correctamente"
else
    ESTADO="ℹ Estado: No había actualizaciones pendientes"
fi

# Construir el mensaje con formato Markdown
MESSAGE="🖥 Host: $HOST
🌐 IP: $IP
📅 Fecha: $FECHA
$ESTADO"

# Enviar notificación a Telegram
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
    -d chat_id="$CHAT_ID" \
    -d parse_mode="Markdown" \
    -d text="$MESSAGE"
