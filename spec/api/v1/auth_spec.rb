require 'rails_helper'

RSpec.describe UrHouse::V1::Auth, type: :api do
  describe 'POST /api/v1/auth/signup' do
    
    it 'creates a new user' do
      
      post '/api/v1/auth/signup', params: {
        user: {
          email: 'test@example.com',
          password: 'password123',
          password_confirmation: 'password123'
        }
      }

      expect(response).to have_http_status(201)
      expect(JSON.parse(response.body)).to include('message' => 'Signup successful')
    end

    it 'fails to create a user with invalid data' do
      post '/api/v1/auth/signup', params: {
        user: {
          email: 'test@example.com',
          password: 'password123',
          password_confirmation: 'wrong_password'
        }
      }

      expect(response).to have_http_status(422)
      expect(JSON.parse(response.body)).to include('errors')
    end
  end

  describe 'POST /api/v1/auth/login' do
    let!(:user) { User.create(email: 'test@example.com', password: 'password123', password_confirmation: 'password123', role: 'user') }

    it 'logs in an existing user' do
      post '/api/v1/auth/login', params: {
        user: {
          email: 'test@example.com',
          password: 'password123'
        }
      }

      expect(response).to have_http_status(201)
      expect(JSON.parse(response.body)).to include('message' => 'Signin successful')
    end

    it 'fails to log in a user with invalid credentials' do
      post '/api/v1/auth/login', params: {
        user: {
          email: 'test@example.com',
          password: 'wrong_password'
        }
      }

      expect(response).to have_http_status(401)
      expect(JSON.parse(response.body)).to include('error' => 'Invalid email or password')
    end
  end
end
