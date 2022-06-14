module custom.paladin.world.TextState;

import terminal.base.TerminalColor;

class TextState {
  static string getStamina(int stamina, int maxStamina) {
    if (stamina <= 2) {
      return "No stamina at all";
    }

    float k = float(stamina)/maxStamina;
    if (k <= 0.4) {
      return "Weak stamina";
    } else if (k <= 0.9){
      return "Adequate stamina";
    }
    return "Full stamina";
  }

  static string getHealth(int hp, int maxHp) {
    if (hp <= 0) {
      return "Dead";
    }

    float k = float(hp)/maxHp;
    if (k <= 0.2) {
      return "Very weak health";
    } else if (k <= 0.4){
      return "Weak health";
    } else if (k <= 0.6){
      return "Modest health";
    } else if (k <= 0.8){
      return "Strong helth";
    }
    return "Very strong health";
  }

  static TerminalColor getStaminaColor(int stamina, int maxStamina) {
    if (stamina <= 2) {
      return TerminalColor.RED;
    }

    float k = float(stamina)/maxStamina;
    if (k <= 0.4) {
      return TerminalColor.YELLOW;
    } else if (k <= 0.9){
      return TerminalColor.WHITE;
    }
    return TerminalColor.GREEN;
  }

  static TerminalColor getHealthColor(int hp, int maxHp) {
    if (hp <= 0) {
      return TerminalColor.RED;
    }

    float k = float(hp)/maxHp;
    if (k <= 0.2) {
      return TerminalColor.RED;
    } else if (k <= 0.4){
      return TerminalColor.YELLOW;
    } else if (k <= 0.6){
      return TerminalColor.GRAY;
    } else if (k <= 0.8){
      return TerminalColor.WHITE;
    }
    return TerminalColor.GREEN;
  }
}
