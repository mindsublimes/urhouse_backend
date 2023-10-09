module UrHouse
  module V1
    class SearchProperties < Grape::API
      version 'v1', using: :path
      format :json
      prefix :api

      resource :search_properties do
        desc 'Search for properties'
        params do
          optional :search, type: Hash do
            optional :title, type: String, desc: 'Title of the property'
            optional :price_per_month, type: Integer, desc: 'Price per month'
            optional :address, type: String, desc: 'Address of the property'
            optional :number_of_rooms, type: Integer, desc: 'Number of rooms'
            optional :mrt, type: String, desc: 'MRT station related to the property'
          end
          optional :page, type: Integer, default: 1, desc: 'Page number'
          optional :per_page, type: Integer, default: 6, desc: 'Number of records per page'
        end

        post 'search' do
          search_params = declared(params, include_missing: false)[:search] || {}

          properties = Property.page(params[:page]).per(params[:per_page])
          conditions = []
          values = {}

          if search_params[:title]
            conditions << "title ILIKE :title"
            values[:title] = "%#{search_params[:title]}%"
          end

          if search_params[:price_per_month]
            conditions << "price_per_month = :price_per_month"
            values[:price_per_month] = search_params[:price_per_month]
          end

          if search_params[:address]
            conditions << "address ILIKE :address"
            values[:address] = "%#{search_params[:address]}%"
          end

          if search_params[:number_of_rooms]
            conditions << "number_of_rooms = :number_of_rooms"
            values[:number_of_rooms] = search_params[:number_of_rooms]
          end

          if search_params[:mrt]
            conditions << "mrt ILIKE :mrt"
            values[:mrt] = "%#{search_params[:mrt]}%"
          end
          
          properties.where(conditions.join(' AND '), values)
        end
      end
    end
  end
end
