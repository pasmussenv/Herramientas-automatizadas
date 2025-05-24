#!/bin/bash

# =============================================================================
# Instalación completa de Drupal con comprobación de dependencias
# =============================================================================

echo -e "\033[1;36m###############################################\033[0m"
echo -e "\033[1;36m##  Instalación automática de Drupal         ##\033[0m"
echo -e "\033[1;36m###############################################\033[0m"

# Confirmación de inicio con aviso de sudo
read -p "Este proceso necesita permisos sudo. ¿Deseas continuar? [s/N]: " continuar
if [[ ! $continuar =~ ^[sS]$ ]]; then
    echo "Instalación cancelada."
    exit 0
fi

# Función para comprobar e instalar extensiones PHP
instalar_php_dependencia() {
    if ! dpkg -l | grep -q "$1"; then
        echo -e "\033[1;33m➤ Instalando $1...\033[0m"
        sudo apt install -y "$1"
    else
        echo -e "\033[1;32m✔ $1 ya está instalado.\033[0m"
    fi
}

# -----------------------------------------------------------------------------
# 1. Verificar si PHP está instalado
# -----------------------------------------------------------------------------
if ! command -v php &> /dev/null; then
    echo -e "\033[1;33m➤ PHP no está instalado. Instalando php-cli...\033[0m"
    sudo apt update
    sudo apt install -y php-cli
else
    echo -e "\033[1;32m✔ PHP ya está instalado.\033[0m"
fi

# -----------------------------------------------------------------------------
# 2. Verificar si Composer está instalado
# -----------------------------------------------------------------------------
if ! command -v composer &> /dev/null; then
    echo -e "\033[1;33m➤ Composer no está instalado. Instalando...\033[0m"
    EXPECTED_SIGNATURE="$(curl -s https://composer.github.io/installer.sig)"
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    ACTUAL_SIGNATURE="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

    if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]; then
        echo -e "\033[0;31mERROR: La firma del instalador de Composer no coincide. Abortando.\033[0m"
        rm composer-setup.php
        exit 1
    fi

    php composer-setup.php --quiet
    sudo mv composer.phar /usr/local/bin/composer
    rm composer-setup.php
else
    echo -e "\033[1;32m✔ Composer ya está instalado.\033[0m"
fi

# -----------------------------------------------------------------------------
# 3. Comprobar e instalar dependencias PHP necesarias
# -----------------------------------------------------------------------------
echo -e "\033[1;34m➤ Comprobando e instalando dependencias PHP necesarias para Drupal...\033[0m"
sudo apt update
dependencias=("php-cli" "php-xml" "php-gd" "php-mbstring" "php-zip" "php-curl" "php-mysql" "unzip")

for paquete in "${dependencias[@]}"; do
    instalar_php_dependencia "$paquete"
done

# Crear carpeta drupal si no existe y entrar en ella
mkdir -p drupal
cd drupal

# Instalar Drupal directamente
echo -e "\033[1;34m➤ Instalando Drupal con Composer...\033[0m"
composer create-project drupal/recommended-project .

# Configurar permisos y archivos
cd web/sites/default

cp default.settings.php settings.php 2>/dev/null && echo -e "\033[1;32m✔ settings.php copiado.\033[0m"
cp default.services.yml services.yml 2>/dev/null && echo -e "\033[1;32m✔ services.yml copiado.\033[0m"
mkdir -p files
chmod -R 755 files
echo -e "\033[1;32m✔ Permisos aplicados correctamente.\033[0m"

echo -e "\033[1;32m✔ Drupal ha sido instalado y preparado correctamente.\033[0m"

# -----------------------------------------------------------------------------
# Copyright (c) 2025 🐾GAIA
#
# Este script está publicado bajo la licencia MIT.
# Puedes usarlo, modificarlo y compartirlo libremente, siempre que mantengas
# esta nota de autoría y la licencia correspondiente.
# -----------------------------------------------------------------------------
