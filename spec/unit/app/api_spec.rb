require_relative '../../spec_helper.rb'
require_relative '../../../app/api'
require 'rack/test'
require_relative '../../support/json'

module Posts
  RSpec.describe API do
    include Rack::Test::Methods
    include JsonHelper

    def app
      API.new(manager: manager)
    end

    let(:manager) { instance_double('Posts::Manager') }

    let(:post_data) do
      { 'title' => 'Post Title', 'content' => 'Post Content' }
    end

    describe 'POST /posts' do
      context 'when the post is successfully saved' do
        let(:post_id) { 6 }
      
        before do
          allow(manager).to receive(:save).with(
            post_data
          ).and_return(Post.new(true, post_id))
        end

        it 'returns the post id' do
          post '/posts', JSON.generate(post_data)

          expect(parsed_response).to include('id' => post_id)
        end

        it 'responds with a 200 (OK)' do
          post '/posts', JSON.generate(post_data)

          expect(last_response.status).to eq(200)
        end
      end
    end

    describe 'GET /posts/:id' do
      let(:post_id) { '8' }

      context 'when post exists' do
        before do
          allow(manager).to receive(:find).with(
            post_id
          ).and_return(post_data)
        end

        it 'returns the post as JSON' do
          get "/posts/#{post_id}"
          expect(parsed_response).to eq(post_data)
        end

        it 'responds with a 200 (OK)' do
          get "/posts/#{post_id}"
          expect(last_response.status).to eq(200)
        end
      end

      context "when post doesn't exist" do
        before do
          allow(manager).to receive(:find).with(post_id).and_return(
            nil
          )
        end

        it 'responds with a 404 (Not Found)' do
          get "/posts/#{post_id}"
          expect(last_response.status).to eq(404)
        end
      end
    end
  end
end
