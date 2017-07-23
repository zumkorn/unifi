# ./lib/unifi/client/wlan.rb
module Unifi
  class Client

    module Wlan

      def delete_wlan(wlan_id)
        body = {}
        response = self.class.post("/s/#{@site}/del/wlanconf/#{wlan_id}", { body: body.to_json })
        response.parsed_response
      end

      def create_wlan(name,
                      x_passphrase,
                      usergroup_id,
                      wlangroup_id,
                      enabled = true,
                      hide_ssid = false,
                      is_guest = false,
                      security = 'open',
                      wpa_mode = 'wpa2',
                      wpa_enc = 'ccmp',
                      vlan_enabled = false,
                      vlan = null,
                      uapsd_enabled = false,
                      schedule_enabled = false,
                      schedule = [])
        body = { name: name,
                 x_passphrase: x_passphrase,
                 usergroup_id: usergroup_id,
                 wlangroup_id: wlangroup_id,
                 enabled: enabled,
                 hide_ssid: hide_ssid,
                 is_guest: is_guest,
                 security: security,
                 wpa_mode: wpa_mode,
                 wpa_enc: wpa_enc,
                 vlan_enabled: vlan_enabled,
                 uapsd_enabled: uapsd_enabled,
                 schedule_enabled: schedule_enabled,
                 schedule: schedule }
        body[:vlan] = vlan if vlan && vlan_enabled
        response = self.class.get("/s/#{@site}/add/wlanconf", { body: body.to_json })
        response.parsed_response
      end

      def set_wlansettings(wlan_id, x_passphrase, name = '')
        body = {}
        body[:x_passphrase] = x_passphrase if x_passphrase
        body[:name] = name if name
        response = self.class.get("/s/#{@site}/upd/wlanconf/#{wlan_id}", { body: body.to_json })
        response.parsed_response
      end

      def list_wlan_groups
        response = self.class.get("/s/#{@site}/list/wlangroup")
        response.parsed_response
      end

      def list_wlanconf
        response = self.class.get("/s/#{@site}/list/wlanconf")
        response.parsed_response
      end
      
    end

  end
end