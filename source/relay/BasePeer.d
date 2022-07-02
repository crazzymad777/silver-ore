module relay.BasePeer;

import relay.IPeer;

class BasePeer(string S = "selfhost", T) : IPeer!T {
  RelayMessage!T[] messages_to_poll;
  RelayMessage!T[] messages_to_send;

  RelayMessage!T poll() {
    // return message from messages_to_poll
    return RelayMessage!T();
  }

  void send(RelayMessage!T msg) {
    messages_to_send ~= msg;
  }

  void load(RelayMessage!T msg) {
    messages_to_poll ~= msg;
  }

  RelayMessage!T get() {
    // return message from messages_to_send
    return RelayMessage!T();
  }
}
