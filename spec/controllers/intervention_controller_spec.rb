require 'rails_helper'



RSpec.describe InterventionController, type: :controller do

  describe "Intervention Controller: Success scenario" do
    it "Should create a new intervention and return True" do
      puts "Should create a new intervention and return True: no missing attributes" 
      intervention = Intervention.new(
                  author: 104,
                  customer_id: 102,
                  building_id: 109,
                  battery_id: 1234567,
                  column_id:  90787,
                  elevator_id: 234576,
                  employee_id: 190,
                  start_intervention: "2009-04-27 00:43:58",
                  end_intervention: "2009-04-27 00:43:58",
                  result: "InComplete",
                  report: " bla bla bla",
                  status: "pending").save
                  expect(intervention).to eq(true)
                end
              end
         

            end
