require_relative '../../../app/manager'
require_relative '../../spec_helper.rb'

module Posts
  RSpec.describe Post, :aggregate_failures, :db do
    let(:manager) { Manager.new }
    let(:post_data) do
    	{ title: 'Post Title', content: 'Post Content' }
    end

    describe '#save' do
      it 'successfully saves the post in the DB' do
        post = manager.save(post_data)

        expect(post).to be_success
        expect(DB[:posts].all).to match [
          a_hash_including(
            id: post.id,
            title: post_data[:title],
            content: post_data[:content]
          )
        ]
      end
    end

    describe '#find' do
      it 'returns the post for the provided id' do
        post = manager.save(post_data)

        expect(manager.find(post.id)).to match(
          a_hash_including(
            id: post.id,
            title: post_data[:title],
            content: post_data[:content]
          )
        )
      end

      it 'returns nil when the post doesn\'t exist' do
        expect(manager.find(100)).to eq(nil)
      end
    end
  end
end
