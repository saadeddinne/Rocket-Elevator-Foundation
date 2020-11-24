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
    # Test the Streamer Class and instanciation
    context "generate streamer object" do
        it "get new streamer object" do
            expect(@streamer).to be_an_instance_of(ElevatorMedia::Streamer)    
        end
    end
    # Test the response of the method getContent and type
    context "getContent Test" do
        it "getContent does she work ?" do
            expect(@streamer).to respond_to(:getContent)        
        end
    end
    # Test first data contenu should be returned by getContent
    context "should return html: forcast" do
        it "return valid HTML" do
            html = @streamer.getContent()
            puts html
            expect(html).to include('div')
            # expect(html).to have_tag('div')
        end
    end
end

