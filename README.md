# weather_app

A Flutter Weather App 

## Features

# Home screen 
Displays current location and its weather data, with the color scheme changing based on the time of the day

<img src="https://github.com/Barbora827/weather_app/assets/58209361/632ce061-5012-4391-9743-f5d4e8dab54c" height=500> <img src="https://github.com/Barbora827/weather_app/assets/58209361/f8f3e765-3ba9-495b-bec8-b75b78bd9319" height=500>

If the user is offline or has location turned off, the app will display last cached data if possible. If not, the user won't be able to see any data until he turns on internet and location

<img src="https://github.com/Barbora827/weather_app/assets/58209361/8e5b5959-45a9-469c-b803-5d5684a62172" height=500>

# Add City Screen 
Allows the user to add a city to monitor to list, with snackbars for valid and invalid city inputs

<img src="https://github.com/Barbora827/weather_app/assets/58209361/27359821-0eb1-4c28-a785-9f6d9f613338" height=500> <img src="https://github.com/Barbora827/weather_app/assets/58209361/368bbde9-c7c8-41fc-b4f4-b2d167d6bd40" height=500> <img src="https://github.com/Barbora827/weather_app/assets/58209361/5586b6de-fa0a-42d4-b96d-e2f37f131339" height=500>

# City List Screen
Displays all the added cities by users. The list can be refreshed and cities can be deleted

<img src="https://github.com/Barbora827/weather_app/assets/58209361/fe575773-6939-4522-bf29-69c936b3af29" height=500> <img src="https://github.com/Barbora827/weather_app/assets/58209361/5b01f174-c45c-41c1-9c88-bb77209fa587" height=500>

Any of the cities on the list can be clicked on in order to be navigated to a detailed weather view for given city
<img src="https://github.com/Barbora827/weather_app/assets/58209361/bfc41cf8-c0a5-4873-82cd-4e884417a58d)" height=500>

## Architecture

- bloc
  - weather_bloc
  - city_list_bloc
  - add_city_bloc
- data
  - models
  - keys
- presentation
  - screens
  - styles
  - widgets

## APIs used
- OpenWeatherMap OneCallAPI (https://openweathermap.org/api/one-call-api)
- GoogleMaps Geocoding API (https://developers.google.com/maps/documentation/geocoding)
