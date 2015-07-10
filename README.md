[![Build Status](https://drone.io/github.com/DanielMSchmidt/workshopManager/status.png)](https://drone.io/github.com/DanielMSchmidt/workshopManager/latest)
[![Code Climate](https://codeclimate.com/github/DanielMSchmidt/workshopManager/badges/gpa.svg)](https://codeclimate.com/github/DanielMSchmidt/workshopManager)
[![Test Coverage](https://codeclimate.com/github/DanielMSchmidt/workshopManager/badges/coverage.svg)](https://codeclimate.com/github/DanielMSchmidt/workshopManager)
# Workshop Manager

## Installation

- ```bundle install```
- ```cp config/database.yml.sample config/database.yml```
- ```rake db:migrate```
- ```rake db:seed``` # seeds the database


## Roadmap

### Version 1
- [X] User authentication
- [X] CRUD for workshops
- [X] Subscribe Form
- [X] Remove subscribers from subscribables
- [X] Mail from subscribable to all subscribers
- [X] User has name
- [X] Persist the send messages
- [X] Write js to handle the unsubscribale form
- [X] subscription controller should only respond in json
- [X] Public page for event
  - [X] General Info
  - [X] Latest notifications
  - [X] Subscribe
  - [X] Unsubscribe
- [X] Public page for user
  - [X] list of done and upcoming events
  - [X] subscribe
  - [X] unsubscribe
- [X] Info mail to subscribers of user about new events
- [X] Rebuild UI with React.js
  - [X] external
  - [X] admin area
  - [X] register / edit registration / unregister should be rebuild to automatically detect if a user is already registered
  - [X] Add some nice styling
- [ ] Style frontpage to be a nice landingpage
- [ ] Style emails
- [ ] make a deployment
- [ ] add Analytics
- [ ] add new relic

### Version 2
- [ ] Subscription with optional name and person count
- [ ] add possibility to delay the sending and generating all emails and messages for a given period of time
- [ ] add notify subscriptions tests
- [ ] Fix docker setup (and find CI which supports testing and building docker containers)

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

