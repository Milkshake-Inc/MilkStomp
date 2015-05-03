package components.entity.player;

import milkshake.components.input.Input;
import milkshake.components.input.Key;

class WASDKeysLocalPlayer extends LocalPlayer
{
	public function new(playerIndex:Int, input:Input)
	{
		super(playerIndex, input);

		MOVE_LEFT_KEY = Key.A;
		MOVE_RIGHT_KEY = Key.D;
		MOVE_UP_KEY = Key.W;
		MOVE_STOMP_KEY = Key.S;
	}
}
