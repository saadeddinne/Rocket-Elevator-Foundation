class InterventionController < ApplicationController
  # check authentication
  before_action :authenticate_user!
  def index
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
            respond_to do |format|
                format.json {
                    render json: {columns: @columns}
                }
            end
        end
    end


    def new
      @intervention = Intervention.new
  end
  def intervention_params
    params.permit( :employee_id, :customer_id, :building_id, :battery_id, :column_id, :elevator_id, :result, :report, :status)
  end


end
