#!/usr/bin/env bash
# Trae lo ultimo de GitHub y regenera el codigo para editar.
# Uso:  ./bajar.sh
set -e
cd "$(dirname "$0")"

for dir in PandaSpigot-API PandaSpigot-Server; do
  if [ -d "$dir" ] && [ -n "$(git -C "$dir" status --porcelain)" ]; then
    echo "!! Tienes cambios sin guardar en $dir."
    echo "!! Corre primero ./subir.sh \"descripcion\" para no perderlos."
    exit 1
  fi
done

echo ">> Bajando lo ultimo de GitHub"
git pull origin master

echo ">> Aplicando parches"
./panda patch
echo ">> Listo, ya puedes editar en IntelliJ."
