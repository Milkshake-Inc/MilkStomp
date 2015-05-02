package components.entity.player;

import milkshake.components.input.Input;
import milkshake.components.input.Key;

class LocalPlayer extends Player
{
	private var input:Input;

	private var MOVE_LEFT_KEY:Int;
	private var MOVE_RIGHT_KEY:Int;
	private var MOVE_UP_KEY:Int;

	public function new(input:Input)
	{
		super("assets/sprites/player.png", "localPlayer");

		this.input = input;
		
	}

	private function handleInput():Void
	{
		if(MOVE_UP_KEY == null || MOVE_RIGHT_KEY == null || MOVE_UP_KEY == null) return;
		
		velocity.x = 0;
		if(input.isDown(MOVE_LEFT_KEY)) velocity.x = -Globals.PLAYER_LEFT_SPEED;
		if(input.isDown(MOVE_RIGHT_KEY)) velocity.x = Globals.PLAYER_RIGHT_SPEED;
		if(isFloored && input.isDown(MOVE_UP_KEY)) velocity.y = -Globals.PLAYER_JUMP_VELOCITY;
	}

	override public function update(deltaTime:Float):Void
	{
		handleInput();
		super.update(deltaTime);
	}
}
