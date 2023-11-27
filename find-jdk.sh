#!/bin/sh
curl 'https://api.foojay.io/disco/v3.0/packages?operating_system=linux&version=21&architecture=x86_64&distribution=temurin' | jq
