module UrHouse
  module V1
    class Properties < UrHouse::Base
      version 'v1', using: :path
      format :json
      prefix :api

      before do
        authenticate_user! unless request.path == '/api/v1/properties' && request.get?
        find_property unless request.path == '/api/v1/properties'
      end

      resource :properties do
        desc 'Get all properties'
        params do
          optional :page, type: Integer, default: 1, desc: 'Page number'
          optional :per_page, type: Integer, default: 6, desc: 'Number of records per page'
        end
        get do
          begin
            properties = Property.page(params[:page]).per(params[:per_page])
            present properties
          rescue StandardError => e
            error!({ error: "Failed to fetch properties. #{e.message}" }, 500)
          end
        end

        desc 'Get a specific property'
        params do
          requires :id, type: Integer
        end
        get ':id' do
          begin
            present @property
          rescue ActiveRecord::RecordNotFound
            error!({ error: 'Property not found' }, 404)
          rescue StandardError => e
            error!({ error: "Failed to fetch the property. #{e.message}" }, 500)
          end
        end

        desc 'Create a new property'
        params do
          requires :property, type: Hash do
            requires :title, type: String
            requires :price_per_month, type: String
            requires :address, type: String
            requires :number_of_rooms, type: String
            requires :mrt, type: String
          end
        end
        post do
          begin
            property = Property.create!(permitted_params)
            present property
          rescue ActiveRecord::RecordInvalid => e
            error!({ error: "Validation failed: #{e.message}" }, 422)
          rescue StandardError => e
            error!({ error: "Failed to create the property. #{e.message}" }, 500)
          end
        end

        desc 'Update a property'
        params do
          requires :id, type: Integer
          requires :property, type: Hash do
            optional :title, type: String
            optional :price_per_month, type: Integer
            optional :address, type: String
            optional :number_of_rooms, type: Integer
            optional :mrt, type: String
          end
        end
        put ':id' do
          begin
            @property.update!(permitted_params)
            present @property
          rescue ActiveRecord::RecordNotFound
            error!({ error: 'Property not found' }, 404)
          rescue ActiveRecord::RecordInvalid => e
            error!({ error: "Validation failed: #{e.message}" }, 422)
          rescue StandardError => e
            error!({ error: "Failed to update the property. #{e.message}" }, 500)
          end
        end

        desc 'Delete a property'
        params do
          requires :id, type: Integer
        end
        delete ':id' do
          begin
            @property.destroy
            { message: 'Property deleted successfully' }
          rescue ActiveRecord::RecordNotFound
            error!({ error: 'Property not found' }, 404)
          rescue StandardError => e
            error!({ error: "Failed to delete the property. #{e.message}" }, 500)
          end
        end
      end

      helpers do
        def permitted_params
          declared(params, include_missing: false)[:property]
        end

        def find_property
          @property = Property.find params[:id]
        rescue ActiveRecord::RecordNotFound
          error!({ error: 'Property not found' }, 404)
        end
      end
    end
  end
end
