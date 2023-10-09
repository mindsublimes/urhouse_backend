## URHouse Property Scraper
URHouse Property Scraper is a Ruby on Rails project that provides APIs and a rake task to load dummy property data from scraping.

### Prerequisites
1. Ruby
2. PostgreSQL
3. Bundler


### Clone the repository:
1. git clone https://github.com/sheharyar-ajmal/urhouse_backend.git
2. cd urhouse_backend

### Install dependencies:
1. bundle install
2. Setup the database: modify database.yml it to match your PostgreSQL configuration.

### Setup databasee:
1. rails db:create
2. rails db:migrate

### Load the dummy data:

Run the custom rake task you created to fetch property data:
1. rails scrape_urhouse:fetch_properties

### Start the server:
1. rails s

Visit http://localhost:3000 in your browser, and you should see the app running!

Usage
Once the server is running and the dummy data has been loaded, you can:
