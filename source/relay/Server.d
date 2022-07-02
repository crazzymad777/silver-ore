module relay.Server;

import relay.BasePeer;
import relay.Server;
import relay.IPeer;

class Server(string S = "selfhost", T) : BasePeer!(S, T) {
  import std.typecons;
  override Nullable!(RelayMessage!T) poll() {
    return Nullable!(RelayMessage!T)();
  }

  override void send(RelayMessage!T) {

  }

  override void load(RelayMessage!T) {

  }

  override Nullable!(RelayMessage!T) get() {
    return Nullable!(RelayMessage!T)();
  }
}
