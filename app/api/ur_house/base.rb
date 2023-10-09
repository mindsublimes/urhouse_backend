module UrHouse
  class Base < Grape::API
    helpers do
      def authenticate_user!
        token = headers['Authorization']&.split(' ')&.last
        user = User.find_by(authentication_token: token)
        
        error!('Unauthorized. Invalid or expired token.', 401) unless user
        # error!('Unauthorized. Not an admin user.', 401) unless user.admin?

        @current_user = user
      end
    end
    
    mount UrHouse::V1::Auth
    mount UrHouse::V1::Properties
    mount UrHouse::V1::FavoriteLists
    mount UrHouse::V1::SearchProperties
  end
end
