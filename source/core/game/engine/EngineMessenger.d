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
  Action action;
  Argument[] args;
}

class EngineMessenger {
  // still awful code
  static EngineMessage assignWorld(int id, IWorld world) {
    EngineMessage.Argument arg1 = {world: world};
    return EngineMessage(id, EngineMessage.Action.ASSIGN_WORLD, [arg1]);
  }

  // still awful code
  static EngineMessage assignMob(int id, Mob mob) {
    EngineMessage.Argument arg1 = {mob: mob};
    return EngineMessage(id, EngineMessage.Action.ASSIGN_MOB, [arg1]);
  }

  // still awful code
  static EngineMessage process(int id) {
    return EngineMessage(id, EngineMessage.Action.PROCESS, []);
  }

  // still awful code
  static EngineMessage toggleMobFollow(int id, Mob pet, Mob owner) {
    EngineMessage.Argument arg1 = {mob: pet};
    EngineMessage.Argument arg2 = {mob: owner};
    return EngineMessage(id, EngineMessage.Action.TOGGLE_MOB_FOLLOW, [arg1, arg2]);
  }
}
