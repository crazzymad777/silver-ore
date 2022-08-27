module silver.terminal.RequestData;

string input(string title) {
  import std.stdio;

  write(title ~ ": ");
  return readln!string();
}

int input(string title, string[] options) {
  import std.stdio, std.string, std.conv: to;

  writeln(title ~ ": ");
  for (int i = 0; i < options.length; i++) {
    writeln(to!string(i) ~ ") " ~ options[i]);
  }
  return to!int(strip(input("Enter")));
}
