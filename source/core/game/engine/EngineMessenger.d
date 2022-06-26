module core.engine.EngineMessenger;

import core.world.utils.GlobalCubeCoordinates;
import core.world.IWorld;
import core.game.Mob;

const ENGINE_ACTOR_ID = -1;
const GAME_ACTOR_ID = -2;

struct MessageHead {
  long actor_id;
  long number;
}

struct AssignWorldMessage {
  MessageHead head;
  IWorld world;
}

struct AssignMobMessage {
  MessageHead head;
  Mob mob;
}

struct ProcessMessage {
  MessageHead head;
}

struct ToggleMobFollowMessage {
  MessageHead head;
  Mob pet;
  Mob owner;
}

struct MobSetPositionMessage {
  MessageHead head;
  Mob mob;
  GlobalCubeCoordinates new_position;
}

struct SetFriendMessage {
  MessageHead head;
  Mob mob1;
  Mob mob2;
}

struct SetFoeMessage {
  MessageHead head;
  Mob mob1;
  Mob mob2;
}

struct MobSetFollowedMessage {
  MessageHead head;
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
      auto message = T(MessageHead(id, message_count), A);

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

  auto assignWorld(IWorld world) {
    return AssignWorldMessage(MessageHead(id, message_count), world);
  }

  auto assignMob(Mob mob) {
    return AssignMobMessage(MessageHead(id, message_count), mob);
  }

  auto process() {
    return ProcessMessage(MessageHead(id, message_count));
  }

  auto toggleMobFollow(Mob pet, Mob owner) {
    return ToggleMobFollowMessage(MessageHead(id, message_count), pet, owner);
  }

  auto mobSetPosition(Mob mob, GlobalCubeCoordinates position) {
    return MobSetPositionMessage(MessageHead(id, message_count), mob, position);
  }

  auto setFriend(string s = "feed")(Mob mob1, Mob mob2) {
    mixin method!(SetFriendMessage, mob1, mob2);
    return call!(s)();
  }

  auto setFoe(string s = "feed")(Mob mob1, Mob mob2) {
    mixin method!(SetFoeMessage, mob1, mob2);
    return call!(s)();
  }

  auto mobSetFollowed(Mob follower, Mob followee) {
    return MobSetFollowedMessage(MessageHead(id, message_count), follower, followee);
  }
}
