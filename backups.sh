#!/bin/bash

# Carpeta de destino para los respaldos
backup_dir="/ruta/destino/backups"
timestamp=$(date +"%Y%m%d%H%M%S")
backup_file="backup_$timestamp.tar.gz"

# Carpetas a respaldar
folders=("envs" "data" "config")

# Crear carpeta de destino si no existe
mkdir -p "$backup_dir"

# Generar el respaldo
tar -czvf "$backup_dir/$backup_file" "${folders[@]}"

# Verificar si el respaldo fue exitoso
if [ $? -eq 0 ]; then
  echo "Respaldo generado correctamente: $backup_dir/$backup_file"
else
  echo "Error al generar el respaldo."
fi