[ ![Codeship Status for DanielMSchmidt/workshopManager](https://codeship.com/projects/dd0f4b00-e353-0131-36da-0e6774a12e5d/status?branch=master)](https://codeship.com/projects/25425)
[![Code Climate](https://codeclimate.com/github/DanielMSchmidt/workshopManager/badges/gpa.svg)](https://codeclimate.com/github/DanielMSchmidt/workshopManager)
[![Test Coverage](https://codeclimate.com/github/DanielMSchmidt/workshopManager/badges/coverage.svg)](https://codeclimate.com/github/DanielMSchmidt/workshopManager)
[![Stories in Ready](https://badge.waffle.io/DanielMSchmidt/workshopManager.png?label=ready&title=Ready)](http://waffle.io/DanielMSchmidt/workshopManager)
# Workshop Manager

## Installation

### Docker

- ```cp config/database.yml.docker config/database.yml```
- ```cp config/newrelic.yml.local config/newrelic.yml```
- ```docker-compose up```
- Pro tip: use [docker-osx-dev](https://github.com/brikis98/docker-osx-dev) on osx

### Local

- ```bundle install```
- ```cp config/database.yml.local config/database.yml```
- ```cp config/newrelic.yml.local config/newrelic.yml```
- ```rake db:migrate```
- ```rake db:seed``` # seeds the database


## Configuration
(via .env with foreman or your local Enviroment)

- Add GOOGLE_ANALYTICS_TRACKING_CODE to add a google analytics

## Roadmap

[The roadmap is defined in this waffle board. Feel free to add issues if you need anything more](https://waffle.io/DanielMSchmidt/workshopManager)

## Idea

### Registered User

1. Register / Login
2. Workshop Overview (startdatetime, duration, name, description, subscribers[])
  -> embed snippet (which shows attributes and a form to subscribe)
3. Mail to button to all subscibers for event
4. Add new subscriber manually
5. Mail to a list of own subscribes about an event

### Subscriber

1. Subscribe to user / event
2. get notifications about new event or news to events


## Notes
- the Token for unsubscribe request should be of format `<type>,<type_id>,<email>` in Base64 encoded

