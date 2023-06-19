require 'sinatra/base'
require 'json'
require_relative 'manager'

module Posts
  class API < Sinatra::Base
    def initialize(manager: Manager.new)
      @manager = manager
      super()
    end

    post '/posts' do
      post_data = JSON.parse(request.body.read)
      post = @manager.save(post_data)

      JSON.generate('id' => post.id)
    end

    get '/posts/:id' do
      post = @manager.find(params['id'])

      unless post
        status 404
      else
        JSON.generate(post)
      end
    end
  end
end
