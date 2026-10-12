#!/usr/bin/env bash
# Guarda tus cambios y los sube a GitHub.
# Uso:  ./subir.sh "lo que cambiaste"
set -e
MSG="${1:-cambios}"
cd "$(dirname "$0")"

for dir in PandaSpigot-API PandaSpigot-Server; do
  if [ -n "$(git -C "$dir" status --porcelain)" ]; then
    echo ">> Guardando cambios en $dir"
    git -C "$dir" add -A
    git -C "$dir" commit -m "$MSG"
  fi
done

echo ">> Regenerando parches"
./panda rb

git add patches subir.sh bajar.sh
if git diff --cached --quiet; then
  echo ">> No hay cambios nuevos para subir."
else
  git commit -m "$MSG"
fi

echo ">> Subiendo a GitHub"
git push origin master
echo ">> Listo, todo guardado en GitHub."
