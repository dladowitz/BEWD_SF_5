# Use "rake routes" in the command line to see what this looks like!
Rails.application.routes.draw do

  # Default to the urls#new action so the first visit
  # they can create new shortened links!
  root "urls#new"

  # :index is used for displaying lists, so it is not included.
  resources :urls, only: [:show, :new, :create]

  # Naming custom routes with "as" is better for writing reusable code.
  # See url_features_spec.rb for an example.
  get '/:hash_code', to: 'urls#redirector', as: :url_redirector
  get '/:hash_code/preview', to: 'urls#preview', as: :url_preview
end
