module silver.custom.paladin.core.GameConfig;

struct GameConfig {
  string name, race, weapon, pet;
  bool test;

  static GameConfig request() {
    import silver.terminal.RequestData;
    int checkRange(ulong max, string title, string[] options) {
      return checkedInput!int((int i) => (i >= 0 && i < max), () => input(title, options));
    }
    string checkOptions(string[] options, string title) {
      return options[checkRange(options.length, title, options)];
    }

    string[] races = ["Human", "Elf", "Dark Elf", "Dwarf", "Orc"];
    string[] weapons = ["Battleaxe", "Longsword", "Shortsword", "Warhammer", "Mace"];
    string[] pets = ["Bear", "Lion", "Wolf", "Fox", "Dog", "Cat", "Red Panda", "None"];

    GameConfig gc;
    import std.string;
    gc.name = strip(checkedInput!string((string str) => str.length > 0 && str.length < 15, () => input("Enter hero name")));
    if (gc.name == "test") {
      gc.name = "Emmanuel";
      gc.race = "Elf";
      gc.weapon = "Warhammer";
      gc.pet = "Red Panda";
      gc.test = true;
    } else {
      gc.race = checkOptions(races, "Choose hero race");
      gc.weapon = checkOptions(weapons, "Choose weapon");
      gc.pet = checkOptions(pets, "Choose pet");
    }
    return gc;
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

  import silver.core.game.animals.Animal;
  Animal getPet(IGame game) {
    string altered_pet = pet;
    if (pet == "Red Panda") {
      altered_pet = "RedPanda";
    }

    import silver.core.game.animals.Bear;
    import silver.core.game.animals.Lion;
    import silver.core.game.animals.Wolf;
    import silver.core.game.animals.Fox;
    import silver.core.game.animals.Dog;
    import silver.core.game.animals.Cat;
    import silver.core.game.animals.RedPanda;
    import std.meta;
    static foreach(y; AliasSeq!(Bear, Lion, Wolf, Fox, Dog, Cat, RedPanda)) {
      if (y.stringof == altered_pet) {
        return new y(game);
      }
    }
    return null;
  }

  import silver.core.game.Weapon;
  Weapon getWeapon() {
    import silver.core.game.weapon.combat.Battleaxe;
    import silver.core.game.weapon.combat.Warhammer;
    import silver.core.game.weapon.combat.Longsword;
    import silver.core.game.weapon.combat.Shortsword;
    import silver.core.game.weapon.combat.Mace;
    import std.meta;
    static foreach(y; AliasSeq!(Battleaxe, Warhammer, Longsword, Shortsword, Mace)) {
      if (y.stringof == weapon) {
        return new y();
      }
    }
    return null;
  }
}
