module UrHouse
  module V1
    class FavoriteLists < UrHouse::Base
      version 'v1', using: :path
      format :json
      prefix :api

      before do
        authenticate_user!
      end

      resource :favorite_lists do
        desc 'Add a property to favorite list'
        params do
          requires :property_id, type: Integer, desc: 'Property ID to be added to favorite list'
        end
        post do
          favorite = FavoriteList.where(user_id: @current_user, property_id: params[:property_id]).first
          if favorite
            favorite.destroy
            { message: 'Property removed to favorites' }
          else
            favorite = FavoriteList.new(user: @current_user, property_id: params[:property_id])
            if favorite.save
              { message: 'Property added to favorites' }
            else
              error!({ errors: favorite.errors.full_messages }, 422)
            end
          end
        end

        desc 'Get all favorite properties of the user'
        get do
          favorites = @current_user.favorite_lists.includes(:property)
          favorites.map { |favorite| favorite.property }
        end
      end
    end
  end
end
