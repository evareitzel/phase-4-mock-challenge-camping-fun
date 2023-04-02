class ActivitiesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound,with: :render_not_found_response
  
    # GET /activities
    def index
      activities = Activity.all
      render json: activities
    end
  
    # DELETE /activities/:id
    def destroy
      activity = Activity.find(params[:id])
      activity.destroy
      head :no_content
    end
  
  
    private
  
    def render_not_found_response
      render json: { error: "Activity not found" }, status: :not_found
      # render json: { errors: ["Activity not found"]}
    end
  
  end
  