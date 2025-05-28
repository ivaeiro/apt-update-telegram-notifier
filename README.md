# apt-update-telegram-notifier

Script en Bash para actualizar paquetes en sistemas basados en `apt` y enviar notificaciones del estado por Telegram.

---

## 🛠️ ¿Qué hace este script?

Este script realiza lo siguiente:

- Actualiza el índice de paquetes (`sudo apt update`)
- Verifica si hay actualizaciones pendientes
- Si existen, aplica las actualizaciones automáticamente (`sudo apt upgrade -y`)
- Envía un mensaje a un chat de Telegram con detalles del host, IP, fecha y estado de la actualización

---

## ⚙️ Configuración

Antes de usar el script, debes configurar dos variables:

- `BOT_TOKEN`: El token de tu bot de Telegram creado con [@BotFather](https://t.me/BotFather).
- `CHAT_ID`: El ID del chat o usuario donde quieres recibir la notificación. Puedes obtenerlo con [@get_id_bot](https://t.me/get_id_bot).

---

## 📋 Uso

1. Clona o descarga este repositorio.
2. Abre el script `update_notify.sh` y reemplaza las variables `BOT_TOKEN` y `CHAT_ID` con tus datos.
3. Da permisos de ejecución al script:

```bash
chmod +x update_notify.sh
