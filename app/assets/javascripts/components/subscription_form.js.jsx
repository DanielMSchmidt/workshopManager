var SubscriptionForm = React.createClass({
  propTypes: {
    subscribableId: React.PropTypes.number.isRequired,
    subscribableType: React.PropTypes.string.isRequired,
    subscribers: React.PropTypes.array.isRequired
  },

  getInitialState: function() {
    return {
      email: '',
      knownEmail: false
    };
  },

  emailChanged: function(event) {
    var email = event.target.value,
        knownEmail = $.inArray(email, this.props.subscribers) !== -1;

    this.setState({
      email: email,
      knownEmail: knownEmail
    });
  },

  renderSubscribeForm: function() {
    return (
      <form accept-charset="UTF-8" method="POST" action="/subscription/add.json" onSubmit={this.handleSubmit}>
        <div className="form-group">
          <label htmlFor="email">E-Mail Adresse</label><br />
          <input ref="email" name="email" type="email" placeholder="Bitte E-Mail Adresse eingeben" className="form-control" value={this.state.email} onChange={this.emailChanged} />
        </div>
        <div className="actions">
          <input type="submit" className="btn btn-primary" value="Anmelden" />
        </div>
        <input ref="subscribableId" name="subscribable_id" type="hidden" value={this.props.subscribableId} />
        <input ref="subscribableType" name="subscribable_type" type="hidden" value={this.props.subscribableType} />
      </form>
    );
  },

  renderUnsubscribeForm: function() {
    return (
      <form accept-charset="UTF-8" method="POST" onSubmit={this.handleUnsubscribe}>
        <div className="form-group">
          <label htmlFor="email">E-Mail Adresse</label><br />
          <input ref="email" name="email" type="email" placeholder="Bitte E-Mail Adresse eingeben" className="form-control" value={this.state.email} onChange={this.emailChanged} />
        </div>
        <div className="actions">
          <input type="submit" className="btn btn-primary" value="Abmelden" />
        </div>
        <input ref="subscribableId" name="subscribable_id" type="hidden" value={this.props.subscribableId} />
        <input ref="subscribableType" name="subscribable_type" type="hidden" value={this.props.subscribableType} />
      </form>
    );
  },

  renderFormSubmitted: function () {
    return (
      <div></div>
    );
  },

  showSpinner: function() {
    console.log('showing spinner');
  },

  hideSpinner: function() {
    console.log('hiding spinner');
  },

  showError: function() {
    console.log('show error');
  },

  handleSubmit: function() {
    this.setState({formSubmitted: true});
  },

  handleUnsubscribe: function(e) {
    e.nativeEvent.preventDefault();
    this.showSpinner();

    var token = btoa($.map([this.refs.subscribableType, this.refs.subscribableId, this.refs.email], function(ref){
          return $(ref.getDOMNode()).val();
        }).join(',')),
        path = '/subscription/' + token + '/remove',
        promise = $.get(path);

    promise.done(function() {
      this.hideSpinner();
      this.setState({formSubmitted: true});
    }.bind(this));

    promise.fail(function(error){
      console.error(error);
      this.showError();
      this.setState({formSubmitted: true});
    }.bind(this));
  },

  render: function() {
    if(this.state.formSubmitted) {
      return this.renderFormSubmitted();
    }

    if (this.state.knownEmail) {
      return this.renderUnsubscribeForm();
    } else {
      return this.renderSubscribeForm();
    }
  }
});
