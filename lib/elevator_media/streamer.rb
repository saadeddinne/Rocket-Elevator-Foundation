require 'open_weather'
require "uri"
require "net/http"
puts "before app: #{ENV["OPEN_WEATHER_KEY"].inspect}"

module ElevatorMedia
    class Streamer
        def new
            @streamer = Streamer.new
        end
        # version 1:: return first media content weather by city ID getContent(city) 
        # Version2:: get media content specified by argument: forecast or covid
        def getContent(city, media) 
           
            if (media == "Covid") 
                getCovidStats() 
            end
            if (media == "Forecast") 
                weather =  self.getForecast(city)
                if weather["cod"] == '404'
                    html = "ERROR 404"
                else
                    html = "<html><body><div class='forecast'> <h3>City</h3>: #{weather["name"]}, #{weather["sys"]["country"]}, #{weather["weather"][0]["description"]}, #{weather["main"]["temp"]} °C, #{weather["main"]["humidity"]} Humidity  </div></body></html>"
                end
            else 
                html = "Undefined media type !"
            end
            return html
        end
        # get weather by City ID and return json content
        def getForecast(city)           
            options = { units: "metric", 
            APPID: ENV["OPEN_WEATHER_KEY"] }             
            OpenWeather::Current.city_id(city, options)
        end 
        # Return Stats about Covid-19 in a city (canada)
        def getCovidStats 
            return "yes Covid"
        end
        
    end
end