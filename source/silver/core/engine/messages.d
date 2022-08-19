module silver.core.engine.messages;

import core.world.utils.GlobalCubeCoordinates;
import silver.core.world.IWorld;
import core.game.Mob;

// ugly structs

struct EngineMessage(T) {
  MessageHead head;
  T body;
}

struct MessageHead {
  long actor_id;
  long number;
}

import std.meta;
alias BodyMessages = AliasSeq!(AssignWorldBody, AssignMobBody, ProcessBody, ToggleMobFollowBody, MobSetPositionBody, SetFriendBody, SetFoeBody, MobSetFollowedBody);

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
