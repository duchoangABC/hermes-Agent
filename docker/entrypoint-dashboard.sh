#!/bin/bash
set -e

# Run the standard Hermes bootstrap logic
source /opt/hermes/docker/entrypoint.sh --bootstrap-only || true

# Wait for background tasks from entrypoint.sh (if any) to settle
sleep 2

# Force dashboard host to 0.0.0.0 so Railway can proxy traffic to it
export HERMES_DASHBOARD_HOST="0.0.0.0"

# Railway provides the PORT environment variable
DASHBOARD_PORT="${PORT:-9119}"

echo "Starting Hermes Dashboard on 0.0.0.0:${DASHBOARD_PORT}"

# Execute the dashboard as the main container process
exec hermes dashboard --host 0.0.0.0 --port "${DASHBOARD_PORT}" --no-open
