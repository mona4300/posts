require 'rack/test'
require 'json'
require_relative '../../spec_helper.rb'
require_relative '../../../app/api'
require_relative '../../support/json'

module Posts
  RSpec.describe 'Post Manager API', :db do
    include Rack::Test::Methods
    include JsonHelper

    def app
      Posts::API.new
    end

    it 'creates and fetches posts' do
      post_data = {
        'title' => 'Post Title', 'content' => 'Post Content'
      }
      
      post '/posts', JSON.generate(post_data)
      expect(last_response.status).to eq(200)

      result = parsed_response
      expect(result).to include('id' => a_kind_of(Integer))
      
      post_id = result['id']
      get "/posts/#{post_id}"
      expect(last_response.status).to eq(200)

      expect(parsed_response).to match(
        post_data.merge 'id' => post_id
      )
    end
  end
end
