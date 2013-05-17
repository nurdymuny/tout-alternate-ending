require_relative './collection'
require_relative './tout'

module ITout
  class Touts < Collection

    def klass
      ITout::Tout
    end

    def container_name
      'touts'
    end

    def member_name
      'tout'
    end

  end
end
