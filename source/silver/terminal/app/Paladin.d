module silver.terminal.app.Paladin;

import custom.paladin.terminal.PaladinComponent;

export void PaladinApplication() {
  import silver.terminal.RequestData;
  input("Enter hero name");
  input("Choose hero race", ["Human", "Elf", "Dark Elf", "Dwarf", "Orc"]);
  input("Choose weapon", ["Battleaxe", "Longsword", "Shortsword", "Warhammer"]);
  input("Choose pet", ["Bear", "Lion", "Wolf", "Fox", "Dog", "Cat", "Red Panda", "None"]);
  auto component = new PaladinComponent();
  component.run();
}
