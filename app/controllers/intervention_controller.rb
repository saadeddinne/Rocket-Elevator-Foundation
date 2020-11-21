class InterventionController < ApplicationController
  # check authentication
  before_action :authenticate_user!
  def index
  end


  def my_intervention
         @interventions = Intervention.where(:author => current_user.id)
         puts @interventions
  end



    # Get buildings associated with the selected customer
    def get_building
      if params[:customer].present?
          @buildings = Customer.find(params[:customer]).buildings
      else
          # @buildings = Customer.all
          puts params[:customer]
      end
      # to tell if the request is sent via ajax
      if request.xhr?
          respond_to do |f|
              f.json {
                  render json: {buildings: @buildings}
              }
          end
      end
  end

  # Once the selection of the building has been made, a selector listing the batteries belonging to that building must then be displayed. 
  def get_battery
    if params[:building].present?
        @batteries = Building.find(params[:building]).batteries
    else
        @batteries = Building.all
    end
    # to tell if the request is sent via ajax
    if request.xhr?
        respond_to do |f|
            f.json {
                render json: {batteries: @batteries}
            }
        end
    end
    end
    # listing the columns belonging to the battery
    def get_column
        if params[:battery].present?
            @columns = Battery.find(params[:battery]).columns
        else
            @columns = Battery.all
        end
        if request.xhr?
            respond_to do |f|
                f.json {
                    render json: {columns: @columns}
                }
            end
        end
    end
    # Listing the elevators belonging to the column
    def get_elevator
        if params[:column].present?
            @elevators = Column.find(params[:column]).elevators
        else
            @elevators = Column.all
        end
        if request.xhr?
            respond_to do |f|
                f.json {
                    render json: {elevators: @elevators}
                }
            end
        end
    end


    def new
        @intervention = Intervention.new
    end

    # the author is the crrent user
    def author_intervention
        @interventions = Intervention.where(:user_id => current_user.id)
    end



    def create 
        @intervention = Intervention.new(intervention_params)
        puts "********************************"     
     
       

       @intervention.author = current_user.id
       firstname            = current_user.first_name
       lastname             = current_user.last_name
       adressbuilding       = Address.find(params[:building])
       @company    = Customer.find(params[:customer]).company_name
       @intervention.employee_id = params[:employee]
       @intervention.customer_id = params[:customer]
       @intervention.building_id = params[:building]
       @intervention.battery_id = params[:battery]
       @intervention.column_id = params[:column]
       @intervention.elevator_id = params[:elevator]
       @intervention.result = "Incomplete"  #  Default value
       @intervention.report = params[:report]
       @intervention.status = "Pending"   # Default value
       @intervention.save
       

    #    Zendesk Ticket creation
        # 1. config
       
            client = ZendeskAPI::Client.new do |config|
            config.url = 'https://rocketelevators8100.zendesk.com/api/v2'
            config.username = 'saadeddine.feki@gmail.com'
            config.token = ENV["zendesk_api"]
            end 
        # 2. intervention
        if @intervention.employee_id != nil
        @employee_name = Employee.find(params[:employee]).first_name
        @employee_last = Employee.find(params[:employee]).last_name
        signature = "#{@employee_name} #{@employee_last}"
        else
            signature = ""
        end

        ZendeskAPI::Ticket.create!(client, 
            :subject => "Intervention ticket author:  #{@intervention.author}  
            #{ firstname} #{lastname }",
            :requester => {"name": @current_user.email},
            :comment => { :value => "Author: [ID: #{@intervention.author}] #{ firstname} #{lastname }
            The customer [ID: #{@intervention.customer_id}] name: #{@company}
            Building [#{@intervention.building_id}] #{adressbuilding.number_and_street} #{adressbuilding.postal_code} #{adressbuilding.country}
            Battery [#{@intervention.battery_id}]
            Column [#{@intervention.column_id}]
            Elevator [#{@intervention.elevator_id}] 
            An intervention was created and associated to the employee : [#{@intervention.employee_id}]  #{signature}.
            The intervention report : 
            #{@intervention.report}
           Sincerely yours"},
            :submitter_id => @intervention.author,
            :type => "question",
            :priority => "urgent")


    # end Zendesk  
    if verify_recaptcha(model: @intervention) 
        respond_to do |f|            
                if @intervention.save  && user_signed_in?
                    f.html { redirect_to my_interventions_path, notice: 'Your intervention has been successfully register !' }          
                else
                    f.html { render :new }
                end
            end 
        else
            redirect_to intervention_path, flash: { error: "Please check Captcha !" }
              
        end
          
end


    def intervention_params
        params.permit( :employee_id, :customer_id, :building_id, :battery_id, :column_id, :elevator_id, :result, :report, :status)
    end
end