# Controller Parent class
# methods available to all sub-classes
class ApplicationController < ActionController::API
  before_action :set_current_user, :authenticate_request

  private

  def set_current_user
    return unless request.headers['Authorization'].present?
    # decoded object
    dobj = JsonWebToken.decode(request.headers['Authorization'])
    # set current user
    @current_user = User.find(dobj[:user_id])
  end

  def authenticate_request
    # simply return if the current user is set
    return if @current_user
    render_unauthorised_error
  end

  def render_error(resource, status)
    render(json: resource,
           status: status,
           adapter: :json_api,
           serializer: ActiveModel::Serializer::ErrorSerializer)
  end

  def render_unauthorised_error
    render json: { error: 'Not Authorized' }, status: :unauthorized
  end
end
