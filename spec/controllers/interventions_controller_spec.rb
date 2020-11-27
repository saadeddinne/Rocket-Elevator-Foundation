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
              describe "Intervention Controller: failure scenario" do
                it "Should not create a new intervention and return False" do
                  puts "Should not create a new intervention and return False: missing attributes" 
                  
                  intervention = Intervention.new(
                              # author: 104, missing field
                              # customer_id: 102,
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
                              expect{intervention}.to_not change(Intervention, :count)
                            end
                          end  
                          
          context "Test the HTTP response intervention controller " do
              it "should retur 200 as response" do
                                  confg  =  {
                                  building_id: 109,
                                  battery_id: 1234567,
                                  column_id:  90787,
                                  elevator_id: 234576,
                                  employee_id: 190,
                                  start_intervention: "2009-04-27 00:43:58",
                                  end_intervention: "2009-04-27 00:43:58",
                                  result: "InComplete",
                                  report: " bla bla bla",
                                  status: "pending"
                                    }
                                    post(:create, params: confg)
                                    # The HTTP response status code 302 Found is a common way of performing URL redirection. (devise : need to be logged)
                                    expect(response.code).to eq "302"
                            end
                        end
                       
            end
