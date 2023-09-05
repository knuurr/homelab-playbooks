export TITLE="My Title"
export MESSAGE="My message"
export PRIORITY=5
export URL="http://gotify:80/message?token=token"

curl -s -S --data '{"message": "'"${MESSAGE}"'", "title": "'"${TITLE}"'", "priority":'"${PRIORITY}"', "extras": {"client::display": {"contentType": "text/markdown"}}}' -H 'Content-Type: application/json' "$URL"