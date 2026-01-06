#!/bin/bash

logfile="log_$(date +'%Y-%m-%d_%H-%M-%S').log"
num_llamadas=100  # Número total de llamadas a realizar
concurrencia=5    # Número de llamadas concurrentes

echo "Iniciando pruebas de carga - $(date '+%Y-%m-%d %H:%M:%S')" > "$logfile"
echo "Llamadas totales: $num_llamadas, Concurrencia: $concurrencia" >> "$logfile"
echo "==========================================" >> "$logfile"



seq 1 $num_llamadas | xargs -P $concurrencia -I {} sh -c '
  response=$(curl -s --location "https://api.thecatapi.com/v1/images/search?size=med&mime_types=jpg&format=json&has_breeds=true&order=RANDOM&page=0&limit=20" \
    --header "accept: text/plain" \
    --header "Content-Type: application/json")
  
  echo "[$(date +"%Y-%m-%d %H:%M:%S")] Response for request {}:"
  echo "$response"
  echo "----------------------------------------"
' | tee -a "$logfile"

echo "==========================================" >> "$logfile"
echo "Pruebas completadas - $(date '+%Y-%m-%d %H:%M:%S')" >> "$logfile"
echo "Resultados guardados en: $logfile"

echo ""
read -p "Pulse enter"
echo ""
cat "$logfile" | grep '"complete":false' | cut -f9,13 -d ','
