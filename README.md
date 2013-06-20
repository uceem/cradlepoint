# Cradlepointr

This is a gem that talks to Cradlepoint's Enterprise Cloud Manager \(ECM\).

In order to use this gem you will need a valid ECM username and password.


## Installation

Add this line to your application's Gemfile:

    gem 'cradlepointr'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cradlepointr

Note, in order to run the tests you will need to do the following:

    $ export ECM_USERNAME='<my_username>'
    $ export ECM_PASSWORD='<my_password>'

    # The ECM router id can be found at https://beta.cradlepointecm.com/
    $ export ECM_ROUTER_ID='<my_router_id_from_ecm>'

    $ rspec

## Usage

Getting router information:

```ruby
Cradlepointr::Router.get(my_router_id) # => Router's JSON blob.
Cradlepointr::Rouer.index              # => All the routers as a JSON array.
```

Getting net device information:

```ruby
Cradlepointr::NetDevice.get(my_router_id) # => Router's net_device info as JSON blob.
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
