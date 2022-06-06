module terminal.base.Key;

class Key {
    enum BINDING {
        UP,
        DOWN,
        RIGHT,
        LEFT,
        TAB,
        ENTER,
        BACKSPACE,
        NO_MATCH
    }

    private int keycode;
    private BINDING binding;
    this(int keycode = 0, BINDING binding = BINDING.NO_MATCH) {
        this.keycode = keycode;
        this.binding = binding;
    }

    int getKeycode() {
      return keycode;
    }

    int getBinding() {
      return binding;
    }
}
