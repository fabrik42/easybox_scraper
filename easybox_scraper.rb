require 'net/http'

puts "Looping... Press ctrl-c to stop"

raise ArgumentError.new "Usage: ruby easybox_scraper.rb 'YOURPASSWORD'" unless ARGV[0]

EASYBOX_CONFIG = {
  base_url: 'http://easy.box',
  password: ARGV[0]
}

# login
login_uri = URI(EASYBOX_CONFIG[:base_url] + '/cgi-bin/login.exe')
login_response = Net::HTTP.post_form(login_uri, :pws => EASYBOX_CONFIG[:password])

session_cookie = login_response['Set-Cookie']

# check login success
if login_response.header['location'] == EASYBOX_CONFIG[:base_url] + "/loginerr.stm"
  raise "Login failed. Are you logged in from another device?"
end

login_redirect_uri = URI(login_response.header['location'])

req = Net::HTTP::Get.new(login_redirect_uri.path, {
  "Cookie" => session_cookie
})

login_redirect_response = Net::HTTP.start(login_redirect_uri.host, login_redirect_uri.port) do |http|
  http.request(req)
end

login_js_success = /top.location.href="\/index.stm";/

if login_js_success =~ login_redirect_response.body
  puts "Login successful"
else
  raise "Login failed!"
end

# get the status page and parse the body
def get_status(session_cookie)
  wan_info_uri = URI(EASYBOX_CONFIG[:base_url] + '/inc/status-and-support/lte-status.stm')

  req = Net::HTTP::Get.new(wan_info_uri.path, {
    "Cookie" => session_cookie
  })

  wan_info_response = Net::HTTP.start(wan_info_uri.host, wan_info_uri.port) do |http|
    http.request(req)
  end

  # now parse interesting information
  signal = wan_info_response.body.match(/^var\s+lteSignalPercent\s*=\s*'?\"?([^;\"']*)'?\"?;?$/ )[1]

  {
    signal: "~#{signal.to_i * 10}%"
  }
end

while true do
  status = get_status(session_cookie)[:signal]
  puts "[#{Time.now}] - #{status}"
  sleep 5
end
