# ./lib/unifi/client/main.rb
module Unifi
  class Client

    module Main

      def list_dashboard
        response = self.class.get("/s/#{@site}/stat/dashboard")
        response.parsed_response
      end

      def list_clients(mac = '')
        response = self.class.get("/s/#{@site}/stat/sta/#{mac.delete(" :")}")
        response.parsed_response
      end

      def stat_client(mac = '')
        response = self.class.get("/s/#{@site}/stat/user/#{mac.delete(" :")}")
        response.parsed_response
      end

      def list_devices(mac = '')
        response = self.class.get("/s/#{@site}/stat/device/#{mac.delete(" :")}")
        response.parsed_response
      end

      def list_dynamicdns
        response = self.class.get("/s/#{@site}/list/dynamicdns")
        response.parsed_response
      end

      def list_events(options = {})
        body = { _sort: '-time', }
        body[:within] = options[:historyhours] || 720
        body[:_start] = options[:start] || 0
        body[:_limit] = options[:limit] || 3000
        response = self.class.get("/s/#{@site}/stat/event", { body: body.to_json })
        response.parsed_response
      end

      def list_extension
        response = self.class.get("/s/#{@site}/list/extension")
        response.parsed_response
      end

      def list_health
        response = self.class.get("/s/#{@site}/stat/health")
        response.parsed_response
      end

      def list_hotspotop
        response = self.class.get("/s/#{@site}/list/hotspotop")
        response.parsed_response
      end

      def list_networkconf
        response = self.class.get("/s/#{@site}/list/networkconf")
        response.parsed_response
      end

      def list_portconf
        response = self.class.get("/s/#{@site}/list/portconf")
        response.parsed_response
      end

      def list_portforward_stats
        response = self.class.get("/s/#{@site}/stat/portforward")
        response.parsed_response
      end

      def list_rogueaps(within = 24)
        body = { within: within }
        response = self.class.get("/s/#{@site}/stat/rogueap", { body: body.to_json })
        response.parsed_response
      end

      def list_self
        response = self.class.get("/s/#{@site}/self")
        response.parsed_response
      end

      def list_settings
        response = self.class.get("/s/#{@site}/get/setting")
        response.parsed_response
      end

      def list_usergroups
        response = self.class.get("/s/#{@site}/list/usergroup")
        response.parsed_response
      end

      def list_users
        response = self.class.get("/s/#{@site}/list/user")
        response.parsed_response
      end

      def list_current_channels
        response = self.class.get("/s/#{@site}/stat/current-channel")
        response.parsed_response
      end

      def list_dpi_stats
        response = self.class.get("/s/#{@site}/stat/dpi")
        response.parsed_response
      end

      def reconnect_sta(mac)
        body = { cmd: 'kick-sta', mac: mac.downcase }
        response = self.class.post("/s/#{@site}/cmd/sitemgr", { body: body.to_json })
        response.parsed_response
      end

      def rename_ap(ap_id, apname)
        body = { name: apname }
        response = self.class.get("/s/#{@site}/upd/device/#{ap_id.delete(" ")}", { body: body.to_json })
        response.parsed_response
      end

      def restart_ap(mac)
        body = { cmd: 'restart', mac: mac.downcase }
        response = self.class.get("/s/#{@site}/cmd/devmgr", { body: body.to_json })
        response.parsed_response
      end

      def stat_sta_sessions_latest(mac, limit = 5)
        body = { mac: mac.downcase, _limit: limit, _sort: '-assoc_time' }
        response = self.class.get("/s/#{@site}/stat/session", { body: body.to_json })
        response.parsed_response
      end

      def stat_sessions(start_time = nil, end_time = Time.now.to_i, mac = nil)
        body = { start: start_time ? start_time : end_time - (7 * 24 * 3600), end: end_time, type: 'all' }
        body[:mac] = mac if mac
        response = self.class.get("/s/#{@site}/stat/session", { body: body.to_json })
        response.parsed_response
      end

      def stat_payment(within = nil)
        response = self.class.get("/s/#{@site}/stat/payment#{within ? "?within=#{within}" : '' }")
        response.parsed_response
      end

      def stat_hourly_site(start_time = nil, end_time = Time.now.to_i * 1000)
        body = { start: start_time ? start_time : end_time - (7 * 24 * 3600 * 1000),
                 end: end_time,
                 attributes: ['bytes',
                              'wan-tx_bytes',
                              'wan-rx_bytes', 'wlan_bytes', 'num_sta', 'lan-num_sta', 'wlan-num_sta', 'time'] }
        response = self.class.get("/s/#{@site}/stat/report/hourly.site", { body: body.to_json })
        response.parsed_response
      end

      def stat_hourly_aps(start_time = nil, end_time = Time.now.to_i * 1000)
        body = { start: start_time ? start_time : end_time - (7 * 24 * 3600 * 1000),
                 end: end_time,
                 attrs: ['bytes', 'num_sta', 'time'] }
        response = self.class.get("/s/#{@site}/stat/report/hourly.ap", { body: body.to_json })
        response.parsed_response
      end

      def stat_daily_aps(start_time = nil, end_time = Time.now.to_i * 1000)
        body = { start: start_time ? start_time : end_time - (7 * 24 * 3600 * 1000),
                 end: end_time,
                 attrs: ['bytes', 'num_sta', 'time'] }
        response = self.class.get("/s/#{@site}/stat/report/daily.ap", { body: body.to_json })
        response.parsed_response
      end

      def stat_daily_site(start_time = nil, end_time = Time.now.to_i - (Time.now.to_i % 3600) * 1000)
        body = { start: start_time ? start_time : end_time - (52 * 7 * 24 * 3600 * 1000),
                 end: end_time,
                 attributes: ['bytes',
                              'wan-tx_bytes',
                              'wan-rx_bytes',
                              'wlan_bytes',
                              'num_sta',
                              'lan-num_sta',
                              'wlan-num_sta',
                              'time'] }
        response = self.class.get("/s/#{@site}/stat/report/daily.site", { body: body.to_json })
        response.parsed_response
      end

      def stat_auths(start_time = nil, end_time = Time.now.to_i)
        body = { start: start_time ? start_time : end_time - (7 * 24 * 3600),
                 end: end_time }
        response = self.class.get("/s/#{@site}/stat/authorization", { body: body.to_json })
        response.parsed_response
      end

      def stat_allusers(historyhours = 8760)
        body = { type: 'all', conn: 'all', within: historyhours}
        response = self.class.get("/s/#{@site}/stat/alluser", { body: body.to_json })
        response.parsed_response
      end

      def spectrum_scan_state(mac)
        response = self.class.get("/s/#{@site}/stat/spectrum-scan/#{mac.delete(': ')}")
        response.parsed_response
      end

      def spectrum_scan(mac)
        body = { cmd: 'spectrum-scan', mac: mac }
        response = self.class.post("/s/#{@site}/cmd/devmgr", { body: body.to_json })
        response.parsed_response
      end

      def upgrade_device_external(firmware_url, device_mac)
        body = { url: firmware_url, mac: device_mac }
        response = self.class.get("/s/#{@site}/cmd/devmgr/upgrade-external", { body: body.to_json })
        response.parsed_response
      end

      def upgrade_device(mac)
        body = { mac: mac }
        response = self.class.get("/s/#{@site}/cmd/devmgr/upgrade", { body: body.to_json })
        response.parsed_response
      end

      def site_leds(enable)
        body = { led_enabled: enable }
        response = self.class.post("/s/#{@site}/set/setting/mgmt", { body: body.to_json })
        response.parsed_response
      end

      def delete_usergroup(group_id)
        response = self.class.delete("/s/#{@site}/rest/usergroup/#{group_id}")
        response.parsed_response
      end

      def add_usergroup(group_name, group_dn = -1, group_up = -1)
        body = { name: group_name, qos_rate_max_down: group_dn, qos_rate_max_up: group_up }
        response = self.class.get("/s/#{@site}/rest/usergroup", { body: body.to_json })
        response.parsed_response
      end

      def edit_usergroup(group_id, site_id, group_name, group_dn = -1, group_up = -1)
        body = { _id: group_id,
                 name: group_name,
                 qos_rate_max_down: group_dn,
                 qos_rate_max_up: group_up,
                 site_id: site_id }
        response = self.class.put("/s/#{@site}/rest/usergroup/#{group_id}", { body: body.to_json })
        response.parsed_response
      end

      def set_usergroup(user_id, group_id)
        body = { usergroup_id: group_id }
        response = self.class.get("/s/#{@site}/upd/user/#{user_id}", { body: body.to_json })
        response.parsed_response
      end

      def set_sta_note(user_id, note = nil)
        body = { noted: note ? true : false }
        body[:note] = note if note
        response = self.class.get("/s/#{@site}/upd/user/#{user_id}", { body: body.to_json })
        response.parsed_response
      end

      def set_sta_name(user_id, name = '')
        body = { name: name }
        response = self.class.get("/s/#{@site}/upd/user/#{user_id}", { body: body.to_json })
        response.parsed_response
      end

      def locate_ap(mac, enable)
        body = { cmd: enable ? 'set-locate' : 'unset-locate', mac: mac.downcase }
        response = self.class.get("/s/#{@site}/cmd/devmgr", { body: body.to_json })
        response.parsed_response
      end

      def set_ap_radiosettings(ap_id, radio, channel, ht, tx_power_mode, tx_power)
        body = { radio_table: { radio: radio,
                                channel: channel,
                                ht: ht,
                                tx_power_mode: tx_power_mode,
                                tx_power: tx_power } }
      end

      def count_alarms(archived)
        response = self.class.get("/s/#{@site}/cnt/alarm#{archived ? '' : '?archived=false'}")
        response.parsed_response
      end

      def list_alarms
        response = self.class.get("/s/#{@site}/list/alarm")
        response.parsed_response
      end

      def list_admins
        body = { cmd: 'get-admins' }
        response = self.class.post("/s/#{@site}/cmd/sitemgr", { body: body.to_json })
        response.parsed_response
      end

      def led_override(device_id, override_mode)
        body = { led_override: override_mode }
        if ['off', 'on', 'default'].include?(override_mode)
          response = self.class.put("/s/#{@site}/rest/device/#{device_id}", { body: body.to_json })
          response.parsed_response
        else
          false
        end
      end

      def disable_ap(ap_id, disable)
        body = { disabled: disable }
        response = self.class.put("/s/#{@site}/rest/device/#{ap_id}", { body: body.to_json })
        response.parsed_response
      end
      
      def create_hotspotop(name, x_password, note = '')
        body = { name: name, x_password: x_password }
        body[:note] = note if note
        response = self.class.post("/s/#{@site}/rest/hotspotop", { body: body.to_json })
        response.parsed_response
      end

      def unblock_sta(mac)
        body = { cmd: 'unblock-sta', mac: mac.downcase }
        response = self.class.post("/s/#{@site}/cmd/stamgr", { body: body.to_json })
        response.parsed_response
      end
    end

    def block_sta(mac)
      body = { cmd: 'block-sta', mac: mac.downcase }
      response = self.class.post("/s/#{@site}/cmd/stamgr", { body: body.to_json })
      response.parsed_response
    end

    def adopt_device(mac)
      body = { cmd: 'adopt', mac: mac.downcase }
      response = self.class.post("/s/#{@site}/cmd/stamgr", { body: body.to_json })
      response.parsed_response
    end
  end
end