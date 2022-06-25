module core.engine.EngineMessenger;

import core.world.IWorld;
import core.game.Mob;

const ENGINE_ACTOR_ID = -1;
const GAME_ACTOR_ID = -2;

struct EngineMessage {
  enum Action {
    ASSIGN_WORLD,
    ASSIGN_MOB,
    PROCESS,
    TOGGLE_MOB_FOLLOW
  };
  union Argument {
    Mob mob;
    IWorld world;
  };

  // actor_id: -1 for engine (inclduding mobs' code)
  //           -2 for Game
  //           other for clients
  long actor_id;
  long number;
  Action action;
  Argument[] args;
}

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

  // still awful code
  static auto assignWorld(int id, IWorld world) {
    return AssignWorldMessage(MessageHead(id, message_count), world);
    /* EngineMessage.Argument arg1 = {world: world};
    return EngineMessage(id, message_count, EngineMessage.Action.ASSIGN_WORLD, [arg1]); */
  }

  // still awful code
  static auto assignMob(int id, Mob mob) {
    return AssignMobMessage(MessageHead(id, message_count), mob);
    /* EngineMessage.Argument arg1 = {mob: mob};
    return EngineMessage(id, message_count, EngineMessage.Action.ASSIGN_MOB, [arg1]); */
  }

  // still awful code
  static auto process(int id) {
    return ProcessMessage(MessageHead(id, message_count));
    /* return EngineMessage(id, message_count, EngineMessage.Action.PROCESS, []); */
  }

  // still awful code
  static auto toggleMobFollow(int id, Mob pet, Mob owner) {
    return ToggleMobFollowMessage(MessageHead(id, message_count), pet, owner);
    /* EngineMessage.Argument arg1 = {mob: pet};
    EngineMessage.Argument arg2 = {mob: owner};
    return EngineMessage(id, message_count, EngineMessage.Action.TOGGLE_MOB_FOLLOW, [arg1, arg2]); */
  }
}
