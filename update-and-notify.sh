#!/bin/bash

# Variables de Telegram
BOT_TOKEN="TU_TOKEN_AQUI"
CHAT_ID="TU_CHAT_ID_AQUI"

# Actualizar índice de paquetes
sudo apt update

# Verificar si hay actualizaciones pendientes
UPGRADABLE=$(apt list --upgradable 2>/dev/null | grep -v "Listing...")

# Contar cuántos paquetes se pueden actualizar
UPGRADES=$(echo "$UPGRADABLE" | wc -l)

# Variables del sistema
HOST=$(hostname)
IP=$(hostname -I | awk '{print $1}')
FECHA=$(date "+%a %d %b %Y - %T")

# Inicializar variable de paquetes
LISTA_PAQUETES=""

# Evaluar si hay actualizaciones
if [ "$UPGRADES" -gt 0 ]; then
    LISTA_PAQUETES=$(echo "$UPGRADABLE" | awk -F/ '{print "- " $1}' | head -n 30)
    sudo apt upgrade -y
    ESTADO="✅ Estado: Sistema actualizado correctamente"
else
    ESTADO="ℹ Estado: No había actualizaciones pendientes"
fi

# Construir el mensaje con formato Markdown
MESSAGE="🖥 *Host:* $HOST
🌐 *IP:* $IP
📅 *Fecha:* $FECHA
$ESTADO"

# Agregar lista de paquetes si hay
if [ "$UPGRADES" -gt 0 ]; then
    MESSAGE+="

📦 *Paquetes actualizados:*
$LISTA_PAQUETES"
fi

# Enviar notificación a Telegram
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
    -d chat_id="$CHAT_ID" \
    -d parse_mode="Markdown" \
    --data-urlencode "text=$MESSAGE"
