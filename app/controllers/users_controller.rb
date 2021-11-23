class UsersController < ApplicationController

    def show
        if session[:user_id]
            user = User.find(session[:user_id])
            render json: user, status: :ok
        else
            render json: {error: "Not Authorized"}, status: :unauthorized
        end
    end

    def create
        user = User.create(user_params)
        if user.password_confirmation == user.password && user.valid?
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: {error: "User not created"}, status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end
end
