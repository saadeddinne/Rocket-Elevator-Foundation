require 'rails_helper'
RSpec.describe QuotesController, type: :controller do
        describe "Test NEW method with valid attributes " do
            it "Should return true: no missing attributes" do
                get :create
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
end

  


