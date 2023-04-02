# 04/04/2023 | 11AM - 12:35PM (1h 35m)

$ rails g resource Camper name age:integer --no-test-framework
$ rails g resource Activity name difficulty:integer --no-test-framework
$ rails g resource Signup time:integer camper:belongs_to activity:belongs_to --no-test-framework

# add model relationships
$ rails db:migrate db:seed
# add model validations

# define routes
# add controller actions
  # GET /campers
  # GET /campers/:id 
    # render json: camper, serializer: CamperActivitiesSerializer
  # POST /campers

  # GET /activities
  # DELETE /activities/:id

  # POST /signups
    # render json: signup.activity, status: :created


# add serializers defining JSON data
  $ rails g serializer Camper
  $ rails g serializer Activity  
  $ rails g serializer Signup 

  $ rails g serializer camper_activities
    # attributes :id, :name, :age, :activities


## Draft 1 Notes
resources :activities, only: [:index, :destroy]
# get '/activities', to: 'activities#index'
# delete '/activities', to: 'activities#destroy'

# Camper 
# draft 1
def create 
  camper = Camper.create(name: params[:name], age: params[:age])
  if camper.valid?
    render json: camper, status: :created
  else
    # error messages not wkg
    render json: { errors: ["validation errors"] }, status: :unprocessable_entity
  end
end

# draft 2
def create 
  camper = Camper.create!(camper_params)
  render json: camper, status: :created
rescue ActiveRecord::RecordInvalid => invalid
  render json: { errors: invalid.record.errors }, status: :unprocessable_entity
end

## signup_controller.rb

# draft 1
  # POST /signups
  def create
    signup = Signup.create(
      time: params[:time], 
      camper_id: params[:camper_id], 
      activity_id: params[:activity_id]
    )
    if signup
      render json: signup
    else
      # make serializer for data (:id, :name, :difficulty)
      render json: {} errors: ["validation errors"], status: :unprocessable_entity
    end
  end

  # draft 2 - returns nested data (getting there)
    # POST /signups
    def create
      signup = Signup.create!(signup_params)
        render json: signup.to_json(include: [activity: { only: [:id, :name, :difficulty] }]), status: :created
        # make serializer for data (:id, :name, :difficulty)
        # byebug
    end
  