require 'rails_helper'



RSpec.describe LeadsController, type: :controller do

  describe "Test Customer : Success scenario" do
    let!(:company_name){"somethingName"}
    let!(:company_contact_full_name){"somethingFullName"}
    let!(:company_contact_email){"email@email.com"}
   

    context " Test USER create method" do
      it 'Should return True' do
        "Customer creation should return True"
          customer = Customer.create(company_name: company_name, company_contact_full_name: company_contact_full_name, company_contact_email: company_contact_email)
          expect(customer.company_contact_email).to eq(company_contact_email)
          expect(customer.company_name).to eq("#{company_name}")
        end
      end
    
    context " Test Customer update" do
        it "Custome update should return True" do
          puts "Customer update should return True"
          customer = Customer.create(company_name: company_name, company_contact_full_name: company_contact_full_name, company_contact_email: company_contact_email)
          customer.update(company_name: 'CodeBoxx')
            expect(customer.company_name).to eq('CodeBoxx')
          
        end
    end
  end
end
