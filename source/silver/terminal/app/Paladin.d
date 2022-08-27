module silver.terminal.app.Paladin;

import custom.paladin.terminal.PaladinComponent;

export void PaladinApplication() {
  import silver.terminal.RequestData;
  int checkRange(ulong max, string title, string[] options) {
    return checkedInput!int((int i) => (i >= 0 && i < max), () => input(title, options));
  }
  string checkOptions(string[] options, string title) {
    return options[checkRange(options.length, title, options)];
  }

  string[] races = ["Human", "Elf", "Dark Elf", "Dwarf", "Orc"];
  string[] weapons = ["Battleaxe", "Longsword", "Shortsword", "Warhammer"];
  string[] pets = ["Bear", "Lion", "Wolf", "Fox", "Dog", "Cat", "Red Panda", "None"];

  string name, race, weapon, pet;
  name = checkedInput!string((string str) => str.length > 0 && str.length < 15, () => input("Enter hero name"));
  race = checkOptions(races, "Choose hero race");
  weapon = checkOptions(weapons, "Choose weapon");
  pet = checkOptions(pets, "Choose pet");
  auto component = new PaladinComponent();
  component.run();
}
