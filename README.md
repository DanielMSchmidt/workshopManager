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
- [X] User authentication
- [X] CRUD for workshops
- [X] Subscribe Form
- [X] Remove subscribers from subscribables
- [X] Mail from subscribable to all subscribers
- [X] User has name
- [X] Persist the send messages
- [X] Write js to handle the unsubscribale form
- [X] subscription controller should only respond in json
- [ ] Build Subscribe Snippet
- [ ] Public page for event, with notifications send and which has links to subscribe / unsubscribe
- [ ] Info mail to subscribers of user about new events

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
- the Token for unsubscribe request should be of format "<type>,<type_id>,<email>" in Base64 encoded

