module silver.terminal.app.Paladin;

import custom.paladin.terminal.PaladinComponent;

export void PaladinApplication() {
  import silver.custom.paladin.core.GameConfig;
  auto component = new PaladinComponent(GameConfig.request());
  component.run();
}
