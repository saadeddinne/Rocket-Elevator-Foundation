require 'open_weather'
require "uri"
require "net/http"
require 'openssl'
puts "before app: #{ENV["OPEN_WEATHER_KEY"].inspect}"
require "json"

module ElevatorMedia
    class Streamer
        def new
            @streamer = Streamer.new
        end
        # version 1:: return first media content weather by city ID getContent(city) 
        # Version2:: get media content specified by argument: forecast or covid
        def getContent(city, media) 
           
            if (media == "Forecast") 
                weather =  self.getForecast(city)
                if weather["cod"] == '404'
                    html = "ERROR 404 failure to connect to the API"
                else
                    html = "
                    <html><body>
                        <div class='forecast'>
                        <h3>City</h3>: #{weather["name"]}, #{weather["sys"]["country"]}, 
                        #{weather["weather"][0]["description"]}, 
                        Temp: #{weather["main"]["temp"]} °C,
                        Feels like:  #{weather["main"]["feels_like"]} °C, 
                        Humidity : #{weather["main"]["humidity"]}                        
                        </div>
                    </body></html>"
                end
            
            elsif (media == "Covid") 
            covid = getCovidStats()
            if covid == "ERROR!!!"
                html = "ERROR 404 failure to connect to the API"
            else 
            html = "
            <html><body>
                <div class='covid'> 
                    <h3>Latest update</h3>: #{covid.first["latest_date"]},<h3>  
                    <h3>Total hospitalizations</h3>: #{covid.first["total_hospitalizations"]},  
                    <h3>Total recoveries</h3>: #{covid.first["total_recoveries"]},  
                    <h3>Total fatalities</h3>: #{covid.first["total_fatalities"]},  
                </div>
            </body></html>"
            end
            
            elsif (media == "Exchange") 
                item = getExchange() 
                time = item["time"].to_datetime            
                html = "
                <html><body>
                    <div class='Exchange'>
                        <h1>Exchange: USD to CAD</h1>
                        <ul>
                        <li>Last update : #{time.strftime('%d of %B, %Y AT %I:%M %p')  }</li>
                        <li>Amount: #{item["amount"]}</li>
                        </ul>
                    </div>
                </body></html>"
              
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
       
        # Returns a summary of total cases and fatalities in Canada.
        def getCovidStats()
            url = URI("https://api.covid19tracker.ca/summary")
            https = Net::HTTP.new(url.host, url.port);
            https.use_ssl = true
            request = Net::HTTP::Get.new(url)
            response = https.request(request)
            if response.code == "200"
                result = JSON.parse(response.body)
                resultdata = result["data"]
                return resultdata
              else
                return "ERROR!!!"
              end  
        end
        # return Curency exchange
        def getExchange
            url = URI("https://currency13.p.rapidapi.com/convert/1/USD/CAD")

            http = Net::HTTP.new(url.host, url.port)
            http.use_ssl = true
            http.verify_mode = OpenSSL::SSL::VERIFY_NONE
            
            request = Net::HTTP::Get.new(url)
            request["x-rapidapi-key"] = '8def33723emshcd4f9bc61ab02a0p1a8c2bjsn88e772b27530'
            request["x-rapidapi-host"] = 'currency13.p.rapidapi.com'
            
            response = http.request(request)
            @output  = JSON.parse(response.body)
            if @output.empty?
                return "Erorr !!"
            else
                return @output
            end
        end
    end
end