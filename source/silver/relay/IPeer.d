module relay.IPeer;

struct RelayMessage(T) {
  long protocol_version = 1;
  long message_id;
  long from_id;
  long to_id;
  T payload;
}

interface IPeer(T) {
  import std.typecons: Nullable;
  // Selfhost peer
  // load message for poll
  void load(RelayMessage!T);
  // get message
  Nullable!(RelayMessage!T) get();

  // Remote peer
  // receive message from another peer
  Nullable!(RelayMessage!T) poll();
  // send message to another peer
  void send(RelayMessage!T);
}
