class UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      session[:user_id] = user.id
      render json: user, status: :created
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    if logged_in?
      render json: current_user
    else
      render json: { error: 'Not authenticated' }, status: :unauthorized
    end
  end

  def me
    if logged_in?
      render json: current_user
    else
      render json: { error: 'Not authenticated' }, status: :unauthorized
    end
  end

  private

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def user_params
    params.permit(:username, :password, :password_confirmation)
  end
end
