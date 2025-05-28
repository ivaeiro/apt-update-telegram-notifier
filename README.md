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
2. Abre el script `update-and-notify.sh` y reemplaza las variables `BOT_TOKEN` y `CHAT_ID` con tus datos.
3. Da permisos de ejecución al script:

```bash
chmod +x update-and-notify.sh
```
## ⏰ Automatización con cron

Para que el script se ejecute automáticamente sin que tengas que hacerlo manualmente, puedes programar una tarea con `cron`, que es el programador de tareas de Linux.

### ¿Cómo hacerlo?

1. Abre el editor de tareas de cron para tu usuario con:

```bash
crontab -e
```

2. Añade una línea al final del archivo para que el script se ejecute en el horario que desees. Por ejemplo, para ejecutarlo todos los días a las 7 de la mañana:

```bash
0 7 * * * /ruta/completa/a/update_and-notify.sh
```
