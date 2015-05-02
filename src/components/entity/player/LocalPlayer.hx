package components.entity.player;

import milkshake.components.input.Input;
import milkshake.components.input.Key;

class LocalPlayer extends Player
{
	private var input:Input;

	public function new(input:Input)
	{
		super("assets/sprites/player.png", "localPlayer");

		this.input = input;
	}

	private function handleInput():Void
	{
		if(input.isDown(Key.LEFT)) velocity.x = -Globals.PLAYER_LEFT_SPEED;
		if(input.isDown(Key.RIGHT)) velocity.x = Globals.PLAYER_RIGHT_SPEED;
		if(input.isEitherDown([Key.RIGHT, Key.SPACE])) velocity.y = -Globals.PLAYER_JUMP_VELOCITY;
	}

	override public function update(deltaTime:Float):Void
	{
		handleInput();
		
		super.update(deltaTime);
	}
}
