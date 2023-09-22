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

##curl "https://api.weather.gov/points/39.7456,-97.0892" 

##curl "https://api.weather.gov/gridpoints/TOP/31,80/forecast"


###This is to get the latitude and longitude of the user based on their ip address
echo "fetching your ip address and lat and long"
curl -s "http://ip-api.com/json/" | \
python3 -c "
import sys, json;
from pprint import pprint;

jsonData = json.load(sys.stdin)
#latitude = jsonData["lat"]
#longitude = jsonData["long"]

pprint(json.load(sys.stdin))
"

###Now the lat and long is used to get the office and grid coords which is needed to get the forecast for our region



###going to cheat and use python to parse the json
###This if to get the weather forecast data
curl -s "https://api.weather.gov/gridpoints/TOP/31,80/forecast" | \
python3 -c "
import sys, json;
from pprint import pprint;

jsonOutput =  json.load(sys.stdin)['properties']['periods']

#loop through periods to get the 7 day forecast
"""
for x in jsonOutput:
    pprint(x['name'])
    pprint(str(x['temperature']) + x['temperatureUnit'])
    pprint(x['detailedForecast'])
    print('\n\n')

"""
#pprint(jsonOutput[0]['temperature'])

"

######
### Week Variable Declarations
###WEEKTEMPERATURE=(0,1,2,3,4,5,6)
######


##curl -s "https://api.weather.gov/gridpoints/TOP/31,80/forecast"
