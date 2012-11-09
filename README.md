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