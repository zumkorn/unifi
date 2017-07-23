# ./lib/unifi/client/guests.rb
module Unifi
  class Client

    module Guests

      def list_guests(within = 8760)
        body = { within: within }
        response = self.class.get("/s/#{@site}/stat/guest", { body: body.to_json })
        response.parsed_response
      end

      def set_guestlogin_settings(portal_enabled,
                                  portal_customized,
                                  redirect_enabled,
                                  redirect_url,
                                  x_password,
                                  expire_number,
                                  expire_unit,
                                  site_id)
        body = { portal_enabled: portal_enabled,
                 portal_customized: portal_customized,
                 redirect_enabled: redirect_enabled,
                 redirect_url: redirect_url,
                 x_password: x_password,
                 expire_number: expire_number,
                 expire_unit: expire_unit,
                 site_id: site_id}
        response = self.class.get("/s/#{@site}/set/setting/guest_access", { body: body.to_json })
        response.parsed_response
      end

      def extend_guest_validity(guest_id)
        body = { id: guest_id, cmd: 'extend' }
        response = self.class.get("/s/#{@site}/cmd/hotspot", { body: body.to_json })
        response.parsed_response
      end

      def unauthorize_guest(mac)
        body = { cmd: 'unauthorize-guest', mac: mac.downcase }
        response = self.class.post("/s/#{@site}/cmd/stamgr", { body: body.to_json })
        response.parsed_response
      end

      def authorize_guest(mac, minutes, up = nil, down = nil, mbytes = nil, ap_mac = nil)
        body = { cmd: 'authorize-guest', mac: mac.downcase, minutes: minutes }
        body[:up] = up if up
        body[:down] = down if down
        body[:bytes] = mbytes if mbytes
        body[:ap_mac] = ap_mac if ap_mac
        response = self.class.post("/s/#{@site}/cmd/stamgr", { body: body.to_json })
        response.parsed_response
      end

    end

  end
end