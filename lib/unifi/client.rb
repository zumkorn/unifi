# ./lib/unifi/client.rb
require "unifi/client/vouchers"
require "unifi/client/sites"
require "unifi/client/guests"
require "unifi/client/wlan"
require "unifi/client/main"

module Unifi

  class Client
    include HTTParty
    include Unifi::Client::Vouchers
    include Unifi::Client::Sites
    include Unifi::Client::Guests
    include Unifi::Client::Wlan
    include Unifi::Client::Main

    format :json
    def initialize(options = {})
      options[:url] ||= ENV["UNIFI_URL"]
      self.class.base_uri "https://#{options[:url]}/api"
      @site = options[:site] || ENV["UNIFI_SITE"] || "default"
      @username = options[:username] || ENV["UNIFI_USERNAME"]
      @password = options[:password] || ENV["UNIFI_PASSWORD"]
      self.class.default_options.merge!(headers: { 'Content-Type': 'application/json',
                                                   'Accept': 'application/json' },
                                        verify: false)
      login
      self.class.default_options.merge!(headers: { 'Cookie': @cookies } )
    end

    def login
      response = self.class.post("/login",
                                 body: "{'username': '#{@username}', 'password': '#{@password}'}")
      @cookies = response.headers['set-cookie']
    end

    def logout
      self.class.get("/logout")
      @cookies = ''
    end

  end

end