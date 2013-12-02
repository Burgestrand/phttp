# PHTTP

Ever wanted to make some HTTP requests, and from the response expand out into
more HTTP requests?

```
$ gem install phttp
```

## Features

- Pure Ruby.
- Parallel HTTP requests, without using threads.
- Works on CRuby, JRuby, and Rubinius.
- SSL support.
- Request pipelining, automatic persistent connection.
- Multiple strategies for parallelizing HTTP requests.

## Example

```ruby
tree = PHTTP::Request.new(uri, method: :post, params: { "code" => code }).then do |response|
  headers = { "X-Api-Token" => response.json["access_token"] }

  users_info = %w[Kim Elin Micael].map do |user_name|
    PHTTP::Request.new(user_info_uri, query: { "name" => user_name }, headers: headers).then do |response|
      info = response.json
      PHTTP::Request.new(user_friends_uri, query: { "uid" => info["uid"] }, headers: headers).then do |response|
        { name: user_name, display_name: info["display_name"], friend_names: response.json }
      end
    end
  end

  PHTTP::Parallel.new(users_info).then do |users|
    users.map { |user| [user[:display_name], user[:friend_names]] }
  end
end

PHTTP.execute(tree).each do |name, friend_names|
  puts "#{name}: #{friend_names.join(", ")}"
end
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/phttp/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
