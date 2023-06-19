module Posts
  module JsonHelper
    def parsed_response
      JSON.parse(last_response.body)
    end
  end
end
