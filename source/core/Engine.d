module core.Engine;

import core.engine.EngineMessenger;
import core.world.IWorld;
import core.game.Mob;

/* union EngineResponse {
  void assignedWorld;
  void assignedMob;
  void processing;
} */

class Engine {
    /* protected */ IWorld[] worlds;
    /* protected */ Mob[] mobs;

    this() {
      before = MonoTime.currTime;
    }

    void feed(EngineMessage message) {
      if (message.action == EngineMessage.Action.ASSIGN_WORLD) {
        assignWorld(message.args[0].world);
      } else if (message.action == EngineMessage.Action.ASSIGN_MOB) {
        assignMob(message.args[0].mob);
      } else if (message.action == EngineMessage.Action.PROCESS) {
        process();
      } else if (message.action == EngineMessage.Action.TOGGLE_MOB_FOLLOW) {
        toggleMobFollow(message.args[0].mob, message.args[1].mob);
      }
    }

    private void toggleMobFollow(Mob pet, Mob owner) {
      import core.game.animals.Lion;

      auto lion = cast(Lion) pet;
      if (lion.followed is null) {
        lion.followed = owner;
      } else {
        if (lion.followed == owner) {
          lion.followed = null;
        } else {
          lion.followed = owner;
        }
      }
    }

    private void assignWorld(IWorld world) {
      worlds ~= world;
    }

    private void assignMob(Mob mob) {
      mobs ~= mob;
    }

    import core.time;
    /* protected */ long count = 0;
    protected MonoTime before;
    protected void process() {
      MonoTime after = MonoTime.currTime;
      Duration timeElapsed = after - before;
      if (timeElapsed.total!"msecs" > 100) {
        foreach(mob; mobs) {
          mob.process();
        }

        count++;
        before = MonoTime.currTime;
      }
    }
}
