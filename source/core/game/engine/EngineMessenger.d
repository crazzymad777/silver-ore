module core.engine.EngineMessenger;

import core.world.utils.GlobalCubeCoordinates;
import core.world.IWorld;
import core.game.Mob;

const ENGINE_ACTOR_ID = -1;
const GAME_ACTOR_ID = -2;

// ugly structs

struct EngineMessage(T) {
  MessageHead head;
  T body;
}

struct MessageHead {
  long actor_id;
  long number;
}

struct AssignWorldBody {
  IWorld world;
}

struct AssignMobBody {
  Mob mob;
}

struct ProcessBody {
}

struct ToggleMobFollowBody {
  Mob pet;
  Mob owner;
}

struct MobSetPositionBody {
  Mob mob;
  GlobalCubeCoordinates new_position;
}

struct SetFriendBody {
  Mob mob1;
  Mob mob2;
}

struct SetFoeBody {
  Mob mob1;
  Mob mob2;
}

struct MobSetFollowedBody {
  Mob follower;
  Mob followee;
}

class EngineMessenger {
  import core.Engine;
  static long message_count = 0;
  static void newMessage() {
    message_count++;
  }

  long id;
  Engine engine;
  this(long id, Engine engine) {
    this.engine = engine;
    this.id = id;
  }

  mixin template method(T, A...) {
    auto call(string s = "feed")() {
      auto message = EngineMessage!T(MessageHead(id, message_count), T(A));

      static if (s == "get") {
        return message;
      }
      static if (s == "feed") {
        engine.feed(message);
        return;
      }
      assert(0);
    }
  }

  auto assignWorld(string s = "feed")(IWorld world) {
    mixin method!(AssignWorldBody, world);
    return call!(s)();
  }

  auto assignMob(string s = "feed")(Mob mob) {
    mixin method!(AssignMobBody, mob);
    return call!(s)();
  }

  auto process(string s = "feed")() {
    mixin method!(ProcessBody);
    return call!(s)();
  }

  auto toggleMobFollow(string s = "feed")(Mob pet, Mob owner) {
    mixin method!(ToggleMobFollowBody, pet, owner);
    return call!(s)();
  }

  auto mobSetPosition(string s = "feed")(Mob mob, GlobalCubeCoordinates position) {
    mixin method!(MobSetPositionBody, mob, position);
    return call!(s)();
  }

  auto setFriend(string s = "feed")(Mob mob1, Mob mob2) {
    mixin method!(SetFriendBody, mob1, mob2);
    return call!(s)();
  }

  auto setFoe(string s = "feed")(Mob mob1, Mob mob2) {
    mixin method!(SetFoeBody, mob1, mob2);
    return call!(s)();
  }

  auto mobSetFollowed(string s = "feed")(Mob follower, Mob followee) {
    mixin method!(MobSetFollowedBody, follower, followee);
    return call!(s)();
  }
}
