require 'rails_helper'
RSpec.describe QuotesController, type: :controller do

    before do
        @quote = Quote.new       
    end
        
    context "Quote controller testing:" do
        it "Should return true: no missing attributes" do    
            puts " Quote with valid attributes: return True"          
                quote = Quote.new(
                    user_id: 14,
                    apartments: 184,
                    floors: 104,
                    basements: 4,
                    businesses: 4,
                    elevator_shafts: 7,
                    parking_spaces: 104,
                    occupants: 1004,
                    opening_hours: 24,
                    product_line: "Roma",
                    install_fee: 1000,
                    total_price: 100000,
                    unit_price: 1999,
                    elevator_number: 45566789,
                    building_type: "commercial"
                    ).save
                expect(quote).to eq(true)
            end
        end

        # no change in the Quote model expected 
        context "Quote controller testing: " do
            it "Should return false: missing attributes " do 
                puts " Quote with invalid attributes: return False"           
                    quote = Quote.new(
                        # user_id: 14, missing
                        apartments: 184,
                        floors: 104,
                        basements: 4,
                        businesses: 4,
                        # elevator_shafts: 7, missing
                        parking_spaces: 104,
                        occupants: 1004,
                        opening_hours: 24,
                        product_line: "Roma",
                        install_fee: 1000,
                        total_price: 100000,
                        unit_price: 1999,
                        elevator_number: 45566789,
                        building_type: "commercial"
                        ).save
                    expect{quote}.to_not change(Quote, :count)
                end
            end 

    context " Quote without User id (after log in)" do
        it "after login if user id is missinge should return false" do
            @quote.user_id = nil
            @quote.save
            expect(@quote).to_not eq(true)
        end
    end
    context "Test the HTTP response Quote controller " do

        it "should retur 200 as response" do
            confg =  {
                user_id: 14,
                apartments: 184,
                floors: 104,
                basements: 4,
                businesses: 4,
                elevator_shafts: 7,
                parking_spaces: 104,
                occupants: 1004,
                opening_hours: 24,
                product_line: "Roma",
                install_fee: 1000,
                total_price: 100000,
                unit_price: 1999,
                elevator_number: 45566789,
                building_type: "commercial"
                }
                post(:create, params: confg)
                # The HTTP response status code 302 Found is a common way of performing URL redirection. (devise : need to be logged)
                expect(response.code).to eq "302"
        end
    end

end

  


