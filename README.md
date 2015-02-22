# leadlocate

## Overview

**LeadLocate**, scours the web to find profiles *matching* your defined criteria.

1. Location - currently has to match format of location's on LinkedIn profiles, i.e. 'City, Country'
2. Skill - A skill or specific attribute that will be listed in profiles, e.g. 'Ruby on Rails'

Note: if using/working on the app locally, after creating an account you will be redirected to localhost, replace with a local virtual host (lvh.me).

## Setup

At this time, the app has only been run locally.

1. The usual bundle install, database setup, etc.
2. To run, fire up redis-server, and in separate terminal sessions issue commands
	1. ```$ bundle exec sidekiq -C 'config/sidekiq.yml'```
	2. ```$ rails s```
3. After creating an account you will be redirected to the subdomain.localhost, you may have to manually replace 'localhost' with a local virtual host 'lvh.me' depending on how you have your virtual host settings set up

### Todo

1. Better error handling/logging
2. Complete test suite
3. Tor proxy
4. Develop front-end
5. Build on basic features

