module relay.Client;

import relay.BasePeer;
import relay.Server;
import relay.IPeer;

class Client(string S = "selfhost", T) : BasePeer!(S, T) {
  static if (S == "selfhost") {
    protected Server!(S, T) server;
  }

  this() {
    static if (S == "selfhost") {
      server = new Server!(S, T)();
    }
  }

  override RelayMessage!T poll() {
    static if (S == "selfhost") {
      return server.get();
    }
  }

  override void send(RelayMessage!T msg) {
    static if (S == "selfhost") {
      server.load(msg);
    }
  }

  override void load(RelayMessage!T) {

  }

  override RelayMessage!T get() {
    return RelayMessage!T();
  }
}
