class SessionsController < ApplicationController
    def create
      user = User.find_by(username: params[:username])
  
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        render json: { id: user.id, username: user.username }
      else
        head :unauthorized
      end
    end
  
    def destroy
      session.delete(:user_id)
      head :no_content
    end
  end
  