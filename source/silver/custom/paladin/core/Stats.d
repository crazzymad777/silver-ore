module custom.paladin.core.Stats;

class Stats {
  struct Entry {
    int hits;
    int hitsTaken;
    int damage;
    int damageTaken;
  }

  Entry[string] entries;
  void addEntry(string name) {
    entries[name] = Entry();
  }
}
