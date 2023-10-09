require 'rails_helper'

RSpec.describe UrHouse::V1::Properties, type: :api do

  before do
    # Create sample search_properties for testing
    @property1 = Property.create(title: "Central Apartment", address: "Central St, Taipei", mrt: "Central MRT", number_of_rooms: 2, price_per_month: 60000)
    @property2 = Property.create(title: "Suburban House", address: "Suburb St, Taipei", mrt: "Suburb MRT", number_of_rooms: 3, price_per_month: 70000)
    @user = User.create(email: 'test@gmail.com', password: '123456', password_confirmation: '123456', role: 'admin')
    @header = { "Authorization" => @user.authentication_token }
  end

  describe 'GET /api/v1/properties' do
    it 'returns a list of properties' do
      get '/api/v1/properties'
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).not_to be_empty
    end

    it 'returns properties with pagination' do
      get '/api/v1/properties', params: { page: 1, per_page: 5 }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).not_to be_empty
    end

    it 'handles errors when fetching properties' do
      allow(Property).to receive(:page).and_raise(StandardError.new('Test error'))
      get '/api/v1/properties'
      expect(response.status).to eq(500)
      expect(JSON.parse(response.body)['error']).to include("Failed to fetch properties. Test error")
    end
  end

  describe 'GET /api/v1/properties/:id' do
    it 'returns a specific property' do
      get "/api/v1/properties/#{@property1.id}", headers: @header
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['id']).to eq(@property1.id)
    end

    it 'handles errors when fetching a specific property without user' do
      get '/api/v1/properties/999'
      expect(response.status).to eq(401)
      expect(JSON.parse(response.body)['error']).to include("Unauthorized. Invalid or expired token.")
    end
  end

  describe 'POST /api/v1/properties' do
    it 'creates a new property' do
      property_params = {
            "property": {
              "title": "first dummy property",
              "price_per_month": "120",
              "address": "B2 10 PGHS lahore",
              "number_of_rooms": "10",
              "mrt": "MDES"
            }
        }
      post '/api/v1/properties', params: property_params, headers: @header
      expect(response.status).to eq(201)
      expect(JSON.parse(response.body)['title']).to eq("first dummy property")
    end

    it 'handles validation errors when creating a new property' do
      invalid_params = { title: 'Test Property' }  # Missing required fields
      post '/api/v1/properties', params: invalid_params, headers: @header
      expect(response.status).to eq(400)
      expect(JSON.parse(response.body)['error']).to include('property is missing')
    end
  end

  describe 'PUT /api/v1/properties/:id' do
    it 'updates a property' do
      property_params = {
            "property": {
              "title": "updated title",
            }
        }
      put "/api/v1/properties/#{@property1.id}", params: property_params, headers: @header
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['title']).to eq('updated title')
    end

    it 'handles validation errors when updating a property' do
      property_params = {
            "property": {
              "price_per_month": "NULL",
            }
        }
      put "/api/v1/properties/#{@property1.id}", params: property_params, headers: @header
      expect(response.status).to eq(400)
      expect(JSON.parse(response.body)['error']).to include('property[price_per_month] is invalid')
    end
  end

  describe 'DELETE /api/v1/properties/:id' do
    it 'deletes a property' do
      delete "/api/v1/properties/#{@property1.id}", headers: @header
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['message']).to eq('Property deleted successfully')
    end

    it 'handles errors when deleting a property' do
      delete '/api/v1/properties/999', headers: @header
      expect(response.status).to eq(404)
      expect(JSON.parse(response.body)['error']).to include('Property not found')
    end
  end
end
