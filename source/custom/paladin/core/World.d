module custom.paladin.world.World;

import core.world.utils.GlobalCubeCoordinates;
import custom.paladin.world.Generator;
import core.world.Cube;
import core.world.IWorld;
import core.game.humanoids.Humanoid;
import core.game.Mob;

import core.thread.osthread;

class DerivedThread : Thread
{
    shared bool* isEndOfTime;
    World world;
    this(shared(bool)* isEndOfTime, World world)
    {
        this.isEndOfTime = isEndOfTime;
        this.world = world;
        super(&run);
    }

private:
    void run()
    {
        import core.time;
        // Derived thread running.
        while (!*isEndOfTime) {
          Thread.sleep( dur!("msecs")(100) );
          world.process();
          world.count++;
        }
    }
}

class World : IWorld {
    this() {
      auto derived = new DerivedThread(&isEndOfTime, this).start();
    }

    int count = 0;
    private Generator generator = new Generator();
    private Humanoid paladin = new Humanoid();
    Cube getCube(GlobalCubeCoordinates coors) {
      return generator.getCube(coors);
    }

    void process() {
      paladin.process(this);
    }

    bool checkColision(GlobalCubeCoordinates a, GlobalCubeCoordinates b) {
      return getCube(b).wall.isSolid();
    }

    void checkVisible(GlobalCubeCoordinates coors) {

    }

    Mob getPaladin() {
      return paladin;
    }

    shared bool isEndOfTime = false;
    void apocalypse() {
      isEndOfTime = true;
    }
}
