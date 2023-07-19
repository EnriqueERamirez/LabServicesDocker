#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Uso: $0 <nuevo_usuario> <nueva_contraseña>"
    exit 1
fi

new_user=$1
new_password=$2
env_dir="./envs/"

for file in $(find "$env_dir" -type f); do
    echo "Modificando archivo: $file"
    sed -i -r "s/(DB_USERNAME=)(.+)/\1$new_user/" "$file"
    sed -i -r "s/(DB_PASSWORD=)(.+)/\1$new_password/" "$file"
    sed -i -r "s/(POSTGRES_USER=)(.+)/\1$new_user/" "$file"
    sed -i -r "s/(POSTGRES_PASSWORD=)(.+)/\1$new_password/" "$file"
    sed -i -r "s/(MYSQL_USER=)(.+)/\1$new_user/" "$file"
    sed -i -r "s/(MYSQL_PASSWORD=)(.+)/\1$new_password/" "$file"
done

echo "¡Contraseñas y usuarios modificados con éxito!"
