import ipaddress
import logging

import maxminddb
from flask import jsonify, request

from geoip_lookup import app, errors

logging.basicConfig(
    level=app.config["LOG_LEVEL"], format="[%(asctime)s][%(levelname)s] - %(message)s"
)
logger = logging.getLogger(__name__)


reader = maxminddb.open_database(app.config["GEOIP_DB_PATH"])


def error_response(msg, rc):
    """
    Returns properly formatted error api response
    :param msg: Human readable error message
    :param rc: HTTP return code
    :return: JSON formatted error response
    """
    return jsonify({"status": "error", "msg": str(msg)}), rc


@app.route("/")
def client_ip():
    ip_address = request.remote_addr
    geo_data = reader.get(ip_address)
    return geo_data


@app.route("/ip/<ip_address>")
def ip(ip_address):
    ipaddress.ip_address(ip_address)
    geo_data = reader.get(ip_address)
    return geo_data
