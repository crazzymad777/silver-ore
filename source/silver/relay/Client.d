module relay.Client;

import relay.BasePeer;
import relay.Server;
import relay.IPeer;

class Client(string S = "selfhost", T) : BasePeer!(S, T) {
  import std.typecons: Nullable;
  static if (S == "selfhost") {
    protected Server!(S, T) server;
  }

  this() {
    static if (S == "selfhost") {
      server = new Server!(S, T)();
    }
  }

  override Nullable!(RelayMessage!T) poll() {
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

  override Nullable!(RelayMessage!T) get() {
    return Nullable!(RelayMessage!T)();
  }
}
