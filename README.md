# Easybox Scraper

This is a little ruby script to fetch interesting information from a Vodafone Easybox 904 LTE.
I tested it with the firmware version AT904L-03.07.

For scraping older Easybox firmware (which exposes much more information) look here: [AT904L-01.07](https://github.com/fabrik42/easybox_scraper/tree/AT904L-01.07)

## Usage

`$ ruby easybox_scraper.rb 'YOURPASSWORD'`

This will watch the perception of your LTE connection:

```
Call ctrl-c to stop
Login successful
[2014-01-04 14:00:59 +0100] - ~50%
[2014-01-04 14:01:02 +0100] - ~50%
[2014-01-04 14:01:04 +0100] - ~50%
[2014-01-04 14:01:07 +0100] - ~50%
[2014-01-04 14:01:15 +0100] - ~50%
```

## Use cases

### Adjusting the position of your router

This can come in pretty handy, because even small adjustments of the router's position can have an impact on the quality of the LTE connection.

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
