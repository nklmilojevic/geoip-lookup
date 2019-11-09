[![CircleCI](https://circleci.com/gh/nklmilojevic/geoip-lookup/tree/master.svg?style=svg&circle-token=d1d9dbe1f33dc6dc5c7d534cfea312dc832928f9)](https://circleci.com/gh/nklmilojevic/geoip-lookup/tree/master)

# GeoIP Lookup

This is a simple python app that runs Flask and its built-in webserver. The server runs on port `8000` and accepts the IP address argument in the URL (either IPv4 or IPv6) and returns json with the data from [Maxmind](https://dev.maxmind.com/geoip/geoip2/downloadable/) database.

Example with [httpie](https://httpie.org/):

[![asciicast](https://asciinema.org/a/aFq6jRHYp6c6fK5zrsswqKXJ8.svg)](https://asciinema.org/a/aFq6jRHYp6c6fK5zrsswqKXJ8)

Example with `curl` and `jq`:

[![asciicast](https://asciinema.org/a/pX9dU9fgjhBJuhivb2mOM9UZR.svg)](https://asciinema.org/a/pX9dU9fgjhBJuhivb2mOM9UZR)

# Docker

There is an automated build for this repo that goes to CircleCI and pushes the image to Dockerhub. If you don't want to build it yourself, you can just run it like this:

`docker run --name geoip-lookup -d -p 8000:8000 nklmilojevic/geoip-lookup`
