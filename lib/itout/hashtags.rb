require_relative './collection'
require_relative './hashtag'

module ITout
  class Hashtags < Collection

    def klass
      ITout::Hashtag
    end

    def container_name
      'hashtags'
    end

    def member_name
      'hashtag'
    end

  end
end
