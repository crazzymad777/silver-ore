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
    this(BINDING binding = BINDING.NO_MATCH, int keycode = 0) {
        this.keycode = keycode;
        this.binding = binding;
    }
}
