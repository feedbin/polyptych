polyptych
=========

A favicon stylesheet api.

Getting a Stylesheet
--------------------
Generate the sha1 of a concatenated sorted list of hostnames

```ruby
require 'digest/sha1'

hostnames = %w{daringfireball.net benubois.com}
# > ['daringfireball.net', 'benubois.com']

hostnames = hostnames.sort
# > ['benubois.com', 'daringfireball.net']

hostnames = hostnames.join
# > "benubois.comdaringfireball.net"

hash = Digest::SHA1.hexdigest(hostnames)
# > "9cf135321116c70e88b361409ea02cf75c46face"
```

Now that you have a hash you can get the stylesheet like

```ruby
require 'httparty'
HTTParty.get("http://polyptych.dev/panels/#{hash}.css")
```

or using curl

```shell
$ curl -v http://polyptych.dev/panels/9cf135321116c70e88b361409ea02cf75c46face.css
```

If no stylesheet is found a 404 will be returned. In which case you'll want to create a stylesheet

Creating a Stylesheet
---------------------

```ruby
require 'httparty'
require 'json'

result = HTTParty.post(
  'http://polyptych.dev/panels.json', 
  body: { 
    hostnames: ['benubois.com', 'daringfireball.net']
  }.to_json,
  headers: { 
    'Accept': 'application/json',
    'Content-Type': 'application/json'
  } 
)
```

Or using curl

```shell
$ curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d ' {"hostnames": ["benubois.com", "daringfireball.net"]}'  http://polyptych.dev/panels.json
```

The response should return 201 Created or 302 Found if it already exists.

The response should look like

```shell
* About to connect() to polyptych.dev port 80 (#0)
*   Trying 127.0.0.1...
* connected
* Connected to polyptych.dev (127.0.0.1) port 80 (#0)
> POST /panels.json HTTP/1.1
> User-Agent: curl/7.24.0 (x86_64-apple-darwin12.0) libcurl/7.24.0 OpenSSL/0.9.8r zlib/1.2.5
> Host: polyptych.dev
> Accept: application/json
> Content-type: application/json
> Content-Length: 54
> 
* upload completely sent off: 54 out of 54 bytes
< HTTP/1.1 302 Moved Temporarily
< Date: Fri, 09 Nov 2012 21:10:26 GMT
< Location: http://polyptych.dev/panels/9cf135321116c70e88b361409ea02cf75c46face.css
< Content-Type: application/json; charset=utf-8
< Cache-Control: max-age=2592000, public
< X-UA-Compatible: IE=Edge
< X-Request-Id: 518334c0827e8240b73e8f8405a4c731
< X-Runtime: 0.679689
< Transfer-Encoding: chunked
< 
* Connection #0 to host polyptych.dev left intact
{"name":"9cf135321116c70e88b361409ea02cf75c46face"}* Closing connection #0
```