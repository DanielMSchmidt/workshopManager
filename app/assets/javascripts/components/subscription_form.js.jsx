var getPath = function (token) {
  return '/subscription/' + token + '/remove';
};

var SubscriptionForm = React.createClass({
  propTypes: {
    subscribeUrl: React.PropTypes.string.isRequired,
    subscribableType: React.PropTypes.string.isRequired,
    subscribableId: React.PropTypes.number.isRequired,
    subscriptions: React.PropTypes.array.isRequired,
  },

  getInitialState: function() {
    return {
      knownMail: false,
      submitting: false,
      email: '',
    };
  },

  onMessageSubmit: function(e) {
    e.preventDefault();
    this.setState({ submitting: true });
    var promise;

    if (this.state.knownMail) {
      var arr = [this.props.subscribableType, this.props.subscribableId, this.state.email],
          path = getPath(btoa(arr.join(','))); // put it into the path

      promise = $.get(path);
    } else {
      promise = $.post(this.props.subscribeUrl, {
        email: this.state.email,
        subscribable_type: this.props.subscribableType,
        subscribable_id: this.props.subscribableId,
      });
    }

    promise.then(function(){
      this.setState({
        email: '',
        submitting: false,
      });
      location.reload();
    }.bind(this))
  },

  isKnownEmail: function(email) {
    return _.contains(this.props.subscriptions, email);
  },

  handleEmailChange: function(e) {
    var newEmail = e.target.value;
    this.setState({
      email: newEmail,
      knownMail: this.isKnownEmail(newEmail),
    });
  },

  renderSubscribe: function() {
    return (
      <form acceptCharset="UTF-8" method="POST" onSubmit={this.onMessageSubmit}>
        <div className="row">
          <div className="input-field s12 col">
            <input name="email" type="email" value={this.state.email} onChange={this.handleEmailChange} placeholder="Bitte E-Mail Adresse eingeben" className="validate" />
            <label htmlFor="email">E-Mail Adresse</label>
          </div>
        </div>

        <div className="actions row">
          <button className="btn waves-effect waves-light s12 col" type="submit" name="action">Anmelden</button>
        </div>
      </form>
    );
  },

  renderUnsubscribe: function() {
    return (
      <form acceptCharset="UTF-8" method="POST" onSubmit={this.onMessageSubmit}>
        <div className="row">
          <div className="input-field s12 col">
            <input name="email" type="email" value={this.state.email} onChange={this.handleEmailChange} placeholder="Bitte E-Mail Adresse eingeben" className="validate" />
            <label htmlFor="email">E-Mail Adresse</label>
          </div>
        </div>

        <div className="actions row">
          <button className="btn waves-effect waves-light s12 col" type="submit" name="action">Abmelden</button>
        </div>
      </form>
    );
  },

  renderSpinner: function() {
    return (<Spinner />)
  },

  render: function() {
    if (this.state.submitting) {
      return this.renderSpinner();
    } else {
      return (
        <div>
          <h2>An- / Abmelden</h2>

          <p>Bitte geben Sie Ihre E-Mailadresse ein um sich an, beziehungsweise abzumelden für diese Veranstaltung.</p>

          { this.state.knownMail ? this.renderUnsubscribe() : this.renderSubscribe() }
        </div>
      );
    }

  }
});
