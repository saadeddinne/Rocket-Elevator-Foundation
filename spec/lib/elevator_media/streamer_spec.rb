require 'rails_helper'
require 'elevator_media/streamer.rb'


describe ElevatorMedia::Streamer do    
    before do
        @streamer = ElevatorMedia::Streamer.new
        @quebec = "6325494"
    end
    
    context "First Test" do
        it "should return true: First test" do
            expect(true).to be true        
        end
    end
    # Test the Streamer Class and instanciation
    context "generate streamer object" do
        it "get new streamer object" do
            expect(@streamer).to be_an_instance_of(ElevatorMedia::Streamer)    
        end
    end
    # Test the response of the method getContent 
    context "getContent Test" do
        it "getContent does she work ?" do
            expect(@streamer).to respond_to(:getContent)        
        end
    end
    # Test: getContent should return data
    # Test: Forecast should return data
    context "should return html: forcast" do
        it "return valid HTML" do
            html = @streamer.getContent(@quebec, "Forecast")
            puts html
            expect(html).to include('div')
            # expect(html).to have_tag('div')
        end
    end
    # Test to verify if the returned API not 404
    context "what if getcontext return 'nil' with a wrong city id" do
        it "handle 404 result from API" do
            # Call with wrong city ID
            html = @streamer.getContent("632549", "Forecast")
            puts html
            expect(html).to eq("ERROR 404")
            # expect(html).to have_tag('div')
        end
    end
    # Test the response of the method : getCovidStats
    context "getCovidStats Test: Check the call of the method" do
        it "Test the call of the method getCovidStats ?" do
            expect(@streamer).to respond_to(:getCovidStats)  
            @streamer.getContent("632549", "Covid")      
        end
    end
   
end

