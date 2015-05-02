package ;

import milkshake.Milkshake;
import milkshake.utils.Globals;
import scenes.BasicScene;

@:expose
class Stomp
{
	static function main()
	{
		var milkshake = Milkshake.boot(new Settings(Globals.SCREEN_WIDTH, Globals.SCREEN_HEIGHT));

		milkshake.scenes.addScene(new BasicScene());
	}
}