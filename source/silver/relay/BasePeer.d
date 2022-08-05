module relay.BasePeer;

import relay.IPeer;

class BasePeer(string S = "selfhost", T) : IPeer!T {
  import std.container : SList;
  import std.typecons;
  SList!(RelayMessage!T) messages_to_poll;
  SList!(RelayMessage!T) messages_to_send;

  Nullable!(RelayMessage!T) poll() {
    // return message from messages_to_poll
    if (messages_to_poll.empty()) {
      return Nullable!(RelayMessage!T)();
    }

    auto message = messages_to_poll.front;
    messages_to_poll.removeFront();
    return nullable(message);
  }

  void send(RelayMessage!T msg) {
    messages_to_send.insert(msg);
  }

  void load(RelayMessage!T msg) {
    messages_to_poll.insert(msg);
  }

  Nullable!(RelayMessage!T) get() {
    // return message from messages_to_send
    if (messages_to_send.empty()) {
      return Nullable!(RelayMessage!T)();
    }

    auto message = messages_to_send.front;
    messages_to_send.removeFront();
    return nullable(message);
  }
}
