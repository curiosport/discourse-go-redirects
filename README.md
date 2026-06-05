# discourse-go-redirects

Plugin para Discourse que gestiona redirecciones públicas en `/go/<slug>`.

## Instalación

Copia la carpeta `discourse-go-redirects/` en `/var/discourse/plugins/` y reconstruye:

```bash
cd /var/discourse
./launcher rebuild app
```

## Uso

Ve a **Admin → Plugins → Go Redirects**, añade un slug y una URL destino, pulsa **+**.

La redirección queda disponible de inmediato en `https://tu-foro.com/go/<slug>`.
