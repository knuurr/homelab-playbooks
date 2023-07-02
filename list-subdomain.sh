find ./docker-compose -type f -name '*.env' -exec grep -H "SUBDOMAIN=" {} +
# Example output:
# ./docker-compose/docker-compose-authelia/.env:SUBDOMAIN='auth'
# ./docker-compose/docker-compose-calibreweb/.env:SUBDOMAIN='calibre'
# ./docker-compose/docker-compose-grafana/.env:SUBDOMAIN='grafana'

find ./docker-compose -type f -name '*.env' -exec grep -h "^SUBDOMAIN=" {} + | cut -d "=" -f 2
# Shorter output
# 'auth'
# 'calibre'
# 'grafana'