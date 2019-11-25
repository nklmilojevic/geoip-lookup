FROM python:3.8-buster

ENV USER=app
ENV UID=1337
ENV GID=1337

RUN addgroup --gid "$GID" "$USER" \
  && adduser \
  --disabled-password \
  --gecos "" \
  --home "/app" \
  --ingroup "$USER" \
  --no-create-home \
  --uid "$UID" \
  "$USER"

RUN apt-get update \
  && apt-get install -y wget nginx supervisor \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ARG GEOIP_VERSION=4.1.5

RUN wget -q https://github.com/maxmind/geoipupdate/releases/download/v${GEOIP_VERSION}/geoipupdate_${GEOIP_VERSION}_linux_amd64.tar.gz \
  && tar -xvf geoipupdate_${GEOIP_VERSION}_linux_amd64.tar.gz \
  && mv geoipupdate_${GEOIP_VERSION}_linux_amd64/geoipupdate /usr/bin/ \
  && chmod a+x /usr/bin/geoipupdate \
  && rm -rf geoipupdate_${GEOIP_VERSION}_linux_amd64.tar.gz geoipupdate_${GEOIP_VERSION}_linux_amd64 \
  && mkdir /usr/local/share/GeoIP

COPY docker/GeoIP.conf /usr/local/etc/GeoIP.conf
COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY docker/nginx.conf /etc/nginx/nginx.conf
RUN /usr/bin/geoipupdate

COPY . /app

RUN chown -R app.app /app \
  && chown -R app.app /var/lib/nginx \
  && chown -R app.app /var/log/nginx

USER app
WORKDIR /app

ENV PATH=$PATH:/app/.local/bin

RUN pip install --user pipenv && pipenv install --deploy

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]