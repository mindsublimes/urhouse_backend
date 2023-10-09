require 'rails_helper'

RSpec.describe UrHouse::V1::FavoriteLists, type: :api do

  before do
    @property1 = Property.create(title: "Central Apartment", address: "Central St, Taipei", mrt: "Central MRT", number_of_rooms: 2, price_per_month: 60000)
    @property2 = Property.create(title: "Suburban House", address: "Suburb St, Taipei", mrt: "Suburb MRT", number_of_rooms: 3, price_per_month: 70000)
    @user = User.create(email: 'test@gmail.com', password: '123456', password_confirmation: '123456', role: 'admin')
    @header = { "Authorization" => @user.authentication_token }
    @favorite = FavoriteList.create(user_id: @user.id, property_id: @property2.id)
  end

  describe "POST /api/v1/favorite_lists" do
    context "when adding a property to favorites" do
      before { post "/api/v1/favorite_lists", params: { property_id: @property1.id }, headers: @header }

      it "adds the property to the user's favorite list" do
        expect(response).to be_successful
        expect(FavoriteList.where(user: @user, property: @property1).count).to eq(1)
        expect(JSON.parse(response.body)['message']).to eq('Property added to favorites')
      end

      # You can also add other negative test cases, like if a property is already in the favorites, etc.
    end
  end

  describe "GET /api/v1/favorite_lists" do
    
    context "when fetching favorite properties" do
      before { get "/api/v1/favorite_lists", headers: @header }

      it "returns all favorite properties of the user" do
        expect(response).to be_successful
        expect(JSON.parse(response.body).size).to eq(1)
      end
    end
  end
end
