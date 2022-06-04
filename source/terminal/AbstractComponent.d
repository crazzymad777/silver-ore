module terminal.AbstractComponent;

import terminal.base.Key;

// Component(JLineDisplay(), MainMenu()).run()
// Component:
// 1) check display sizes
// 2) draw itself (if updated)
// 3) draw child components (if updated)
// 4) handle key

abstract class AbstractComponent {
    void run() {
        do {
            process();
            if (update()) {
                draw();
            }
            recvKey(read());
        } while(!closed());
    }
    abstract Key read();
    abstract bool closed();
    abstract void process();
    abstract void recvKey(Key key);
    abstract void resize(int width, int height);
    abstract bool update();
    abstract void draw();
}
