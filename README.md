# OmniSocial

A Rails 3.1 engine for Twitter, Facebook and LinkedIn logins using [OmniAuth](http://github.com/intridea/omniauth)

## Installation

To use OmniSocial in a Rails 3.1 application:

1. Require it in the Gemfile: `gem 'omnisocial'`

2. Install it by running `bundle`.

3. Run `rails g omnisocial` to copy an initializer, database migration and some CSS and image assets into your base application directory.

4. Edit `config/initializers/omnisocial.rb` and include your application's Twitter and Facebook OAuth configuration.

5. Run `rake db:migrate` to create the user and login\_account tables.

6. Test that the logins work by accessing `/login` inside your application.

Some more detailed installation instructions are in the [project announcement article](http://icelab.com.au/articles/welcome-to-the-omnisocial/).

## Contributors

* [Klaus Hartl](http://github.com/carhartl)
* [Stephen Aument](http://github.com/stephenaument)
* [Lucas Allan](http://github.com/lucasallan)
* [James Dumay](http://github.com/i386)
* [Pablo Dejuan](http://github.com/pdjota)
* [Chris Oliver](http://github.com/excid3)
* [Justin Smestad](http://github.com/jsmestad)

## Copyright & License

OmniSocial is Copyright (c) 2010-2011 [Tim Riley](http://openmonkey.com/) and [Icelab](http://icelab.com.au/), and is released under MIT License.
