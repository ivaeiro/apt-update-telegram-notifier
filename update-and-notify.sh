#!/bin/bash

# Variables de Telegram
BOT_TOKEN="TU_TOKEN_AQUI"
CHAT_ID="TU_CHAT_ID_AQUI"

# Variables del sistema
HOST=$(hostname)
IP=$(hostname -I | awk '{print $1}')
FECHA=$(date "+%a %d %b %Y - %T")

# Actualizar índice de paquetes y guardar resultado
APT_UPDATE=$(sudo apt update 2>&1)

# Comprobar si hay actualizaciones pendientes
UPGRADES=$(sudo apt list --upgradable 2>/dev/null | grep -v "Listing..." | wc -l)

# Variable para guardar el resultado final
if [ "$UPGRADES" -gt 0 ]; then

    # Actualizar paquetes
    APT_UPGRADE=$(sudo apt upgrade -y 2>&1)

    ESTADO="✅ <b>Estado:</b> Sistema actualizado correctamente"

else

    APT_UPGRADE="No se realizaron actualizaciones."
    ESTADO="ℹ️ <b>Estado:</b> No había actualizaciones pendientes"

fi

# Construir mensaje
MESSAGE="🖥  <b>Host:</b> $HOST
🌐 <b>IP:</b> $IP
📅 <b>Fecha:</b> $FECHA

$ESTADO

📦 <b>Actualizaciones pendientes:</b> $UPGRADES

<b>APT UPDATE:</b>
<pre>$APT_UPDATE</pre>

<b>APT UPGRADE:</b>
<pre>$APT_UPGRADE</pre>"

# Enviar a Telegram
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
    -d chat_id="$CHAT_ID" \
    -d parse_mode="HTML" \
    --data-urlencode text="$MESSAGE"
