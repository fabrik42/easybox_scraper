# Easybox Scraper

This is a little ruby script to fetch interesting information from a Vodafone Easybox 904 LTE.
I tested it with Firmware version XXX.XXX.

## Usage

`$ ruby easybox_scraper.rb 'YOURPASSWORD'`

This will print something like this:

```
Login successful
provider: XXXX
sim_pin: XXXX
sim_imsi: XXXXXXXXXXXXXXXX
apn_data: XXXX
apn_voice: XXXX
modem_firmware: XXXX
modem_imei: XXXX
connection_data: 1
connection_voice: 1
reception_percent: 62
```

## Return values

* `provider` Name of your provider (most likely Vodafone)
* `sim_pin` The PIN of your LTE enabled SIM card. 
* `sim_imsi` The IMSI number of your LTE enabled SIM card. 
* `apn_data` APN host name for data transfer.
* `apn_voice` APN host name for voice transfer. 
* `modem_firmware` Firmware number with release date of the LTE modem
* `modem_imei` IMEI number of the LTE modem
* `connection_data` 1 if data connection is established
* `connection_voice` 1 if voice connection is established 
* `reception_percent` Reception quality in percent.

## Use cases

### Adjusting the position of your router

In its official interfaces (touchscreen, web interface) the Easybox only provides 10 bars to show you the reception quality of your LTE connection.
By scraping the JavaScript variables of the webinterface, you are able to get a percentage value, so it's 10 times more accurate.

This can come in pretty handy, because even small adjustments of the router's position can have an impact on the quality of the LTE connection.

Just call your script in a loop to get real time updates on the reception quality:

`$ while [ true ]; do sleep 1; ruby easybox_scraper.rb 'YOURPASSWORD' | grep -e 'reception'; done`

![example screenshot](http://i.imgur.com/qCcifaj.png)

### Lost your PIN?

Don't worry. Vodafone sends your PIN and other sensitive information unencrypted over your local network, so you can easily grab it.

## Requirements

* Ruby 1.9

## License

The MIT License (MIT)

Copyright (c) 2013 Christian Bäuerlein

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
