#!/usr/bin/env python3

import json, time
import urllib.request

apiKey="xxxxx"
city="" # city name
# city="" #city code
language="es"
unit="metric"

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
        name = weather.get("name")
        temp = weather.get("temp")
        temp_min = weather.get("temp_min")
        temp_max = weather.get("temp_max")
        temp2 = weather.get("temp2")
        description = weather.get("description")
        icon = str(weather.get("icon"))

        # print(f"{icons_day[icon]} {description} {temp}°C ")
        # print(f"{temp}°C")
        print(f" {description} {temp}°C")

    else:
        # print("_°C ")
        print("")

