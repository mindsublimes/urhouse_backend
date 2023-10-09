module UrHouse
  module V1
    class Auth < Grape::API
      version 'v1', using: :path
      format :json
      prefix :api

      resource :auth do
        desc 'Create a new user (signup)'
        params do
          requires :user, type: Hash do
            requires :email, type: String
            requires :password, type: String
            requires :password_confirmation, type: String
            optional :role, type: String, values: User.roles.keys, default: 'user'
          end
        end
        post 'signup' do
          user_params = declared(params, include_missing: false)[:user]
          user = User.new(user_params)

          if user.save
            { message: 'Signup successful', email: user.email, role: user.role, authentication_token: user.authentication_token }
          else
            error!({ errors: user.errors.full_messages }, 422)
          end
        end

        desc 'User login'
        params do
          requires :user, type: Hash do
            requires :email, type: String
            requires :password, type: String
          end
        end
        post 'login' do
          user_params = declared(params, include_missing: false)[:user]
          user = User.find_for_authentication(email: user_params[:email])

          if user && user.valid_password?(user_params[:password])
            { message: 'Signin successful', email: user.email, role: user.role, authentication_token: user.authentication_token }
          else
            error!('Invalid email or password', 401)
          end
        end
      end
    end
  end
end
