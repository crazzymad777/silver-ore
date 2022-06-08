module terminal.app.App;

import terminal.RootComponent;

export void Application() {
    auto component = new RootComponent();
    component.run();
}
