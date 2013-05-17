require 'hashie'

module ITout
  class Base < Hashie::Mash

    def from_response(response)
      initialize(parse(response))
    end

    def parse(response)
      JSON.parse(response.body)[klass_name]
    end

    def klass_name
      self.class.name.downcase.gsub('itout::', '')
    end

  end
end


