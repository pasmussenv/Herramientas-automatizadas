# INSTALACIÓN DRUPAL BY 🫆GAIA

Script automático para instalar Drupal desde cero en sistemas Linux (como Ubuntu), pensado para entornos locales, educativos o de pruebas.  
Ha sido diseñado para evitar configuraciones manuales y errores típicos.

---

## ✅ ¿Qué hace este script?

- Comprueba si Composer está instalado. Si no, lo instala automáticamente.
- Comprueba si tienes todas las dependencias PHP necesarias. Si faltan, las instala.
- Instala Drupal usando Composer en la carpeta `drupal/`.
- Aplica los permisos adecuados a los archivos `settings.php`, `services.yml` y a la carpeta `files/`.

> 💡 Es ideal para evitar quebraderos de cabeza cuando empiezas un proyecto Drupal.

---

## 🚀 Cómo se usa

1. Sitúate en la raíz del proyecto donde quieres instalar Drupal.

2. Dale permisos de ejecución al script (solo la primera vez):

```bash
chmod +x install-drupal-by-gaia.sh
```

3. Ejecuta el script:

```bash
./install-drupal-by-gaia.sh
```

El script hará todo por ti:

- Instalará Composer si no lo tienes.
- Comprobará e instalará dependencias PHP necesarias.
- Instalará Drupal en una carpeta `drupal/`.
- Aplicará permisos para que puedas acceder a la interfaz web de instalación.

🔐 Durante el proceso puede pedirse tu contraseña para instalar paquetes mediante `sudo`.

---

## 🔍 Verificar que todo está instalado correctamente

Al finalizar la instalación, puedes comprobar que Composer y PHP se han instalado correctamente ejecutando estos comandos:

```bash
php -v
composer --version
```

Deberías ver una salida parecida a:

```bash
PHP 8.3.6 (cli) (built: Mar 19 2025 ...)
Composer version 2.8.9 2025-05-13 ...
```

Esto te confirma que todo está listo para comenzar a trabajar con Drupal.

---

## 📄 Licencia

Este script ha sido creado por **🫆GAIA** y se publica bajo la licencia **MIT**.

