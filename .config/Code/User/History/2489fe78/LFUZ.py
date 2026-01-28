#!/usr/bin/env python3
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
# weather using python

import requests
import json
import os

# weather icons
weather_icons = {
    "sunnyDay": "󰖙",
    "clearNight": "󰖔",
    "cloudyFoggyDay": "",
    "cloudyFoggyNight": "",
    "rainyDay": "",
    "rainyNight": "",
    "snowyIcyDay": "",
    "snowyIcyNight": "",
    "severe": "",
    "default": "",
}

# City location
city = "Manila"  # Change to your city

try:
    # Use wttr.in API which is more reliable
    url = f"https://wttr.in/{city}?format=j1"
    response = requests.get(url, timeout=10)
    
    if response.status_code == 200:
        data = response.json()
        
        # Get current weather data
        current = data['current_condition'][0]
        temp_c = current['temp_C']
        weather_desc = current['weatherDesc'][0]['value']
        feels_like = current['FeelsLikeC']
        humidity = current['humidity']
        wind_speed = current['windspeedKmph']
        visibility = current['visibility']
        
        # Determine icon based on weather code and time
        weather_code = current['weatherCode']
        
        # Simple icon mapping based on condition
        if 'Clear' in weather_desc or 'Sunny' in weather_desc:
            icon = weather_icons['sunnyDay']
            status_code = 'sunnyDay'
        elif 'rain' in weather_desc.lower() or 'drizzle' in weather_desc.lower():
            icon = weather_icons['rainyDay']
            status_code = 'rainyDay'
        elif 'cloud' in weather_desc.lower() or 'overcast' in weather_desc.lower():
            icon = weather_icons['cloudyFoggyDay']
            status_code = 'cloudyFoggyDay'
        elif 'snow' in weather_desc.lower() or 'ice' in weather_desc.lower():
            icon = weather_icons['snowyIcyDay']
            status_code = 'snowyIcyDay'
        elif 'thunder' in weather_desc.lower() or 'storm' in weather_desc.lower():
            icon = weather_icons['severe']
            status_code = 'severe'
        else:
            icon = weather_icons['default']
            status_code = 'default'
        
        # Format status text
        status = f"{weather_desc[:16]}.." if len(weather_desc) > 17 else weather_desc
        
        # Format temperature
        temp = f"{temp_c}°C"
        temp_feel_text = f"Feels like {feels_like}°C"
        
        # Get forecast for min/max
        forecast = data['weather'][0]
        temp_min = forecast['mintempC']
        temp_max = forecast['maxtempC']
        temp_min_max = f"  {temp_min}°C\t\t  {temp_max}°C"
        
        # Format other data
        wind_text = f"  {wind_speed} km/h"
        humidity_text = f"  {humidity}%"
        visibility_text = f"  {visibility} km"
        
        # Get hourly precipitation
        hourly = data['weather'][0]['hourly']
        prediction = ""
        for hour in hourly[:6]:  # Next 6 hours
            time = hour['time'].zfill(4)
            time_formatted = f"{time[:2]}:00"
            chance = hour['chanceofrain']
            if int(chance) > 0:
                prediction += f"{time_formatted}: {chance}% "
        
        if prediction:
            prediction = f"\n\n (hourly) {prediction}"
        
        # tooltip text
        tooltip_text = str.format(
            "\t\t{}\t\t\n{}\n{}\n{}\n\n{}\n{}\n{}{}",
            f'<span size="xx-large">{temp}</span>',
            f"<big> {icon}</big>",
            f"<b>{status}</b>",
            f"<small>{temp_feel_text}</small>",
            f"<b>{temp_min_max}</b>",
            f"{wind_text}\t{humidity_text}",
            f"{visibility_text}",
            f"<i> {prediction}</i>",
        )
        
        # print waybar module data
        out_data = {
            "text": f"{icon}  {temp}",
            "alt": status,
            "tooltip": tooltip_text,
            "class": status_code,
        }
        print(json.dumps(out_data))
        
        # Simple weather cache
        simple_weather = (
            f"{icon}  {status}\n"
            + f"  {temp} ({temp_feel_text})\n"
            + f"{wind_text} \n"
            + f"{humidity_text} \n"
            + f"{visibility_text}\n"
        )
        
        try:
            with open(os.path.expanduser("~/.cache/.weather_cache"), "w") as file:
                file.write(simple_weather)
        except Exception as e:
            print(f"Error writing to cache: {e}", file=sys.stderr)
            
    else:
        # Fallback output
        out_data = {
            "text": "  N/A",
            "tooltip": "Weather data unavailable",
            "class": "default",
        }
        print(json.dumps(out_data))

except Exception as e:
    # Error output
    out_data = {
        "text": "  Error",
        "tooltip": f"Failed to fetch weather: {str(e)}",
        "class": "default",
    }
    print(json.dumps(out_data))
