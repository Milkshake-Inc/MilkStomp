package components.entity.player;

import milkshake.components.input.Input;
import milkshake.components.input.Key;

class ArrowKeysLocalPlayer extends LocalPlayer
{
	public function new(input:Input)
	{
		super(input);

		MOVE_LEFT_KEY = Key.LEFT;
		MOVE_RIGHT_KEY = Key.RIGHT;
		MOVE_UP_KEY = Key.UP;
	}
}
