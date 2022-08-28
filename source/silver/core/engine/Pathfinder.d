module silver.core.engine.Pathfinder;

class Pathfinder {
  import core.world.utils.GlobalCubeCoordinates;
  import std.container : DList;
  private GlobalCubeCoordinates lastFrom;
  private GlobalCubeCoordinates lastTo;
  private DList!GlobalCubeCoordinates path;

  void setFrom(GlobalCubeCoordinates from) {
    lastFrom = from;
  }

  void setTo(GlobalCubeCoordinates to) {
    lastTo = to;
  }

  import silver.core.world.IWorld;
  Move find(IWorld world) {
    struct Offset {
        int x, y;
    }
    import std.math: abs, sgn;
    import std.conv: to;

    const Offset[] offsets = [{1, 0}, {0, 1}, {-1, 0}, {0, -1}];
    GlobalCubeCoordinates[] marked;
    marked ~= lastFrom;

    Move find_path(GlobalCubeCoordinates position, int length, int step) {
      if (length <= 0) {
        return Move(FINDING_RESULT.LOST, position, length);
      }

      GlobalCubeCoordinates new_position;
      for (int j = 0; j < 4; j++) {
        new_position = position;
        import std.algorithm: canFind;
        new_position.x += offsets[j].x;
        new_position.y += offsets[j].y;
        if (!world.checkColision(position, new_position)) {
          if (!marked.canFind(new_position)) {
            if (new_position == lastTo) {
              return Move(FINDING_RESULT.FOUND, position, length);
            }
            marked ~= new_position;
          }
          if (step > 0) {
            auto result = find_path(new_position, length, step - 1);
            if (result.result == FINDING_RESULT.FOUND) {
              return Move(FINDING_RESULT.FOUND, new_position, length);
            }
          }
        }
      }
      return Move(FINDING_RESULT.LOST, position, length);
    }

    Move result;
    for (int step = 0; step < 8; step++) {
      result = find_path(lastFrom, step, step);
      if (result.result == FINDING_RESULT.FOUND) {
        return result;
      }
    }
    return Move(FINDING_RESULT.LOST, lastFrom, 8);
  }

  /* Move find(Move current, IWorld world) {
    current.length++;
    if (current.length >= 256) {
      return Move(FINDING_RESULT.LOST, current.position, current.length);
    }

    import std.math: abs, sgn;
    import std.conv: to;
    auto dx = lastTo.x-lastFrom.x;
    auto dy = lastTo.y-lastFrom.y;
    auto sign_dx = to!int(sgn(dx));
    auto sign_dy = to!int(sgn(dy));
    // diogonal motion?
    current.position = GlobalCubeCoordinates(lastFrom.x + sign_dx, lastFrom.y + sign_dy, lastFrom.z);
    return find(current, world);
  } */

  enum FINDING_RESULT {
    LOST,
    FOUND
  };

  struct Move {
    FINDING_RESULT result;
    GlobalCubeCoordinates position;
    int length;
  }
}
