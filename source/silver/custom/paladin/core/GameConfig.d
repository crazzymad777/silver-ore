module silver.custom.paladin.core.GameConfig;

struct GameConfig {
  string name, race, weapon, pet;

  static void requestGameConfig() {

  }

  import core.game.humanoids.Humanoid;
  import silver.core.game.IGame;
  Humanoid getPaladin(IGame game) {
    // enumerate?
    if (race == "Orc") {
      import silver.core.game.humanoids.Orc;
      return new Orc(game);
    } else if (race == "Dark Elf") {
      import silver.core.game.humanoids.DarkElf;
      return new DarkElf(game);
    } else if (race == "Elf") {
      import silver.core.game.humanoids.Elf;
      return new Elf(game);
    } else if (race == "Dwarf") {
      import silver.core.game.humanoids.Dwarf;
      return new Dwarf(game);
    } else if (race == "Human") {
      import silver.core.game.humanoids.Human;
      return new Human(game);
    }

    return new Humanoid(game);
  }
}
