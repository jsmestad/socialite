# Socialite

This is an opinionated Rails 3.1 mountable engine provides your application with
support for managing multiple OAuth providers per User.

## Why make this?

Every site I have built in the past couple years has required implementing
authentication support for Users. Now this was simple enough when it was only
**one** provider (in my case, "Login with Facebook"), but more often then not
it evolved into "Login with `<insert_oauth_provider>`".

Now OmniAuth has some [good write-ups](https://github.com/intridea/omniauth/wiki/Managing-Multiple-Providers)
on handling multiple providers, but it lacked any support for restricting a user
to one identity per provider. Socialite aims to solve this and while enforcing
every user to have a Basic Authentication identity as a fall-back in case of
password recovery.

## What makes this unique?

1. Every User can only have one identity per supported provider
  * Example: User can have only 1 linked Facebook Identity at any given time
2. Every User must have an basic-auth identity
  * Example: User signs up through Facebook, but unlinks it.
    Enforcing a local basic auth mechanism aids account recovery.
3. Supports any provider strategy in the OmniAuth project.

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
* Use the provided CSS by adding `//= require socialite` from your
  application's CSS manifest file

## History

This project began as a fork of [Tim Riley](http://openmonkey.com)'s
great Omnisocial plugin. The motivation for this fork is that I required
multiple authorizations for each account (linking support) and wanted a
proper mountable Rails 3.1 Engine.

## Copyright & License

Socialite is Copyright (c) 2011- 2013 Justin Smestad. All Rights are Reserved.
Code is distributed under the Apache 2.0 License. See LICENSE file for more
information.

The original OmniSocial code is Copyright (c) 2010-2011
[Tim Riley](http://openmonkey.com/) and [Icelab](http://icelab.com.au/), and is
released under MIT License.
