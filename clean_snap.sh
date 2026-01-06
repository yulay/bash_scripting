#!/bin/bash
# Removes old revisions of snaps
# CLOSE ALL SNAPS BEFORE RUNNING THIS
set -eu

snap list --all | awk '/disabled/{print $1, $3}' |
    while read snapname revision; do
        snap remove "$snapname" --revision="$revision"
    done

echo "Visualizar la lista de paquetes instalados"
snap list

echo ""
echo "Borrando el contenido del directorio de cache snap"
rm -rf /var/lib/snapd/cache/*

echo ""
echo "Listando el contenido del directorio de cache snap"
ls -las /var/lib/snapd/cache

