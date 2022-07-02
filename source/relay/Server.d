module relay.Server;

import relay.BasePeer;
import relay.Server;
import relay.IPeer;

class Server(string S = "selfhost", T) : BasePeer!(S, T) {
  override RelayMessage!T poll() {
    return RelayMessage!T();
  }

  override void send(RelayMessage!T) {

  }

  override void load(RelayMessage!T) {

  }

  override RelayMessage!T get() {
    return RelayMessage!T();
  }
}
