package components.entity.player;

import differ.shapes.Polygon;
import differ.shapes.Shape;
import milkshake.math.Vector2;
import milkshake.core.DisplayObject;
import milkshake.core.Sprite;

class Player extends DisplayObject
{
	public var velocity:Vector2;

	public var body:Shape;

	private var asset:Sprite;

	public function new(assetUrl:String, id:String)
	{
		super(id);

		asset = Sprite.fromUrl(assetUrl);
		addNode(asset);
		
		body = Polygon.square(0, 0, Globals.PLAYER_HEIGHT, false);
		
		velocity = Vector2.ZERO;
	}
	
	private function checkPlayerBoundaries():Void
	{
		if(body.y > Globals.GAME_HEIGHT)
		{
			body.y = -height;
		}

		if(body.y < -height)
		{
			body.y = Globals.GAME_HEIGHT;
		}

		if(body.x > Globals.GAME_WIDTH)
		{
			body.x = -width;
		}

		if(body.x < -width)
		{
			body.x = Globals.GAME_WIDTH;
		}
	}
	
	override public function update(deltaTime:Float):Void
	{
		//update position to last frame's body position
		position.x = body.x;
		position.y = body.y;
	
		velocity = velocity.add(Vector2.DOWN.multiSingle(Globals.PLAYER_GRAVITY));
		
		body.x += velocity.x * deltaTime;
		body.y += velocity.y * deltaTime;
		
		checkPlayerBoundaries();

		super.update(deltaTime);
	}
}
