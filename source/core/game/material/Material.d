module core.game.material.Material;

class Material {
  package this(Material[string] materials) {

  }

  Material[string] materials;
  string name = "MATERIAL";
  override string toString() {
    return name;
  }
}
