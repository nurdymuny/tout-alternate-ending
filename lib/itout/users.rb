require_relative './collection'
require_relative './user'

module ITout
  class Users < Collection

    def klass
      ITout::User
    end

    def container_name
      'users'
    end

    def member_name
      'user'
    end

  end
end
