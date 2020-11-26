require 'rails_helper'



RSpec.describe InterventionController, type: :controller do

  describe "User Controller: Success scenario" do
    let!(:first_name){"first_name"}
    let!(:last_name){"last_name"}
    let!(:title){"title"}
    let!(:created_at){"2020-11-19 15:57:29"}
    let!(:email){"email@corp.com"}

    context " Test USER create method" do
      it 'Should return True' do
          user = User.create(first_name: first_name, last_name: last_name, email: email)
          expect(user.email).to eq(email)
          expect(user.first_name).to eq("#{first_name}")
        end
      end
    
    context " Test USER update" do
        it "User update should return True" do
            user = User.create(first_name: first_name, last_name: last_name, title: title, created_at: created_at, email: email)
            user.update(first_name: 'Saad eddine')
            expect(user.first_name).to eq('Saad eddine')
          
        end
    end
    
  
  end   
end
