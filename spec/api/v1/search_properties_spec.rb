require 'rails_helper'

RSpec.describe UrHouse::V1::SearchProperties, type: :api do
  before do
    @property1 = Property.create(title: "Central Apartment", address: "Central St, Taipei", mrt: "Central MRT", number_of_rooms: 2, price_per_month: 60000)
    @property2 = Property.create(title: "Suburban House", address: "Suburb St, Taipei", mrt: "Suburb MRT", number_of_rooms: 3, price_per_month: 70000)
  end

  describe "post /api/v1/search_properties/search" do
    context "when searching by title" do
      it "returns properties matching the title" do
        post "/api/v1/search_properties/search", params: { search: { title: "Central" } }
        
        expect(response).to be_successful
        json = JSON.parse(response.body)
        expect(json.count).to eq(1)
        expect(json.first["title"]).to eq("Central Apartment")
      end
    end

    context "when searching by address" do
      it "returns properties matching the address" do
        post "/api/v1/search_properties/search", params: { search: { address: "Suburb St" } }
        expect(response).to be_successful
        json = JSON.parse(response.body)
        expect(json.count).to eq(1)
        expect(json.first["address"]).to include("Suburb St")
      end
    end

    context "when searching by MRT" do
      it "returns properties near the specified MRT station" do
        post "/api/v1/search_properties/search", params: { search: { mrt: "Suburb MRT" } }
        expect(response).to be_successful
        json = JSON.parse(response.body)
        expect(json.count).to eq(1)
        expect(json.first["mrt"]).to eq("Suburb MRT")
      end
    end

    context "when searching by number of rooms" do
      it "returns properties with the specified number of rooms" do
        post "/api/v1/search_properties/search", params: { search: { number_of_rooms: 3 } }
        expect(response).to be_successful
        json = JSON.parse(response.body)
        expect(json.count).to eq(1)
        expect(json.first["number_of_rooms"]).to eq(3)
      end
    end

    context "when searching by price per month" do
      it "returns properties matching the price" do
        post "/api/v1/search_properties/search", params: { search: { price_per_month: 70000 } }
        expect(response).to be_successful
        json = JSON.parse(response.body)
        expect(json.count).to eq(1)
        expect(json.first["price_per_month"]).to eq(70000)
      end
    end

    context "when combining multiple search criteria" do
      it "returns properties matching all criteria" do
        post "/api/v1/search_properties/search", params: { search: { title: "Central", mrt: "Central MRT", price_per_month: 60000 } }
        expect(response).to be_successful
        json = JSON.parse(response.body)
        expect(json.count).to eq(1)
        expect(json.first["title"]).to eq("Central Apartment")
      end
    end
  end
end
