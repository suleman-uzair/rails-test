class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
  end

  def create
    auth = request.env["omniauth.auth"]

    @user = User.find_or_create_by(provider: auth["provider"], uid: auth["uid"]) do |user|
      user.name         = auth["info"]["name"]
      user.email        = auth["info"]["email"]
      user.github_token = auth["credentials"]["token"]
    end

    session[:user_id] = @user.id
    redirect_to dashboard_path, notice: "Signed in with GitHub!"
  end

  def destroy
    terminate_session
    redirect_to new_session_path
  end
end
