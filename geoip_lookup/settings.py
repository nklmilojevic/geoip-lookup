import logging
import os

GEOIP_DB_PATH = "/usr/local/share/GeoIP/GeoLite2-City.mmdb"

LOG_LEVEL = logging.DEBUG

APP_ROOT = os.path.dirname(os.path.abspath(__file__))
