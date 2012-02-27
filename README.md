# Harvested: A Ruby Harvest API

This is a Ruby wrapper for the [Harvest API](http://www.getharvest.com/).

## **[Harvested is looking for a new maintainer!!](https://github.com/zmoazeni/harvested/issues/23)**


## Installation

    gem install harvested

## Examples

    harvest = Harvest.client('yoursubdomain', 'yourusername', 'yourpassword')
    harvest.projects() # list out projects
    
    client = Harvest::Client.new(:name => "Billable Company LTD.")
    client = harvest.clients.create(client)
    harvest.clients.find(client.id) # returns a Harvest::Client

You can find more examples in `/examples` and in the documentation for Harvest::Base

## Hardy Client

The guys at Harvest built a great API, but there are always dangers in writing code that depends on an API. For example, HTTP Timeouts, Occasional Bad Gateways, and Rate Limiting issues need to be accounted for.

Using `Harvested#client` your code needs to handle all these situations. However you can also use `Harvested#hardy_client` which will retry errors and wait for Rate Limit resets.

    harvest = Harvest.hardy_client('yoursubdomain', 'yourusername', 'yourpassword')
    harvest.projects() # This will wait for the Rate Limit reset if you have gone over your limit

## Ruby support

Harvested's tests are currently passing for 1.8.7, 1.9.2, JRuby 1.6.2, and Rubinius

## Links

* [Harvested Documentation](http://rdoc.info/projects/zmoazeni/harvested)
* [Harvest API Documentation](http://www.getharvest.com/api)
* [Source Code for Harvested](http://github.com/zmoazeni/harvested)
* [Mailing List for Harvested](http://groups.google.com/group/harvested)

## How to Contribute

If you find what looks like a bug:

1. Check the GitHub issue tracker to see if anyone else has had the same issue.
http://github.com/zmoazeni/harvested/issues/
2. If you don’t see anything, create an issue with information on how to reproduce it.

If you want to contribute an enhancement or a fix:
 
1. Fork the project on github http://github.com/zmoazeni/harvested
2. Make your changes with tests
3. Commit the changes without messing with the Rakefile, VERSION, or history
4. Send me a pull request

Note on running tests: most specs run against a live Harvest account. To run the suite, sign up for a free trial account and fill out `/spec/support/harvest_credentials.yml` *(a sample harvest_credentials.example.yml has been included)*.

The tests use [VCR](https://github.com/myronmarston/vcr) to cache the test responses. This is a great boon for running the tests offline. While uncommon, sometimes the Harvest API will send an erroneous response and VCR will cache it, then subsequent runs will use the incorrect cached response. In order to ignore VCR you can run the specs by passing CACHE=false (e.g. `CACHE=false bundle rake spec`).

Using [rvm](https://rvm.beginrescueend.com/) you can run the tests against the popular ruby runtimes by running:
  
  ./spec/test_rubies

Each runtime needs to be installed in rvm along with the bundler gem.

## TODO

* Write Documentation
* Allow Timer Toggling

## Notes on Harvest Estimates

Estimates aren't currently supported due to lack of an API. If this opens up, harvested will include them.

## Copyright

Copyright (c) 2010-2011 Zach Moazeni. See LICENSE for details.
