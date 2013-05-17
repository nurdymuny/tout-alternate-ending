require_relative '../touts'
require_relative '../user'
require_relative '../users'
require 'json'

module ITout
  module API
    module Users
      # implements http://developer.tout.com/api-overview/users-api
      # mixed in to a Client instance, the self passed to response objects is that instance

      # implements http://developer.tout.com/api/users-api/apimethod/retrieve-user
      # returns ITout::User instance
      def retrieve_user(uid)
        response = get("/api/v1/users/#{uid}")
        ITout::User.new.from_response(response)
      end

      # implements http://developer.tout.com/api/users-api/apimethod/retrieve-list-touts-liked-user
      # returns Array of ITout::Tout instances
      def retrieve_user_likes(uid, order=nil, per_page=nil, page=nil)
        response = get("/api/v1/users/#{uid}/likes", query: {order: order, per_page: per_page, page: page})
        ITout::Touts.new.from_response(response)
      end

      # implements http://developer.tout.com/api/users-api/apimethod/retrieve-users-touts
      # return Array of ITout::Tout instances
      def retrieve_user_touts(uid, order=nil, per_page=nil, page=nil)
        response = get("/api/v1/users/#{uid}/touts", query: {order: order, per_page: per_page, page: page})
        ITout::Touts.new.from_response(response)
      end

      # implements http://developer.tout.com/api/users-api/apimethod/retrieve-list-users-follow-user
      # returns Array of ITout::User instances
      def retrieve_user_followers(uid, order=nil, per_page=nil, page=nil)
        response = get("/api/v1/users/#{uid}/followers", query: {order: order, per_page: per_page, page: page})
        ITout::Users.new.from_response(response)
      end

      def retrieve_user_following(uid, order=nil, per_page=nil, page=nil)
        response = get("/api/v1/users/#{uid}/following", query: {order: order, per_page: per_page, page: page})
        ITout::Users.new.from_response(response)
      end

      # implements http://developer.tout.com/api/users-api/apimethod/follow-user
      def follow_user(uid)
        post("/api/v1/users/#{uid}/follows")
      end

      # implements http://developer.tout.com/api/users-api/apimethod/unfollow-user
      def unfollow_user(uid)
        delete("/api/v1/users/#{uid}/follows")
      end

    end
  end
end
