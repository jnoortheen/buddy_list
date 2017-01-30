# User Resource controller
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  skip_before_action :set_current_user, :authenticate_request, only: [:create, :index]

  # GET /users
  def index
    @users = User.all
    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # Signup new user
  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render_error @user, :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    # allow updates from own user account
    if @user != @current_user
      render_unauthorised_error
    elsif @user.update_attributes(user_params)
      render json: @user, status: :ok
    else
      render_error @user, :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    # allow only deleting users own account
    if @user != @current_user
      render_unauthorised_error
    else
      @user.destroy
      head 204
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    user = User.new
    user.errors.add(:id, 'Wrong ID provided')
    render_error(user, :not_found)
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
