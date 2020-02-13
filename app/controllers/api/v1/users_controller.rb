# frozen_string_literal: true

module Api
  module V1
    # controller for User
    class UsersController < ActionController::API
      before_action :set_user, only: %i[show update destroy]
      before_action :authenticate_user

      def current
        render json: current_user.as_json(only: %i(id email))
      end

      def index
        @users = User.all

        render json: @users
      end

      def show
        render json: @user
      end

      def create
        @user = User.new(user_params)

        if @user.save
          render json: @user, status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def update
        if @user.update(user_params)
          render json: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @user.destroy
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:email, :username, :is_admin)
      end
    end
  end
end
