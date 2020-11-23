require 'ElevatorMedia/streamer'


    
describe ElevatorMedia::Streamer do

    
    before do
        @streamer = ElevatorMedia::Streamer.new
    end
    
    context "First Test" do
        it "should return true: First test" do
            expect(true).to be true        
        end
    end
    context "generate streamer object" do
        it "get new streamer object" do
            expect(@streamer).to be_an_instance_of(ElevatorMedia::Streamer)    
        end
    end
    context "getContent Test" do
        it "getContent does she work ?" do
            expect(@streamer).to respond_to(:getContent)        
        end
    end
end

