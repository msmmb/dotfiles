#!/usr/bin/env python3

import json, time
import urllib.request

# The API key that you generated from openmapweather website.
apiKey="xxxxx"

# The city you want to get the weather for.
# I've used my own as an example.

city="" # city name
# city="" #city code

# The language you want to get the weather in.
# This should be an iso code of the language.
language="eu"

# The measurement unit you want to get the weather in.
# This can metric for °C (celsius).
# imperial for °F (fahrenheit).
# and standard for K (kelvin). 
unit="metric"

# Makes a request to the API.

def makeRequest():
    try:
        url = f"https://api.openweathermap.org/data/2.5/weather?q={city}&lang={language}&units={unit}&appid={apiKey}"
        # url = f"https://api.openweathermap.org/data/2.5/weather?id={city}&appid={apiKey}"
        request = urllib.request.urlopen(url)

        # If the request returned with "OK", load the json info.
        # else print the request code.

        if request.getcode() == 200:
            data = json.loads(request.read())
            # print(data)
            return {
                "name": data["name"],
                "temp_min": round(data["main"]["temp_min"]),
                "temp_max": round(data["main"]["temp_max"]),
                # "temp": round(data["main"]["temp"]-273.15, 1), #celsius
                # "temp": round((data["main"]["temp"]-273.15)*9/5+32), #fahrenheit
                # "temp": round(data["main"]["temp"]), #kelvin
                "temp": round(data["main"]["temp"], 1),
                "description": data["weather"][0]["description"],
                "icon": data["weather"][0]["id"],
                "day_night": data["weather"][0]["icon"][2]
            }
        else:
            print(f"Error: {request.getcode()}")
    except:
        return None


if __name__ == "__main__":

    # Make a request to the API.
    # Then print the info as follows,
    # "1°C, Sunny".
    # "4°C. Overcast Clouds".

    weather = makeRequest()

    if not weather:
        for _ in range(5):
            weather = makeRequest()
            time.sleep(2)
            if weather:
                break

    # print(weather)
    if weather:
        name = weather.get("name")
        temp = weather.get("temp")
        temp_min = weather.get("temp_min")
        temp_max = weather.get("temp_max")
        temp2 = weather.get("temp2")
        description = weather.get("description")
        icon = str(weather.get("icon"))

        # print(f"{icons_day[icon]} {description} {temp}°C ")
        print(f"{temp}°C")
        # print(f"{description} {temp}°C")

    else:
        print("_°C ")

