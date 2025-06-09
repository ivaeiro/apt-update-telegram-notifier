#!/bin/bash

# Variables de Telegram
BOT_TOKEN="TU_TOKEN_AQUI"
CHAT_ID="TU_CHAT_ID_AQUI"

# Actualizar índice de paquetes
sudo apt update

# Obtener lista de paquetes actualizables
UPGRADABLE=$(apt list --upgradable 2>/dev/null | grep -v "Listing...")

# Contar cuántos paquetes hay
UPGRADES=$(echo "$UPGRADABLE" | wc -l)

# Variables del sistema
HOST=$(hostname)
IP=$(hostname -I | awk '{print $1}')
FECHA=$(date "+%a %d %b %Y - %T")

# Evaluar si hay actualizaciones
if [ "$UPGRADES" -gt 0 ]; then
    LISTA_PAQUETES=$(echo "$UPGRADABLE" | awk -F/ '{print "- " $1}' | grep -v "not found" | head -n 30)
    sudo apt upgrade -y
    ESTADO="✅ Estado: Sistema actualizado correctamente"
    PAQUETES="📦 *Paquetes actualizados:*
$LISTA_PAQUETES"
else
    ESTADO="ℹ Estado: No había actualizaciones pendientes"
    PAQUETES=""
fi

# Mensaje final
MESSAGE="🖥 *Host:* $HOST
🌐 *IP:* $IP
📅 *Fecha:* $FECHA
$ESTADO"

# Agrega los paquetes si los hay
if [ -n "$PAQUETES" ]; then
    MESSAGE="$MESSAGE

$PAQUETES"
fi

# Enviar a Telegram
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
    -d chat_id="$CHAT_ID" \
    -d parse_mode="Markdown" \
    --data-urlencode "text=$MESSAGE"
