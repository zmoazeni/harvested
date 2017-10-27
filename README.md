# Harvested is feature frozen and will not accept new feature additions. It will not support the V2 API. #

For more information about the reasons for that decision, please read https://github.com/zmoazeni/harvested/issues/98

# Harvested: A Ruby Harvest API

This is a Ruby wrapper for the [Harvest API](http://www.getharvest.com/api).

## Installation

    gem install harvested

## Examples

```ruby
harvest = Harvest.client(subdomain: 'yoursubdomain', username: 'yourusername', password: 'yourpassword')
harvest.projects.all   # list out projects

client = Harvest::Client.new(:name => "Billable Company LTD.")
client = harvest.clients.create(client)
harvest.clients.find(client.id) # returns a Harvest::Client
```

You can also pass query options in as the last parameter on any object's `all` finder
method, for example to find all the projects for client ID 12345:

```ruby
harvest = Harvest.client(subdomain: 'yoursubdomain', username: 'yourusername', password: 'yourpassword')
harvest.projects.all(nil, :client => 12345)
```

Note: the first parameter is a User ID field that is optional, but needs to be specified
as nil if not included.

You can pass in any hash of query attributes you wish as per the
[Harvest API](http://www.getharvest.com/api) page.

You can find more examples in `/examples` and in the documentation for Harvest::Base

## Permissions

For most operations you need to be an Admin on the Harvest account. You can do a few select things as a normal user or a project manager, but you will likely get errors.

## Hardy Client

The team at Harvest built a great API, but there are always dangers in writing code that depends on an API. For example: HTTP Timeouts, Occasional Bad Gateways, and Rate Limiting issues need to be accounted for.

Using `Harvested#client` your code needs to handle all these situations. However you can also use `Harvested#hardy_client` which will retry errors and wait for Rate Limit resets.

```ruby
harvest = Harvest.hardy_client(subdomain: 'yoursubdomain', username: 'yourusername', password: 'yourpassword')
harvest.projects.all   # This will wait for the Rate Limit reset if you have gone over your limit
```

## Ruby support

Harvested's tests currently support Ruby version 2.0+

## Links

* [Harvested Documentation](http://rdoc.info/projects/zmoazeni/harvested)
* [Harvest API Documentation](http://www.getharvest.com/api)
* [Source Code for Harvested](http://github.com/zmoazeni/harvested)

