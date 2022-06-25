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

    void feed(T)(T message) {
      static if (is(T == AssignWorldMessage)) {
        assignWorld(message.world);
      }
      static if (is(T == AssignMobMessage)) {
        assignMob(message.mob);
      }
      static if (is(T == ProcessMessage)) {
        process();
      }
      static if (is(T == ToggleMobFollowMessage)) {
        toggleMobFollow(message.pet, message.owner);
      }
      static if (is(T == MobSetPositionMessage)) {
        mobSetPosition(message.mob, message.new_position);
      }
      static if (is(T == SetFriendMessage)) {
        mobSetFriend(message.mob1, message.mob2);
      }
      static if (is(T == SetFoeMessage)) {
        mobSetFoe(message.mob1, message.mob2);
      }
      static if (is(T == MobSetFollowedMessage)) {
        mobSetFollowed(message.follower, message.followee);
      }
      EngineMessenger.newMessage();
    }

    import core.game.animals.Animal;
    private void mobSetFollowed(Mob follower, Mob followee) {
      if (Animal animal1 = cast(Animal) follower) {
        if (Animal animal2 = cast(Animal) followee) {
          animal1.followed = animal2;
        }
      }
    }

    private void mobSetFoe(Mob mob1, Mob mob2) {
      if (Animal animal1 = cast(Animal) mob1) {
        if (Animal animal2 = cast(Animal) mob2) {
          animal2.foes ~= animal1;
        }
        animal1.foes ~= mob2;
      }
    }

    private void mobSetFriend(Mob mob1, Mob mob2) {
      if (Animal animal1 = cast(Animal) mob1) {
        if (Animal animal2 = cast(Animal) mob2) {
          animal2.friends ~= animal1;
        }
        animal1.friends ~= mob2;
      }
    }

    import core.world.utils.GlobalCubeCoordinates;
    private void mobSetPosition(Mob mob, GlobalCubeCoordinates position) {
      mob.position = position;
      mob.newPosition = position;
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
