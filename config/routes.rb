Rails.application.routes.draw do
  # root 'welcome#index'
  resources :tracks
  resources :playlists
  resources :playlist_tracks
  resources :media_types
  resources :invoices
  resources :invoice_lines
  resources :genres
  resources :films
  resources :film_categories
  resources :film_actors
  resources :employees
  resources :customers
  resources :categories
  resources :artists
  resources :albums
  resources :actors
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
