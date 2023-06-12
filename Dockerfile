FROM nginx:alpine
COPY hrtracker/build/web /usr/share/nginx/html
COPY setup.sh /usr/home/setup.sh

# EXAMPLE
# {
#     "startms": $STARTMS,
#     "user": "$HRTUSER",
#     "dosemg": $DOSEMG,
#     "doseinterval": $DOSEINT,
#     "form": "$HRTFORM",
#     "unitsperdose": $HRTUNITS
# }


# RUN echo '{ "startms": ' > /usr/share/nginx/html/info.json
# RUN echo $STARTMS >> /usr/share/nginx/html/info.json
# RUN echo ', "user": "' >> /usr/share/nginx/html/info.json
# RUN echo $HRTUSER >> /usr/share/nginx/html/info.json
# RUN echo '", "dosemg": ' >> /usr/share/nginx/html/info.json
# RUN echo $DOSEMG >> /usr/share/nginx/html/info.json
# RUN echo ', "doseinterval": ' >> /usr/share/nginx/html/info.json
# RUN echo $DOSEINT >> /usr/share/nginx/html/info.json
# RUN echo ', "form": "' >> /usr/share/nginx/html/info.json
# RUN echo $HRTFORM >> /usr/share/nginx/html/info.json
# RUN echo '", "unitsperdose": ' >> /usr/share/nginx/html/info.json
# RUN echo $HRTUNITS >> /usr/share/nginx/html/info.json
# RUN echo ' }' >> /usr/share/nginx/html/info.json



# docker run -d -p 80:80 --name hrtracker -e STARTMS=1686349500000 -e HRTUSER=Ember -e DOSEMG=4 -e DOSEINT=7 -e HRTFORM=injections -e HRTUNITS=1 hrtracker

# EXPOSE 80

CMD ["/bin/sh", "/usr/home/setup.sh"]

