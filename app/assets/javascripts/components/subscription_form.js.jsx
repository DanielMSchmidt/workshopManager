'use strict';


var interval,
    subscriptionsPath = function(type, id) { return ['subscription', type, id].join('/'); },
    subscribePath = function(type, id) { return [type, id, 'subscribe'].join('/'); },
    unsubscribePath = function(token) { return 'subscription/' + token + '/remove'; };

var SubscriptionForm = React.createClass({
  propTypes: {
    subscribableType: React.PropTypes.string.isRequired,
    subscribableId: React.PropTypes.number.isRequired
  },

  getInitialState: function() {
    return {
      userKnown: false
    };
  },

  isUserKnown: function(subscribers) {
    var subscriber_mails = subscribers.map(function(subscriber) {
      return subscriber.email;
    });
    return subscriber_mails.indexOf(this.state.emails) > -1;
  },

  loadSubscribers: function() {
    $.get(subscriptionsPath(this.props.subscribableType, this.props.subscribableId)).then(function(result) {
      this.setState({
        userKnown: this.isUserKnown(result)
      });
    }.bind(this));
  },

  componentWillMount: function() {
    this.loadSubscribers.call(this);
    interval = setInterval(function(){
      this.loadSubscribers.call(this);
    }.bind(this), 5000);
  },

  componentWillUnmount: function() {
    clearInterval(interval);
  },

  handleSubmit: function() {
    // TODO: subscribe (post to subscribePath) / unsubscribe user (see events.js)
      // set userKnown to true and empty email
    debugger;
  },

  handleChange: function(e) {
    this.setState({email: e.target.value});
  },

  render: function() {
    return (
      <form accept-charset="UTF-8" method="POST" onSubmit={this.handleSubmit}>
        <div className="form-group">
          <label htmlFor="email">E-Mail Adresse</label><br />
          <input name="email" type="email" placeholder="Bitte E-Mail Adresse eingeben" className="form-control" value={this.state.email} onChange={this.handleChange} />
        </div>
        <div className="actions">
          <input type="submit" className="btn btn-primary" defaultValue={ this.state.userKnown ? 'Abmelden' : 'Anmelden'} />
        </div>
        <input name="subscribable_id" type="hidden" defaultValue="<%= @event.id %>" />
        <input name="subscribable_type" type="hidden" defaultValue="Event" />
      </form>
    );
  }
});
