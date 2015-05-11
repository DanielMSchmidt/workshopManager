'use strict';

var SubscriptionForm = React.createClass({
  propTypes: {
    subscribableType: React.PropTypes.string.isRequired,
    subscribableId: React.PropTypes.number.isRequired
  },

  render: function() {
    return (
      <form accept-charset="UTF-8" method="POST">
        <div className="form-group">
          <label htmlFor="email">E-Mail Adresse</label><br />
          <input name="email" type="email" placeholder="Bitte E-Mail Adresse eingeben" className="form-control" />
        </div>
        <div className="actions">
          <input type="submit" className="btn btn-primary" defaultValue="Abmelden" />
        </div>
        <input name="subscribable_id" type="hidden" defaultValue="<%= @event.id %>" />
        <input name="subscribable_type" type="hidden" defaultValue="Event" />
      </form>
    );
  }
});
