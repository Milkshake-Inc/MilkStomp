package components.entity.player;

import milkshake.components.input.Input;
import milkshake.components.input.Key;
import milkshake.utils.TweenUtils;

class LocalPlayer extends Player
{
	private var input:Input;

	private var MOVE_LEFT_KEY:Int;
	private var MOVE_RIGHT_KEY:Int;
	private var MOVE_UP_KEY:Int;
	private var MOVE_STOMP_KEY:Int;

	

	public function new(playerIndex:Int, input:Input)
	{
		super(playerIndex, "localPlayer");

		this.input = input;	
	}

	private function handleInput():Void
	{
		if(MOVE_UP_KEY == null || MOVE_RIGHT_KEY == null || MOVE_UP_KEY == null) return;

		var sign = 0;
		if(input.isDown(MOVE_LEFT_KEY)) sign = -1;
		if(input.isDown(MOVE_RIGHT_KEY)) sign = 1;

		if(isStomping) sign = 0;

		var acceleration:Float = 0.004;
		var turnMultiplier:Float = 0.5;

		acceleration *= turnMultiplier;

		velocity.x += acceleration * sign * 60;

		velocity.x = milkshake.utils.MathHelper.clamp(velocity.x, -0.8, 0.8);

		if(sign == 0) velocity.x *= 0.6;

		if(isFloored && input.isDown(MOVE_UP_KEY)) velocity.y = -Globals.PLAYER_JUMP_VELOCITY;

		if(!isFloored && !isStomping && input.isDown(MOVE_STOMP_KEY))
		{
			velocity.y = 1.5;
		}

		if(sign != 0)
		{
			this.asset.scale.x = sign * -1;
		}

		if(isStomping && isFloored) isStomping = false;
	}

	override public function update(deltaTime:Float):Void
	{
		handleInput();

		super.update(deltaTime);
	}
}
