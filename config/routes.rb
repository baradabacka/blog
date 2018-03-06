require 'sidekiq/web'

Blog::Application.routes.draw do

  mount Base => '/'
  mount GrapeSwaggerRails::Engine => '/doc/api'

end
