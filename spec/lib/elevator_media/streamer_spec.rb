require 'rails_helper'
require 'elevator_media/streamer.rb'

openweatherfake = {"coord"=>{"lon"=>-71.21, "lat"=>46.81}, "weather"=>[{"id"=>804, "main"=>"Clouds", "description"=>"overcast clouds", "icon"=>"04d"}], "base"=>"stations", "main"=>{"temp"=>0.22, "feels_like"=>-7.62, "temp_min"=>-0.56, "temp_max"=>1, "pressure"=>1016, "humidity"=>93, "sea_level"=>1016, "grnd_level"=>1011}, "visibility"=>9686, "wind"=>{"speed"=>8.2, "deg"=>70, "gust"=>10.8}, "clouds"=>{"all"=>100}, "dt"=>1606416042, "sys"=>{"type"=>1, "id"=>606, "country"=>"CA", "sunrise"=>1606392223, "sunset"=>1606424479}, "timezone"=>-18000, "id"=>6325494, "name"=>"Québec", "cod"=>200}

exchangeapi = {"time"=>"2020-11-26T18:40:00Z", "amount"=>1.30597}

covidapi = {"latest_date"=>"2020-11-26", "change_cases"=>"1864", "change_fatalities"=>"42", "change_tests"=>"4262", "change_hospitalizations"=>"23", "change_criticals"=>"-7", "change_recoveries"=>"1226", "change_vaccinations"=>"0", "total_cases"=>"352865", "total_fatalities"=>"11783", "total_tests"=>"12456485", "total_hospitalizations"=>"2266", 
"total_criticals"=>"446", "total_recoveries"=>"278445", "total_vaccinations"=>"0"}

describe ElevatorMedia::Streamer do    
        # When integrating with external services we want to make sure our test suite isn’t hitting any 3rd party services. Our tests should run in isolation.   
    let!(:streamer){ElevatorMedia::Streamer.new}
    let!(:quebec){"6325494"}
    
    
    context "First Test" do
        it "should return true: First test" do
            expect(true).to be true        
        end
    end
    # Test the Streamer Class and instanciation
    context "generate streamer object" do
        it "get new streamer object" do
            expect(streamer).to be_an_instance_of(ElevatorMedia::Streamer)    
        end
    end
    # Test the response of the method getContent 
    context "getContent Test" do
        it "getContent does she work ?" do
            expect(streamer).to respond_to(:getContent)        
        end
    end
    # Test: getContent should return data
    # Test: Forecast should return data
    context "should return html: forecast" do
        it "Forecast should return valid HTML" do
            html = streamer.getContent(quebec, "Forecast") 
            puts html
            expect(html).to include('div')
            # expect(html).to have_tag('div')
        end
    end
    # Test to verify if the returned API not 404
    context "what if getcontext return 'nil' with a wrong city id." do
        it "Forecast: handle 404 result from API OpenWeather." do
            # Call with wrong city ID
            html = streamer.getContent("632549", "Forecast") 
            puts html
            expect(html).to eq("ERROR 404 failure to connect to the API")
            # expect(html).to have_tag('div')
        end
    end
    # Test the response of the method : getCovidStats
    context "getCovidStats Test: Check the call of the method" do
        it "Test the call of the method getCovidStats ?" do
            expect(streamer).to respond_to(:getCovidStats) 
            streamer.getContent("632549", "Covid")      
        end
    end
   
     # Call getContent with wrong argument
     context "getContent: Handle undifined call" do
        it "Test the call of the method with wrong argument ?" do
            expect(streamer).to respond_to(:getCovidStats)  
            streamer.getContent("632549", "something")      
        end
    end
    # Test API https://api.covid19tracker.ca
    context "Test covid return Summary if 200 ok" do
        it "getCovidStats should return HTML" do
            html = streamer.getContent(quebec, "Covid") 
            puts html
            expect(html).to include('div')
            # expect(html).to have_tag('div')
        end
    end
    # Test getCovid if connect with API (simulate failure)
    context "Test getCovid return Summary if 200 ok" do
        it "getCovidStats should return HTML" do
            html = streamer.getContent(quebec, "Covid")
            # test is ok
            # expect(html).to eq("ERROR!!!")
            expect(html).to_not eq(nil)
            expect(html).to be_a(String)
        end
    end
     # Test the response of the method : getExchange
     context "getExchange Test: Check the call of the method" do
        it "Test the call of the method getExchange ?" do
            html = streamer.getContent(@quebec, "Exchange") 
            puts html
            expect(streamer).to respond_to(:getContent)  
            expect(html).to_not eq(nil)
            expect(html).to be_a(String)
            expect(html).to include('div')
                 
        end
    end
     # Test the response of the method : getContent with bad argument
     context "getContent Test: Handle Bad argument" do
        it "Test getcontent with bad argument" do
            # test is ok  expect(@treamer).to 
            html = streamer.getContent(quebec, "very bad argument!")
            puts html
            expect(streamer).to_not receive(:getContent).with(@quebec, "very bad argument!")                 
        end
    end

  
end


