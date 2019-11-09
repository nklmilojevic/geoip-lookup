FROM python:3.7-slim

RUN apt-get update && apt-get install -y wget

ARG GEOIP_VERSION=4.0.6

RUN wget -q https://github.com/maxmind/geoipupdate/releases/download/v${GEOIP_VERSION}/geoipupdate_${GEOIP_VERSION}_linux_amd64.tar.gz \
  && tar -xvf geoipupdate_${GEOIP_VERSION}_linux_amd64.tar.gz \
  && mv geoipupdate_${GEOIP_VERSION}_linux_amd64/geoipupdate /usr/bin/ \
  && chmod a+x /usr/bin/geoipupdate \
  && rm -rf geoipupdate_${GEOIP_VERSION}_linux_amd64.tar.gz geoipupdate_${GEOIP_VERSION}_linux_amd64 \
  && mkdir /usr/local/share/GeoIP

COPY GeoIP.conf /usr/local/etc/GeoIP.conf

RUN /usr/bin/geoipupdate

ADD . /app

WORKDIR /app

RUN pip install pipenv && pipenv install --system --deploy

CMD ["python", "./runserver.py"]