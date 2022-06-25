module core.engine.EngineMessenger;

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

class EngineMessenger {
  static long message_count = 0;

  static void newMessage() {
    message_count++;
  }

  static auto assignWorld(int id, IWorld world) {
    return AssignWorldMessage(MessageHead(id, message_count), world);
  }

  static auto assignMob(int id, Mob mob) {
    return AssignMobMessage(MessageHead(id, message_count), mob);
  }

  static auto process(int id) {
    return ProcessMessage(MessageHead(id, message_count));
  }

  static auto toggleMobFollow(int id, Mob pet, Mob owner) {
    return ToggleMobFollowMessage(MessageHead(id, message_count), pet, owner);
  }
}
