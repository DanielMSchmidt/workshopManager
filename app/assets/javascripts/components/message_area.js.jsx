var MessageArea = React.createClass({
  propTypes: {
    messages: React.PropTypes.array.isRequired,
    messageCreateUrl: React.PropTypes.string.isRequired,
    eventId: React.PropTypes.number.isRequired,
  },

  getInitialState: function() {
    return {
      newMessage: '',
      postingMessage: false,
    };
  },

  handleNewMessageChange: function(e) {
    this.setState({newMessage: e.target.value});
  },

  onMessageSubmit: function (e) {
    e.preventDefault();
    if (this.state.newMessage === '') {
      return;
    }

    $.post(this.props.messageCreateUrl, {
      message: this.state.newMessage,
      subscribable_type: 'Event',
      subscribable_id: this.props.eventId,
    }).then(function(){
      location.reload();
    }.bind(this));

    this.setState({postingMessage: true, newMessage: ''});
  },

  getDateString: function (date) {
    return date.getDate() + '.' + date.getMonth() + '.' + date.getFullYear() + ' ' + date.getHours() + ':' + date.getMinutes();
  },

  renderForm: function() {
    return (
      <form onSubmit={this.onMessageSubmit}>
        <label htmlFor="newMessage active">Neue Nachricht</label>
        <textarea name="message" id="newMessage" value={this.state.newMessage} onChange={this.handleNewMessageChange} className="materialize-textarea" placeholder="Diese Nachricht wird nach dem Absenden an alle Teilnehmer verschickt"></textarea>
        <button className="btn waves-effect waves-light" type="submit" name="action">Absenden</button>
      </form>
    );
  },

  renderSpinner: function() {
    return (<Spinner />)
  },

  render: function() {
    var self = this;

    return (
      <div>
        <h2>Nachrichten</h2>
        <div className='row'>
          <div className="input-field col s12">
            {this.state.postingMessage ? this.renderSpinner() : this.renderForm()}
          </div>
        </div>
        <div className='row'>
          <ul className="collapsible col s12" data-collapsible="accordion">
            { this.props.messages.map(function(message) {
                var date = new Date(message.created_at);
                return (
                  <li key={message.id}>
                    <div className="collapsible-header">{message.content.substr(0,50)} - {self.getDateString(date)} </div>
                    <div className="collapsible-body"><p>{message.content}</p></div>
                  </li>
                );
            })}
          </ul>
        </div>
      </div>
    );
  }
});


// <div class="row">
//   <form accept-charset="UTF-8" method="POST" action="">
//     <input name="subscribable_id" type="hidden" value="<%= @event.id %>">
//     <input name="subscribable_type" type="hidden" value="Event">

//     <div class="form-group col-xs-9">
//       <label for="message">Nachricht</label><br>
//       <textarea id="message" name="message"  class="form-control"></textarea>
//       <div class="actions">
//         <input type="submit" class="btn btn-primary" value="Absenden">
//       </div>
//     </div>
//     <div class="col-xs-3">
//       <ul>
//         <% @event.messages.each do |message| %>
//           <li><%= message.content %></li>
//         <% end %>
//       </ul>
//     </div>
//   </form>
// </div>
