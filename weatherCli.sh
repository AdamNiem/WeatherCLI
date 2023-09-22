#!/bin/bash

### this is a commmentn I think
###
###rough outline
### Header of program
###Have a function or command to be called that can have location specified or not (if not specifed then do the below line: )
### Get user ip and use geoip to get their latitude and longitude
### done.
###
###
###info wanted: temperature


echo "hello worldss"

##curl "https://api.weather.gov/points/39.7456,-97.0892" 

##curl "https://api.weather.gov/gridpoints/TOP/31,80/forecast"


###going to cheat and use python to parse the json

curl -s "https://api.weather.gov/gridpoints/TOP/31,80/forecast" | \
python3 -c "
import sys, json, pprint;
jsonOutput =  json.load(sys.stdin)['properties']['periods']

#loop through periods to get the 7 day forecast

pprint.pprint(jsonOutput[0])

"

######
### Week Variable Declarations
###WEEKTEMPERATURE=(0,1,2,3,4,5,6)
######


##curl -s "https://api.weather.gov/gridpoints/TOP/31,80/forecast"
