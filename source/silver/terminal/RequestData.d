module silver.terminal.RequestData;

T checkedInput(T)(bool delegate(T) check, T delegate() input) {
  T value;
  do {
    value = input();
  } while(!check(value));
  return value;
}

string input(string title) {
  import std.stdio;

  write(title ~ ": ");
  return readln!string();
}

int input(string title, string[] options) {
  import std.stdio, std.string, std.conv;

  writeln(title ~ ": ");
  for (int i = 0; i < options.length; i++) {
    writeln(to!string(i) ~ ") " ~ options[i]);
  }

  int value = -1;
  try {
    value = to!int(strip(input("Enter")));
  } catch (ConvException e) {
    value = -1;
  }
  return value;
}
