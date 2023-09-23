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


###This is to get the latitude and longitude of the user based on their ip address
#Src: https://www.reddit.com/r/bash/comments/8kkm9x/redirecting_python_output_to_bash_variables/
#Thanks to user [deleted] for the answer to use bash arrays to convert python vars to bash
echo "going to http://ip-api.com/json/ to get lat and long"
COORDS=($(curl -s "http://ip-api.com/json/" | \
python3 -c "
import sys, json;
from pprint import pprint;
 
jsonData = json.load(sys.stdin)
latitude = jsonData['lat']
longitude = jsonData['lon']

#outputs the latitude and longtitude so they can be set to their bash counterparts
print(latitude) #latitude
print(longitude) #longitude
"))

###Now the lat and long is used to get the office and grid coords which is needed to get the forecast for our region
echo "fetching your grid forecast endpoints for gov weather api"
GRID_INFO=($(curl -s "https://api.weather.gov/points/${COORDS[0]},${COORDS[1]}" | \
python3 -c "
import sys, json;
from pprint import pprint;
 
jsonData = json.load(sys.stdin)
gridX = jsonData['properties']['gridX']
gridY = jsonData['properties']['gridY']
gridId = jsonData['properties']['gridId'] #this should be the same thing as the grid office name since thats needed

#outputs the gridX and gridY so they can be set to their bash counterparts
print(gridX) #gridX
print(gridY) #gridY
print(gridId) #this is the grid office name
"))

###going to cheat and use python to parse the json
###This if to get the weather forecast data
curl -s "https://api.weather.gov/gridpoints/${GRID_INFO[2]}/${GRID_INFO[1]},${GRID_INFO[1]}/forecast" | \
python3 -c "
import sys, json;
from pprint import pprint;

jsonOutput =  json.load(sys.stdin)['properties']['periods']

#loop through periods to get the 7 day forecast

for x in jsonOutput:
    pprint(x['name'])
    pprint(str(x['temperature']) + x['temperatureUnit'])
    pprint(x['detailedForecast'])
    print('\n\n')

"

