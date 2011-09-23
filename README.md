# Socialite

A Rails 3.1 engine that provides a User model with support for linking
multiple authorization accounts per user (linking). Current support for
Twitter, Facebook, Github and LinkedIn.

Additional authorizations can be added if they are supported by
the [OmniAuth](http://github.com/intridea/omniauth) project.

## Development

We are currently working on an initial release of Socialite. Once we
have a solid suite of tests in place, we will release an official 0.1.0
version to the public.

## Resources

* [Documentation](http://rdoc.info/github/jsmestad/socialite/master/frames)
* [Travis CI Project](http://travis-ci.org/#!/jsmestad/socialite)
* [Issue Tracker](https://github.com/jsmestad/socialite/issues)
* [Gem Releases](https://rubygems.org/gems/socialite)
* [Staging Testbed](http://socialite-gem.herokuapp.com)
* [Facebook Testbed](https://www.facebook.com/apps/application.php?id=281326728563029)

## Installation

To use Socialite in a Rails 3.1 application:

* Require it in the Gemfile: `gem 'socialite'`
* Install it by running `bundle`.
* Import migrations into the parent project with `rake
  socialite:install:migrations`
* Use the provided CSS by adding `//= require socialite` from your
  application's CSS manifest file

## History

This project began as a fork of [Tim Riley](http://openmonkey.com)'s
great Omnisocial plugin. The motivation for this fork is that I required
multiple authorizations for each account (linking support) and wanted a
proper Rails 3.1 Engine. Copyright of that original code (Omnisocial) is
under the MIT License. This project will be released under the Apache
2.0 License pending approval from Tim Riley and Icelab. Until then, I
will keep the MIT License.

# Omnisocial Contributers

* [Klaus Hartl](http://github.com/carhartl)
* [Stephen Aument](http://github.com/stephenaument)
* [Lucas Allan](http://github.com/lucasallan)
* [James Dumay](http://github.com/i386)
* [Pablo Dejuan](http://github.com/pdjota)
* [Chris Oliver](http://github.com/excid3)

## Omnisocial Copyright & License

OmniSocial is Copyright (c) 2010-2011 [Tim Riley](http://openmonkey.com/)
and [Icelab](http://icelab.com.au/), and is released under MIT License.
