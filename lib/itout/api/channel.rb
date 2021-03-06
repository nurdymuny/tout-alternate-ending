require_relative '../channel'
require_relative '../users'
require_relative '../touts'

module ITout
  module API
    module Channel

      # implements http://developer.tout.com/api/channel-api/apimethod/retrieve-channel
      def retrieve_channel(uid)
        response = get("channels/#{uid}")
        ITout::Channel.new(JSON.parse(response.body)["channel"])
      end

      # implements http://developer.tout.com/api/channel-api/apimethod/retrieve-channel-users
      def retrieve_channel_users(uid, order=nil, per_page=nil, page=nil)
        response = get("channels/#{uid}/users", query: {order: order, per_page: per_page, page: page})
        ITout::Users.new.from_response(response)
      end

      # implements http://developer.tout.com/api/channel-api/apimethod/retrieve-channel-touts
      def retrieve_channel_touts(uid, order=nil, per_page=nil, page=nil)
        response = get("channels/#{uid}/touts", query: {order: order, per_page: per_page, page: page})
        ITout::Touts.new.from_response(response)
      end

    end
  end
end
