package components.entity.player;

import milkshake.components.input.Input;
import milkshake.components.input.Key;

class ArrowKeysLocalPlayer extends LocalPlayer
{
	public function new(playerIndex:Int, input:Input)
	{
		super(playerIndex, input);

		MOVE_LEFT_KEY = Key.LEFT;
		MOVE_RIGHT_KEY = Key.RIGHT;
		MOVE_UP_KEY = Key.UP;
		MOVE_STOMP_KEY = Key.DOWN;
	}
}