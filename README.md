# README

Chinook Dataset, Ruby on Rails REST API example

# First-time Setup

- Using VS Code, and the "Remote Development" extension pack, use the `open folder in container` feature
- This will open the folder inside of a development container which comes with Ruby on Rails and PostgreSQL running
- Install `psql` on the Rails container by running `sudo apt update` then `sudo apt install postgresql-client`
  - (Rails database driver and `bundle exec db:` commands need this to work)
- Create a new API-only Rails 6 app with: `rails new . --database=postgresql --minimal --api`
- `config/environments/development.rb` ln59 is added because my OS is the Apple M1 chip and requires a different config.file_watcher; if an issue arises comment out ln59 and comment back in ln54.
- In `config/database.yaml`, modify the config so that the `default` connections work with local Docker PG:
  - ```yaml
    default: &default
      adapter: postgresql
      encoding: unicode
      pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
      username: postgres
      password: postgres
      host: db # Name of Docker service
      port: 5432
    ```
- Create the Rails starter databases:
  - ```sh
    bundle exec rails db:create
    ```
- Import the Chinook Dataset to the database, creating a `db/schema.rb`:
  - ```sh
    bundle exec rails db < chinook_postgres.sql
    ```
    - We can use the `seed_dump` gem to take existing data in our DB and dump it to `seeds.rb`-friendly format. To do that, we:
      - Add `seed_dump` to our gemfile `gem 'seed_dump'` 
      - Run the dump
        ```sh
        gem install seed_dump
        bundle exec rails db:seed:dump
        ```
- Use the `schema_to_scaffold` gem to take an existing `db/schema.rb`, and convert it to `rails g scaffold` command that create matching Models/Routes/Controllers, etc:
  - ```sh
    bundle exec rails db:schema:dump
    gem install schema_to_scaffold
    scaffold -p ./db/schema.rb
    ```
- Now this should spit out a serious of `rails g scaffold` commands which, when run, should create ActiveRecord Models, controllers, and JSON API routes that form full CRUD over the data in the database:
  - ```groovy
    rails generate scaffold Actor first_name:string last_name:string last_update:datetime --no-migration
    rails generate scaffold Album title:string artist:references --no-migration
    rails generate scaffold Artist name:string --no-migration
    rails generate scaffold Category name:string last_update:datetime --no-migration
    rails generate scaffold Customer first_name:string last_name:string company:string address:string city:string state:string country:string   postal_code:string phone:string fax:string email:string support_rep:references --no-migration
    rails generate scaffold Employee last_name:string first_name:string title:string reports_to:integer birth_date:datetime hire_date:datetime address:string   city:string state:string country:string postal_code:string phone:string fax:string email:string --no-migration
    rails generate scaffold FilmActor actor:references film:references last_update:datetime --no-migration
    rails generate scaffold FilmCategory film:references category:references last_update:datetime --no-migration
    rails generate scaffold Film title:string description:text release_year:integer language:references rental_duration:integer rental_rate:decimal   length:integer replacement_cost:decimal rating:text last_update:datetime special_features:text fulltext:tsvector --no-migration
    rails generate scaffold Genre name:string --no-migration
    rails generate scaffold InvoiceLine invoice:references track:references unit_price:decimal quantity:integer --no-migration
    rails generate scaffold Invoice customer:references invoice_date:datetime billing_address:string billing_city:string billing_state:string   billing_country:string billing_postal_code:string total:decimal --no-migration
    rails generate scaffold MediaType name:string --no-migration
    rails generate scaffold PlaylistTrack playlist:references track:references --no-migration
    rails generate scaffold Playlist name:string --no-migration
    rails generate scaffold Track name:string album:references media_type:references genre:references composer:string milliseconds:integer bytes:integer  unit_price:decimal --no-migration
    ```
