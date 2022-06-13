import terminal.app.App;
import terminal.app.Paladin;

int main(string[] args)
{
	if (args.length > 1) {
		if (args[1] == "paladin") {
			PaladinApplication();
			return 0;
		}
	}
	Application();
	return 0;
}
