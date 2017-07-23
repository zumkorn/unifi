# Unifi
A Ruby interface to UniFi Controller API. Supported versions 5.x.x.
It's fork [Unifi Api Browser](https://github.com/malle-pietje/UniFi-API-browser/blob/master/phpapi/class.unifi.php) written in php.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'unifi'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install unifi

## Usage

Unifi gem needs url, site, login, password:

```ruby
client = Unifi::Client.new({url:"demo.ubnt.com", 
                            site: "default"
                            username:"superadmin", 
                            password:"superadmin"})
client.list_health
```
It will return something like that:
```json
{"data"=>[{"num_adopted"=>118, "num_ap"=>118, "num_disabled"=>0, 
"num_disconnected"=>0, "num_guest"=>0, "num_pending"=>0, 
"num_user"=>1180, "rx_bytes-r"=>504, "status"=>"ok", 
"subsystem"=>"wlan", "tx_bytes-r"=>535}...}
```

Create new voucher code:
```ruby
client.create_voucher({expire: 360, note: 'test-voucher'})
```
Get voucher code, need create_time in seconds:
```json
{"data"=>[{"create_time"=>1500804202}], "meta"=>{"rc"=>"ok"}}
```
Get voucher code, need create_time in second:
```ruby
client.stat_voucher(1500804202)
```
It will return something like that:
```json
{"data"=>[{"_id"=>"5974746a619469d63475866a", 
"admin_name"=>"sergey", "code"=>"9224743381", ...}], 
"meta"=>{"rc"=>"ok"}}
```
## Methods

* login
* logout
* add_site
* adopt_device
* authorize_guest
* unauthorize_guest
* block_sta
* unblock_sta
* create_hotspotop
* create_voucher
* delete_site
* disable_ap
* led_override
* list_admins
* list_alarms
* count_alarms
* list_devices
* list_clients
* list_dashboard
* list_dynamicdns
* list_events
* list_extension
* list_guests
* list_health
* list_hotspotop
* list_networkconf
* list_portconf
* list_portforward_stats
* list_portforwarding
* list_rogueaps
* list_self
* list_settings
* list_sites
* list_usergroups
* list_users
* list_wlan_groups
* list_wlanconf
* list_current_channels
* list_dpi_stats
* reconnect_sta
* rename_ap
* restart_ap
* revoke_voucher
* extend_guest_validity
* set_ap_radiosettings
* set_guestlogin_settings
* set_sta_name
* set_sta_note
* set_usergroup
* edit_usergroup
* add_usergroup
* delete_usergroup
* set_wlansettings
* create_wlan
* delete_wlan
* site_leds
* upgrade_device
* upgrade_device_external
* spectrum_scan
* spectrum_scan_state
* stat_allusers
* stat_auths
* stat_client
* stat_daily_site
* stat_daily_aps
* stat_hourly_aps
* stat_hourly_site
* stat_payment
* stat_sessions
* stat_sites
* stat_sta_sessions_latest
* stat_sysinfo
* stat_voucher

You can see the documentation for the methods[here](https://github.com/malle-pietje/UniFi-API-browser/blob/master/phpapi/class.unifi.php).

## Useful links

* [Original Unifi API Browser](https://github.com/malle-pietje/UniFi-API-browser)
* [API as published by Ubiquiti](https://www.ubnt.com/downloads/unifi/5.4.14/unifi_sh_api)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/zumkorn/unifi. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).