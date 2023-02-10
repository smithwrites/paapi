import { Controller } from '@hotwired/stimulus';
import consumer from '../channels/consumer';

export default class extends Controller {
  static targets = ['messages'];

  connect() {
    this.channel = consumer.subscriptions.create('MessageChannel', {
      connected: this._cableConnected.bind(this),
      disconnected: this._cableDisconnected.bind(this),
      received: this._cableReceived.bind(this),
    });
  }

  clearInput() {
    this.inputTarget.value = '';
  }

  _cableConnected() {
    // Called when the subscription is ready for use on the server
  }

  _cableDisconnected() {
    // Called when the subscription has been terminated by the server
  }

  _cableReceived(data) {
    if(this.messagesTarget.querySelectorAll(`[data-message-id="${data.id}"]`).length > 0) {
      console.log('Already added');
      return;
    }
    const li = document.createElement('li');
    li.setAttribute('data-message-id', data.id);
    li.textContent = data.body;
    this.messagesTarget.appendChild(li);
  }
}