- After running this, if we check `rails routes`, we can see:
  - ```ps1
        vscode ➜ /workspace (master ✗) $ rails routes
             Prefix Verb   URI Pattern                    Controller#Action
             tracks GET    /tracks(.:format)              tracks#index
                    POST   /tracks(.:format)              tracks#create
              track GET    /tracks/:id(.:format)          tracks#show
                    PATCH  /tracks/:id(.:format)          tracks#update
                    PUT    /tracks/:id(.:format)          tracks#update
                    DELETE /tracks/:id(.:format)          tracks#destroy
          playlists GET    /playlists(.:format)           playlists#index
                    POST   /playlists(.:format)           playlists#create
           playlist GET    /playlists/:id(.:format)       playlists#show
                    PATCH  /playlists/:id(.:format)       playlists#update
                    PUT    /playlists/:id(.:format)       playlists#update
                    DELETE /playlists/:id(.:format)       playlists#destroy
    playlist_tracks GET    /playlist_tracks(.:format)     playlist_tracks#index
                    POST   /playlist_tracks(.:format)     playlist_tracks#create
     playlist_track GET    /playlist_tracks/:id(.:format) playlist_tracks#show
                    PATCH  /playlist_tracks/:id(.:format) playlist_tracks#update
                    PUT    /playlist_tracks/:id(.:format) playlist_tracks#update
                    DELETE /playlist_tracks/:id(.:format) playlist_tracks#destroy
        media_types GET    /media_types(.:format)         media_types#index
                    POST   /media_types(.:format)         media_types#create
         media_type GET    /media_types/:id(.:format)     media_types#show
                    PATCH  /media_types/:id(.:format)     media_types#update
                    PUT    /media_types/:id(.:format)     media_types#update
                    DELETE /media_types/:id(.:format)     media_types#destroy
           invoices GET    /invoices(.:format)            invoices#index
                    POST   /invoices(.:format)            invoices#create
            invoice GET    /invoices/:id(.:format)        invoices#show
                    PATCH  /invoices/:id(.:format)        invoices#update
                    PUT    /invoices/:id(.:format)        invoices#update
                    DELETE /invoices/:id(.:format)        invoices#destroy
      invoice_lines GET    /invoice_lines(.:format)       invoice_lines#index
                    POST   /invoice_lines(.:format)       invoice_lines#create
       invoice_line GET    /invoice_lines/:id(.:format)   invoice_lines#show
                    PATCH  /invoice_lines/:id(.:format)   invoice_lines#update
                    PUT    /invoice_lines/:id(.:format)   invoice_lines#update
                    DELETE /invoice_lines/:id(.:format)   invoice_lines#destroy
             genres GET    /genres(.:format)              genres#index
                    POST   /genres(.:format)              genres#create
              genre GET    /genres/:id(.:format)          genres#show
                    PATCH  /genres/:id(.:format)          genres#update
                    PUT    /genres/:id(.:format)          genres#update
                    DELETE /genres/:id(.:format)          genres#destroy
              films GET    /films(.:format)               films#index
                    POST   /films(.:format)               films#create
               film GET    /films/:id(.:format)           films#show
                    PATCH  /films/:id(.:format)           films#update
                    PUT    /films/:id(.:format)           films#update
                    DELETE /films/:id(.:format)           films#destroy
    film_categories GET    /film_categories(.:format)     film_categories#index
                    POST   /film_categories(.:format)     film_categories#create
      film_category GET    /film_categories/:id(.:format) film_categories#show
                    PATCH  /film_categories/:id(.:format) film_categories#update
                    PUT    /film_categories/:id(.:format) film_categories#update
                    DELETE /film_categories/:id(.:format) film_categories#destroy
        film_actors GET    /film_actors(.:format)         film_actors#index
                    POST   /film_actors(.:format)         film_actors#create
         film_actor GET    /film_actors/:id(.:format)     film_actors#show
                    PATCH  /film_actors/:id(.:format)     film_actors#update
                    PUT    /film_actors/:id(.:format)     film_actors#update
                    DELETE /film_actors/:id(.:format)     film_actors#destroy
          employees GET    /employees(.:format)           employees#index
                    POST   /employees(.:format)           employees#create
           employee GET    /employees/:id(.:format)       employees#show
                    PATCH  /employees/:id(.:format)       employees#update
                    PUT    /employees/:id(.:format)       employees#update
                    DELETE /employees/:id(.:format)       employees#destroy
          customers GET    /customers(.:format)           customers#index
                    POST   /customers(.:format)           customers#create
           customer GET    /customers/:id(.:format)       customers#show
                    PATCH  /customers/:id(.:format)       customers#update
                    PUT    /customers/:id(.:format)       customers#update
                    DELETE /customers/:id(.:format)       customers#destroy
         categories GET    /categories(.:format)          categories#index
                    POST   /categories(.:format)          categories#create
           category GET    /categories/:id(.:format)      categories#show
                    PATCH  /categories/:id(.:format)      categories#update
                    PUT    /categories/:id(.:format)      categories#update
                    DELETE /categories/:id(.:format)      categories#destroy
            artists GET    /artists(.:format)             artists#index
                    POST   /artists(.:format)             artists#create
             artist GET    /artists/:id(.:format)         artists#show
                    PATCH  /artists/:id(.:format)         artists#update
                    PUT    /artists/:id(.:format)         artists#update
                    DELETE /artists/:id(.:format)         artists#destroy
             albums GET    /albums(.:format)              albums#index
                    POST   /albums(.:format)              albums#create
              album GET    /albums/:id(.:format)          albums#show
                    PATCH  /albums/:id(.:format)          albums#update
                    PUT    /albums/:id(.:format)          albums#update
                    DELETE /albums/:id(.:format)          albums#destroy
             actors GET    /actors(.:format)              actors#index
                    POST   /actors(.:format)              actors#create
              actor GET    /actors/:id(.:format)          actors#show
                    PATCH  /actors/:id(.:format)          actors#update
                    PUT    /actors/:id(.:format)          actors#update
                    DELETE /actors/:id(.:format)          actors#destroy
    ```
    - Making requests: 
    <a href='https://marketplace.visualstudio.com/items?itemName=humao.rest-client'>Rest Client VS Code Extension</a>

    - And this is essentially our REST API

    ## Resources
    <a href='https://github.com/frenesim/schema_to_scaffold'>Schema to Scaffold</a>


    <a href='https://docs.docker.com/samples/rails/'>
    Docker: Quickstart: Compose and Rails
    </a>


    <a href='https://github.com/evilmartians/terraforming-rails/issues/34'>
    M1 Chip 'Failed to initialize inotify' 
    </a>
    