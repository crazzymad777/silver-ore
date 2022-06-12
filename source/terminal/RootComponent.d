module terminal.RootComponent;
import terminal.AbstractComponent;
import terminal.GameComponent;
import terminal.MapComponent;

import terminal.base.ITerminal;

import terminal.base.Key;

import std.stdio;

import core.world.World;

class RootComponent : AbstractComponent {
    private World world;
    private AbstractComponent[] components;
    private int currentId = GAME_ID;
    const int GAME_ID = 0;
    const int MAP_ID = 1;
    private GameComponent game;
    private MapComponent map;
    ITerminal terminal;
    this() {
      world = new World();
      import terminal.Settings: enableNcTerminal;
      terminal = ITerminal.getDefaultTerminal(!enableNcTerminal);
      game = new GameComponent(terminal, world);
      map = new MapComponent(terminal, world);
      this.components = [game,
                         map];
    }

    // obtain key
    override Key read() {
      return terminal.readKey();
    }

    override bool closed() {
      return components[currentId].closed();
    }

    override void process() {
      components[currentId].process();
    }

    override void recvKey(Key key) {
      import std.conv: to;

      char c = to!char(key.getKeycode());
      if (c == 'm') {
        if (currentId == GAME_ID) {
          terminal.puts(0, 0, "Enable map");
          currentId = MAP_ID;

          auto coors = game.coors;
          map.clusterId = coors.getChunkCoordinates().getClusterId();
        } else if (currentId == MAP_ID) {
          import core.world.utils.GlobalCubeCoordinates;
          import std.math;
          terminal.puts(0, 0, "Enable game");
          currentId = GAME_ID;

          auto clusterX = map.clusterId.getSignedX();
          auto clusterY = map.clusterId.getSignedY();

          auto x = abs(game.coors.x%256) + clusterX*256;
          auto y = abs(game.coors.y%256) + clusterY*256;
          game.coors = GlobalCubeCoordinates(x, y, game.coors.z);
        }
      } else {
        components[currentId].recvKey(key);
      }
    }

    override void resize(int width, int height) {
      components[currentId].resize(width, height);
    }

    override bool update() {
      return components[currentId].update();
    }

    override void sync() {
      components[currentId].sync();
    }

    override void draw() {
      components[currentId].draw();
    }
}
