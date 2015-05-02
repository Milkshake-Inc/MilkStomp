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
		
		body = Polygon.square(0, 0, height, false);
		
		velocity = Vector2.ZERO;
	}
	
	override public function update(deltaTime:Float):Void
	{
		super.update(deltaTime);
		
		velocity = velocity.add(Vector2.DOWN.multiSingle(Globals.GRAVITY));
		
		body.x += velocity.x * deltaTime;
		body.y += velocity.y * deltaTime;
		
		if(body.y > Globals.GAME_HEIGHT) {
			body.y = -height;
		}
		
		position.x = body.x;
		position.y = body.y;
	}
}
