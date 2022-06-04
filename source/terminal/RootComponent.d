module terminal.RootComponent;
import terminal.AbstractComponent;
import terminal.GameComponent;
import terminal.base.Key;

import std.stdio;

import core.world.utils;
import core.world.World;

class RootComponent : AbstractComponent {
    private AbstractComponent component;
    this() {
      this.component = new GameComponent();
    }

    override void run() {
        component.run();
    }

    // obtain key
    override Key read() {
      return new Key();
    }

    override bool closed() {
      return component.closed();
    }

    override void process() {
      component.process();
    }

    override void recvKey(Key key) {
      component.recvKey(key);
    }

    override void resize(int width, int height) {
      component.resize(width, height);
    }

    override bool update() {
      return component.update();
    }

    override void draw() {
      component.draw();
    }
}
