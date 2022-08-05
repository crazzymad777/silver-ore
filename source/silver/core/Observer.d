module core.Observer;

/* import terminal.AbstractComponent;
import core.world.IWorld;

class Observer {
  import core.thread.osthread;

  class DerivedThread : Thread
  {
      IWorld world;
      AbstractComponent component;
      this(IWorld world, AbstractComponent component)
      {
          this.component = component;
          this.world = world;
          super(&run);
      }

  private:
      void run()
      {
          import core.time;
          // Derived thread running.
          while (!world.hasApocalypseHappened()) {
            Thread.sleep( dur!("msecs")(100) );
            world.process();
            // component.draw();
          }
      }
  }

  this(AbstractComponent component, IWorld world) {
    auto derived = new DerivedThread(world, component).start();
  }
} */
