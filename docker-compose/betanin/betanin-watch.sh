#!/bin/sh

inotifywait -m -e create,moved_to --format '%w%f' "$WATCH_DIR" | while IFS= read -r dir_path; do
    sleep 20s
    response=$(curl --silent --output /dev/null --request POST --data-urlencode "both=$dir_path" --header "Accept: application/json"  --header "X-API-Key: $BETANIN_API_KEY" "$BETANIN_API_URL")
    echo $response
done