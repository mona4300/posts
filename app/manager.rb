require_relative '../config/sequel'

module Posts
  Post = Struct.new(:success?, :id)

  class Manager
    def save(post)
      DB[:posts].insert(post)
      id = DB[:posts].max(:id)
      Post.new(true, id)
    end

    def find(id)
      DB[:posts].first(id: id)
    end
  end
end
