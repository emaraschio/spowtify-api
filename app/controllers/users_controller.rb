class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create
  swagger_controller :users, "Users Sign Up"

  swagger_api :create do |api|
    summary "Sign Up"
    UsersController::add_common_params(api)
    response :ok
    response :unprocessable_entity
  end
  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  private

  def self.add_common_params(api) 
    api.param :form, "name", :string, :required, "Name"
    api.param :form, "email", :string, :required, "Email"
    api.param :form, "password", :string, :required, "Password"
    api.param :form, "password_confirmation", :string, :required, "Password confirmation"
  end

  def user_params
    params.permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
