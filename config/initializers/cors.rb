# config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'http://localhost:3001'  # Replace with the specific origin of your React frontend.
      resource '*', headers: :any, methods: [:get, :post, :put, :options]
    end
end
  