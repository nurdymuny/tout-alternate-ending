require 'itout/base'

module ITout
  class User < ITout::Base

    def likes
      ITout.client.retrieve_user_likes(self.uid)
    end

    def touts
      ITout.client.retrieve_user_touts(self.uid)
    end

    def followers
      ITout.client.retrieve_user_followers(self.uid)
    end

# the below methods require_relative acting on the behalf of users, which is not yet implemented
=begin
      def follow
        ITout.client.follow_user(self.uid)
      end

      def unfollow
        ITout.client.unfollow_user(self.uid)
      end
=end
  end
end
