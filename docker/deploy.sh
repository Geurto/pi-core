#!/bin/bash
set -e

TOKEN=b3DrN4x0HeKPmPBwW2FQKlJxebToTzUH
FLEET_NAME=home-pi

balena login --token $TOKEN
balena deploy $FLEET_NAME