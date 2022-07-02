import terminal.app.App;
import terminal.app.Paladin;
import terminal.app.Traveler;

int main(string[] args)
{
	if (args.length > 1) {
		if (args[1] == "paladin") {
			PaladinApplication();
			return 0;
		} else if (args[1] == "traveler") {
			TravelerApplication();
			return 0;
		}
	}
	Application();
	return 0;
}
