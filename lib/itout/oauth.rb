require 'httparty'
require 'json'

module ITout
  module OAuth
    # implements OAuth per from http://developer.tout.com/apis/authentication

    # implements client_credentials access_token retrieval
    def client_auth()
      url = URI.join(@auth_site, @token_url).to_s
      body = {client_id: @client_id,
             client_secret: @client_secret,
             grant_type: "client_credentials"}
      #ITout.logger.info("ITout::OAuth   post-ing #{url} with params #{{body: body, headers: headers}}")
      response = HTTParty.send(:post, url, body: body, headers: headers)
      #ITout.logger.debug("ITout::OAuth   #{url} response: #{response.code} #{response.body}")

      if response.code == 200 and JSON.parse(response.body)["access_token"] != nil
        @access_token = JSON.parse(response.body)["access_token"]
      else
        raise "Client failed to get an auth token, response was: " + response.body
      end
    end

    # ToDo: add some param checking logic
    def password_auth(opts={})
      url = URI.join(@auth_site, @token_url).to_s
      body = {client_id: @client_id,
              client_secret: @client_secret,
              email: @email,
              password: @password,
              scope: "read write share",
              grant_type: "password"}.merge(opts)

      #ITout.logger.info("ITout::OAuth   post-ing #{url} with params #{{body: body, headers: headers}}")
      response = HTTParty.send(:post, url, body: body, headers: headers)
      #ITout.logger.debug("ITout::OAuth   #{url} response: #{response.code} #{response.body}")

      if response.code == 200 and JSON.parse(response.body)["access_token"] != nil
        @access_token = JSON.parse(response.body)["access_token"]
      else
        raise "Client failed to get an auth token, response was: " + response.body
      end
    end

    alias :user_auth :password_auth

    # ToDo: add autocreate_user, twitter, facebook, etc

  end
end
