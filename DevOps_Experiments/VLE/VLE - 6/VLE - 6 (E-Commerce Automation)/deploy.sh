#!/bin/bash
set -e

CURRENT=$(cat /opt/ecommerce/active_env 2>/dev/null || echo "blue")
if [ "$CURRENT" = "blue" ]; then
  TARGET="green"; PORT=4001
else
  TARGET="blue"; PORT=4000
fi

echo "Current: $CURRENT -> Switching to: $TARGET"
echo "Running health check on $TARGET (port $PORT)..."

if curl -sf http://localhost:$PORT/health > /dev/null; then
  echo "Health check PASSED!"
  sed -i "s/proxy_pass http:\/\/127.0.0.1:[0-9]*/proxy_pass http:\/\/127.0.0.1:$PORT/" /etc/nginx/conf.d/ecommerce.conf
  nginx -s reload
  echo "$TARGET" > /opt/ecommerce/active_env
  echo "Traffic switched to $TARGET! Deployment complete!"
else
  echo "Health check FAILED! Rollback - keeping $CURRENT"
  exit 1
fi