require 'net/http'

raise ArgumentError.new "Usage: ruby easybox_scraper.rb 'YOURPASSWORD'" unless ARGV[0]

# Protip:
# With this script, you get much better information about your reception than using the
# built in tools. Call this in your console (bash) to get reception updates every second.
# Comes in very handy when you're looking for the best place for your easybox.
#
# $ while [ true ]; do sleep 1; ruby easybox_scraper.rb 'YOURPASSWORD' | grep -e 'reception'; done

EASYBOX_CONFIG = {
  base_url: 'http://easy.box',
  password: ARGV[0]
}

# login
login_uri = URI(EASYBOX_CONFIG[:base_url] + '/cgi-bin/login.exe')
login_response = Net::HTTP.post_form(login_uri, :pws => EASYBOX_CONFIG[:password])

# check login success
if login_response.header['location'] == EASYBOX_CONFIG[:base_url] + "/loginerr.stm"
  raise "Login failed. Are you logged in from another device?"
end

login_redirect_uri = URI(login_response.header['location'])
login_redirect_response = Net::HTTP.get_response(login_redirect_uri)

login_js_success = /setTimeout\('top.location.href="\/index.stm";', 0\);/

if login_js_success =~ login_redirect_response.body
  puts "Login successful"
else
  raise "Login failed!"
end

# get the status page

wan_info_uri = URI(EASYBOX_CONFIG[:base_url] + '/wan_lte.stm')
wan_info_response = Net::HTTP.get_response(wan_info_uri)


# now parse interesting information

result = {}
js_var_regex = ->(js_var){ Regexp.new "^var\s+#{js_var}\s*=\s*'?\"?([^;\"']*)'?\"?;?$" }

{
  provider:              js_var_regex.call("lte_provider_long"),
  sim_pin:               js_var_regex.call("wan_lte_pin"),
  sim_imsi:              js_var_regex.call("lteSIM_IMSI"),
  apn_data:              js_var_regex.call("wan_lte_apn"),
  apn_voice:             js_var_regex.call("wan_lte_apn_vo"),
  modem_firmware:        js_var_regex.call("lteModemFWVersion"),
  modem_imei:            js_var_regex.call("lteModemIMEI"),
  connection_data:       js_var_regex.call("lte_data_conn"),
  connection_voice:      js_var_regex.call("lte_voice_conn"),
  status:                js_var_regex.call("lteStatus")
}.each do |name, regex|
  result[name] = wan_info_response.body.match(regex)[1]
end

result[:reception_percent] = result.delete(:status).match(/\(([0-9]+)%\)/)[1]

result.each do |key, value|
  puts "#{key}: #{value}"
end