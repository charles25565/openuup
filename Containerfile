FROM cgr.dev/chainguard/wolfi-base:latest AS cloner
RUN apk add git
RUN git clone --depth=1 --recurse-submodules https://git.uupdump.net/uup-dump/json-api.git
FROM cgr.dev/chainguard/wolfi-base:latest AS openuup
RUN apk add php-8.4 7zip
COPY web.html /openuup/index.html
ADD https://raw.githubusercontent.com/oxalorg/sakura/refs/heads/master/css/sakura-dark.css /openuup/sakura.css
COPY --from=cloner /json-api /openuup/json-api
RUN ln -s /fileinfo /openuup/json-api/fileinfo
RUN ln -s /packs /openuup/json-api/packs
EXPOSE 80
VOLUME ["/fileinfo", "/packs"]
CMD /usr/bin/php -S 0.0.0.0:80 -t /openuup
