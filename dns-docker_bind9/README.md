# david-dns — laboratorio BIND9 con Docker Compose

Laboratorio reproducible de servidores DNS (BIND9) montado con Docker Compose. Ideal para prácticas, pruebas de configuración de zonas, replicación maestro/replica y actualizaciones dinámicas.

## Resumen técnico

- Tecnologías: Docker, Docker Compose (v2), Debian, BIND9 (named, rndc), nsupdate
- Validación: `named-checkconf`, `named-checkzone`
- Scripts: `dnsserver/entrypoint.sh`, `snape/probas.sh`

## Quick start

1. Construir:

```bash
docker compose build
```

2. Levantar el entorno:

```bash
docker compose up --build
```

3. Ver logs:

```bash
docker compose logs -f
```

4. Acceder a un contenedor (ej. `harry`):

```bash
docker compose exec harry bash
```

5. Detener y limpiar:

```bash
docker compose down --volumes
```

Si tu entorno necesita un proxy APT durante el build, pasa `--build-arg APT_PROXY=http://host:puerto` al `docker compose build`.

## Estructura del repositorio

- `compose.yml` — definición de servicios, volúmenes y red.
- `dnsserver/` — Dockerfile y `entrypoint.sh` para servidores BIND.
- `cliente/` — Dockerfile para el contenedor cliente (`snape`).
- `harry/`, `hermione/`, `hagrid/`, `dumbledore/` — configuraciones `named.conf.*` y carpetas `zonas/` con archivos de zona.
- `snape/` — scripts de prueba y claves (rndc.key, update.key).
- `logs/consultas.log` — archivo de log montado desde el host (opcional).

## Troubleshooting (rápido)

- Build falla por proxy APT: reconstruye sin proxy o pasa el `APT_PROXY` correcto.
- Zonas no cargadas (`not a file`, `out of range`): comprueba rutas/permiso y valida con `named-checkzone`.
- Secundarias con `SERVFAIL` al refrescar: comprueba que la primaria carga la zona sin errores y que es accesible desde la secundaria.

Comandos útiles:

```bash
docker compose exec harry named-checkconf /etc/bind/named.conf
docker compose exec harry named-checkzone <zona> /var/cache/bind/<fichero-de-zona>
docker compose exec harry rndc reload
docker compose logs -f harry
```

# david-dns — laboratorio BIND9 con Docker Compose

Laboratorio reproducible de servidores DNS (BIND9) en contenedores Docker para prácticas y pruebas.

Quick start (una línea):

```bash
docker compose up --build
```

## Resumen

Este proyecto monta varios contenedores (servidores DNS y un cliente) conectados en una red interna `rededns` con IPs fijas. Está diseñado para probar configuración de zonas, replicación/transferencias y actualizaciones dinámicas (rndc / nsupdate).

## Resumen técnico

Tecnologías y herramientas utilizadas:

- Docker & Docker Compose (v2)
- Debian (imágenes base)
- BIND9 (named, rndc)
- utilidades: `named-checkconf`, `named-checkzone`, `nsupdate`
- Shell scripts para entrada/arranque y pruebas (`entrypoint.sh`, `probas.sh`)

Servicios principales (nombres en `compose.yml`):
- `dumbledore`: servidor DNS (imagen construida desde `dnsserver/`)
- `harry`: servidor DNS maestro/primario (desde `dnsserver/`)
- `hermione`: servidor DNS esclavo/secondary (desde `dnsserver/`)
- `hagrid`: servidor DNS secundario (desde `dnsserver/`)
- `snape`: contenedor cliente / utilidades (desde `cliente/`)

Además hay carpetas con configuraciones y zonas para cada host (`harry/`, `hermione/`, `hagrid/`, `dumbledore/`) y scripts útiles en `dns/` y `snape/`.

## Requisitos

- Docker y Docker Compose (v2) instalados en la máquina host.
- Acceso a Internet desde el host para que apt pueda descargar paquetes durante el build (o configurar un proxy de APT, ver sección Proxy).

## Estructura relevante

- `compose.yml` — definición de servicios y montajes.
- `dnsserver/Dockerfile` — Dockerfile base para los servidores BIND.
- `cliente/Dockerfile` — Dockerfile del contenedor cliente/snape.
- `dnsserver/entrypoint.sh` — script de arranque usado por las imágenes DNS.
- `harry/`, `hermione/`, `hagrid/`, `dumbledore/` — ficheros `named.conf.*` y zona(s).
- `snape/` — scripts para pruebas, claves (rndc.key, update.key), etc.
- `logs/consultas.log` — fichero de log montado desde el host para capturar consultas.

## Inicio rápido

1) Validar la configuración de Compose:

```bash
docker compose -f compose.yml config
```

```bash
docker compose build
```
3) Levantar el entorno:

```bash
docker compose up
```

4) Ver logs en vivo:

```bash
docker compose logs -f
```

5) Ejecutar comandos dentro de un contenedor (por ejemplo `harry`):

```bash
docker compose exec harry bash
# o ejecutar rndc: docker compose exec harry rndc status
```


# david-dns

Un laboratorio pequeño y reproducible de servidores DNS (BIND9) orquestado con Docker Compose. Ideal para prácticas, pruebas de configuración de zonas, replicación/master-slave y actualizaciones dinámicas (rndc / nsupdate).

Este README está redactado para ser publicado en GitHub y usado como tarjeta técnica en un currículum: incluye descripción, arquitectura, pasos para ejecutar y diagnóstico de problemas comunes.

## Características clave

- Topología multi-nodo con IPs estáticas en una red Docker (`rededns`).
- Imágenes Docker para servidores DNS (`dnsserver/`) y un contenedor cliente (`cliente/`).
- Montajes de configuración y archivos de zona para cada host (fáciles de editar desde el host).
- Soporte para build con/ sin proxy APT (build-arg `APT_PROXY`).

## Resultado esperado

Al ejecutar el entorno verás varios contenedores ejecutando BIND9 (por ejemplo `harry`, `hermione`, `hagrid`, `dumbledore`) y un contenedor cliente `snape` que sirve para probar consultas y actualizaciones dinámicas.

## Estructura del repositorio (resumen)

- `compose.yml` — definición de los servicios y red.
- `dnsserver/Dockerfile` — imagen base para servidores BIND.
- `cliente/Dockerfile` — imagen base para el contenedor cliente de pruebas.
- `dnsserver/entrypoint.sh` — script de arranque para BIND en la imagen.
- `harry/`, `hermione/`, `hagrid/`, `dumbledore/` — configuraciones `named.conf.*` y carpetas `zonas/` con archivos de zona.
- `snape/` — scripts de pruebas y claves (rndc.key, update.key).
- `logs/consultas.log` — log montado desde el host para recolectar consultas (opcional).