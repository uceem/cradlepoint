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

__Note:__ in order to run the tests you will need to do the following:

    # These are required in order to run the tests, you can locate these
    # details at https://beta.cradlepointecm.com/
    $ export ECM_USERNAME='<my_username>'
    $ export ECM_PASSWORD='<my_password>'
    $ export ECM_ACCOUNT_ID='<my_account_id>'
    $ export ECM_ROUTER_ID='<my_router_id>'

    # Now you're ready to run the tests.
    $ rspec

## Usage

Getting router information:

```ruby
Cradlepointr::Router.get(my_router_id) # => Router's JSON blob.
Cradlepointr::Rouer.index              # => All the routers as a JSON array.
```

Getting net device information:

```ruby
router = Cradlepointr::NetDevice.new(my_router_id) # => Router object
Cradlepointr::NetDevice.new(router).get            # => Router's net_device info as JSON blob.
```

## More Information

http://dev.cradlepoint.com/

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
