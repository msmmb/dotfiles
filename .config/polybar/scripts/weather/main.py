#!/usr/bin/env python3

import json, time, datetime, sys
import urllib.request

apiKey="xxxxx"
city="xxxxx" # city name
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
        request = urllib.request.urlopen(url)

        if request.getcode() == 200:
            data = json.loads(request.read())
            return {
                "name": data["name"],
                "temp_min": round(data["main"]["temp_min"]),
                "temp_max": round(data["main"]["temp_max"]),
                "temp": round(data["main"]["temp"], 1),
                "description": data["weather"][0]["description"],
                "icon": data["weather"][0]["id"],
                "day_night": data["weather"][0]["icon"][2],
                "sunrise": data["sys"]["sunrise"],
                "sunset": data["sys"]["sunset"],
                "timezone": data["timezone"]
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

    if weather:
        space = " "
        degrees = "ºC"
        name = weather.get("name")
        temp = weather.get("temp")
        temp_min = weather.get("temp_min")
        temp_max = weather.get("temp_max")
        temp2 = weather.get("temp2")
        timezone = weather.get("timezone")
        sunrise = weather.get("sunrise") + timezone
        sunset = weather.get("sunset") + timezone
        description = weather.get("description")
        icon = str(weather.get("icon"))

        hora_actual = time.time()
        icon_sol = "  " if hora_actual < sunrise else ("  " if hora_actual < sunset else " ")
        # icon_sol = " " if hora_actual < sunrise else (" " if hora_actual < sunset else "")
        sol = sunrise if hora_actual < sunrise else (sunset if hora_actual < sunset else description)
        try:
            sol = datetime.datetime.utcfromtimestamp(sol).strftime('%H:%M')
        except:
            ...
        sol = space + sol


        if icon != "800" and icon != "801":
            icon = icons[icon]
        else:
            if weather.get("day_night") == "d":
                icon = icons_day[icon]
            else:
                icon = icons_night[icon]

        output = ""
        for i in range(1, len(sys.argv)):
            output += f"{globals()[sys.argv[i]]}"

        print(output)

    else:
        print("")

