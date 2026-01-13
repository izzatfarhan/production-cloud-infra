#!/bin/bash

APP_URL="http://localhost/health"
CONTAINER_NAME="fastapi-app"

STATUS=$(curl -s -o /dev/null -w "%{http_code}" $APP_URL)

if [ "$STATUS" != "200" ]; then
  echo "$(date) - App unhealthy. Restarting container..."
  docker restart $CONTAINER_NAME
else
  echo "$(date) - App healthy"
fi
