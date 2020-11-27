
require 'rails_helper'

RSpec.describe "Test routes of the app" do
    context "Test route to the home page" do
    it "Should '/' route to the static_pages controller, action: index" do
        puts "Should '/' route to the static_pages controller, action: index"
        expect(:get => "/").to route_to(
            :controller => "static_pages",
            :action => "index"
          )
        end
    end

    context "Test route to the residential page" do

    it "Should '/static_pages/residential' route to the static_pages controller, action: residential" do
        puts "Should '/static_pages/residential' route to the static_pages controller, action: residential"
        expect(:get => "static_pages/residential").to route_to(
            :controller => "static_pages",
            :action => "residential"            
          )
        end
    end

    context "Test route to the corporate page" do

        it "Should '/static_pages/corporate' route to the static_pages controller, action: corporate" do
            puts "Should '/static_pages/residential' route to the static_pages controller, action: corporate"
            expect(:get => "static_pages/corporate").to route_to(
                :controller => "static_pages",
                :action => "corporate"            
              )
        end
    end
    context "Test route to the intervention page" do
        it "Should 'intervention/index' route to the intervention controller, action: index" do
            puts "Should '/intervention/index' route to the intervention controller, action: index"
            expect(:get => "intervention#index").to route_to(
                :controller => "intervention",
                :action => "index"            
              )   
        end
    end
    
    context "Test route to the geolocation page" do
        it "Should 'geolocation/index' route to the geolocation controller, action: index" do
            puts "Should 'geolocation/index' route to the geolocation controller, action: index"
            expect(:get => "geolocation#index").to route_to(
                :controller => "geolocation",
                :action => "index"            
              )   
        end
    end
    context "Test route to the '/my_quotes' page" do
        it "Should '/my_quotes' route to the quotes controller, action: user_quotes" do
            puts "Should '/my_quotes' route to the quotes controller, action: user_quotes"
            expect(:get => "/my_quotes").to route_to(
                :controller => "quotes",
                :action => "user_quotes"            
              )   
        end
    end
    
end