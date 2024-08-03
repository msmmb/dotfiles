#!/usr/bin/env python3

import json, time, datetime, sys
import urllib.request

api_key="xxxx"
city="xxxx" # city name
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
        url2 = f"https://api.openweathermap.org/data/2.5/weather?q={city}&lang={language}&units={unit}&appid={api_key}"
        print(url)
        request = urllib.request.urlopen(url)

        if request.getcode() == 200:
            data = json.loads(request.read())
            print(data)
            """
            lon = data["coord"]["lon"]
            lat = data["coord"]["lat"]
            sunset = data["sys"]["sunset"] + data["timezone"]
            sunset_hour = int(datetime.datetime.utcfromtimestamp(sunset).strftime('%H'))
            cnt = 2 if sunset_hour > 18 else 3
            url2 = f"https://api.openweathermap.org/data/2.5/forecast?lat={lat}&lon={lon}&cnt={cnt}&appid={api_key}"
            try:
                request = urllib.request.urlopen(url2)
                data2 = json.loads(request.read())
                print(data2["list"][-1])
            except:
                print("fallo")
            """
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
                "timezone": data["timezone"],
                "humidity": data["main"]["humidity"]
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
        humidity = weather.get("humidity")
        description = weather.get("description")
        icon = str(weather.get("icon"))

        hora_actual = time.time() + timezone
        # icon_sol = "  " if hora_actual < sunrise else ("  " if hora_actual < sunset else "")
        icon_sol = "  " if hora_actual < sunrise else ("  " if hora_actual < sunset else "")
        # sol = sunrise if hora_actual < sunrise else (sunset if hora_actual < sunset else f" {humidity}%  ")
        sol = sunrise if hora_actual < sunrise else (sunset if hora_actual < sunset else space + description + space)
        try:
            if sol != humidity:
                sol = space + datetime.datetime.fromtimestamp(sol, datetime.UTC)
        except:
            ...


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

