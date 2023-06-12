#!/bin/sh

echo "Starting setup..."

echo '{ "startms": ' > /usr/share/nginx/html/info.json
echo $STARTMS >> /usr/share/nginx/html/info.json
echo -n ', "user": "' >> /usr/share/nginx/html/info.json
echo -n $HRTUSER >> /usr/share/nginx/html/info.json
echo '", "dosemg": ' >> /usr/share/nginx/html/info.json
echo $DOSEMG >> /usr/share/nginx/html/info.json
echo ', "doseinterval": ' >> /usr/share/nginx/html/info.json
echo $DOSEINT >> /usr/share/nginx/html/info.json
echo -n ', "form": "' >> /usr/share/nginx/html/info.json
echo -n $HRTFORM >> /usr/share/nginx/html/info.json
echo '", "unitsperdose": ' >> /usr/share/nginx/html/info.json
echo $HRTUNITS >> /usr/share/nginx/html/info.json
echo ' }' >> /usr/share/nginx/html/info.json

echo "Setup complete."

echo "Starting nginx..."
nginx -g "daemon off;"