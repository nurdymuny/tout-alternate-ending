require 'itout/base'

module ITout
  class Tout < ITout::Base
    
    def delete
      ITout.client.delete_tout(self.uid)
    end

    def like
      ITout.client.like_tout(self.uid)
    end

    def unlike
      ITout.client.unlike_tout(self.uid)
    end

=begin
    def share
      ITout.client.share_tout(self.uid)
    end

    def update_text
      ITout.client.update_tout_text(self.uid)
    end
=end

  end
end
