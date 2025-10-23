#!/bin/sh

# Arrêt en cas d'erreur et variables non définies
set -eu

# Fichier source en argument (optionnel)
FILE=${1:-}

# Si aucun argument n'est donné, utiliser un fichier par défaut
[ -z "$FILE" ] && FILE=icon.png

# Si le fichier à traiter n'est pas trouvé -> exit
[ ! -f "$FILE" ] && echo "${FILE} does not exist." >&2 && exit 1

# Détection de la commande ImageMagick disponible
if command -v magick >/dev/null 2>&1; then
  IM_CMD="magick convert"
elif command -v convert >/dev/null 2>&1; then
  IM_CMD="convert"
else
  echo "ImageMagick introuvable. Veuillez installer 'magick' (IM7) ou 'convert' (IM6)." >&2
  exit 1
fi

# Conversion en favicon multi-tailles
$IM_CMD -background none "$FILE" -define icon:auto-resize=256,64,48,32,16 favicon.ico

echo "Favicon généré: favicon.ico"
