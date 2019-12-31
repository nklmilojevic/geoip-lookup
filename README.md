# GeoIP Lookup

This is a simple python app that runs Flask, uWSGI and nginx. The server runs on port `8080` and accepts the IP address argument in the URL (either IPv4 or IPv6) and returns json with the data from [Maxmind](https://dev.maxmind.com/geoip/geoip2/downloadable/) database.

Example with [httpie](https://httpie.org/):

[![asciicast](https://asciinema.org/a/aFq6jRHYp6c6fK5zrsswqKXJ8.svg)](https://asciinema.org/a/aFq6jRHYp6c6fK5zrsswqKXJ8)

Example with `curl` and `jq`:

[![asciicast](https://asciinema.org/a/pX9dU9fgjhBJuhivb2mOM9UZR.svg)](https://asciinema.org/a/pX9dU9fgjhBJuhivb2mOM9UZR)

# Maxmind GeoIP changes

[Maxmind has changed their policy so you cannot download the databases without the account.](https://blog.maxmind.com/2019/12/18/significant-changes-to-accessing-and-using-geolite2-databases/). So, you need to register for a MaxMind account and download GeoIP.conf or change the values in `docker/GeoIP.conf`, otherwise it won't work.
