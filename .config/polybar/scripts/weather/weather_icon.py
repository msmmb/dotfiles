#!/usr/bin/env python3

import json, time
import urllib.request

apiKey="xxxxx"
city="" # city name
# city="" #city code
language="es"
unit="metric"

## Icons --> https://openweathermap.org/weather-conditions
file = open('/home/michael/.config/polybar/scripts/weather/icons.json', 'r')
icons = json.load(file)
icons_day = icons['icons_day']
icons_night = icons['icons_night']
icons = icons['icons']
file.close()

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

    weather = makeRequest()

    if not weather:
        for _ in range(5):
            weather = makeRequest()
            time.sleep(2)
            if weather:
                break

    # print(weather)
    if weather:
        icon = str(weather.get("icon"))

        if icon != "800" and icon != "801":
            print(f" {icons[icon]} ")
        else:
            if weather.get("day_night") == "d":
                print(f" {icons_day[icon]} ")
            else:
                print(f" {icons_night[icon]} ")
    else:
        # print("   ")
        print("")

