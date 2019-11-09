from flask import Flask

app = Flask(__name__)
app.config.from_object("geoip_lookup.settings")

from geoip_lookup import geo