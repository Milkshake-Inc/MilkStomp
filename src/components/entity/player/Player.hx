package components.entity.player;

import differ.shapes.Polygon;
import differ.shapes.Shape;
import milkshake.math.Vector2;
import milkshake.core.DisplayObject;
import milkshake.core.Sprite;
import milkshake.utils.TweenUtils;
import pixi.BaseTexture;
import pixi.Texture;

class Player extends DisplayObject
{
	public var body(default, null):Shape;
	public var head(default, null):Polygon;
	public var feet(default, null):Shape;

	public var isDead:Bool;

	public var velocity:Vector2;

	private var asset:Sprite;

	public var isFloored:Bool;
	var isStomping:Bool = false;

	var textureMap:Map<String, Texture>;

	public function new(id:String)
	{
		super(id);

		var baseTexture = BaseTexture.fromImage("assets/sprites/character.png");

		var playerIndex:Int = Math.round(Math.random() * 4);

		textureMap = new Map();
		textureMap.set("idle", new Texture(baseTexture, new pixi.Rectangle(0, 32 * playerIndex, 32, 32)));
		textureMap.set("jump", new Texture(baseTexture, new pixi.Rectangle(32, 32 * playerIndex, 32, 32)));
		textureMap.set("fall", new Texture(baseTexture, new pixi.Rectangle(32 * 2, 32 * playerIndex, 32, 32)));
		textureMap.set("stomp", new Texture(baseTexture, new pixi.Rectangle(32 * 3, 32 * playerIndex, 32, 32)));
		textureMap.set("dead", new Texture(baseTexture, new pixi.Rectangle(32 * 4, 32 * playerIndex, 32, 32)));

		asset = new Sprite(textureMap.get("idle"));
		asset.anchor = new Vector2(0.5, 0);
		// asset.pivot = new Vector2(16, 16);
		asset.x = 16;
		// asset.y = 16;

		addNode(asset);
		
		head = Polygon.rectangle(0, 0, 26, 4, false);
		body = Polygon.square(0, 0, 32, false);
		feet = Polygon.rectangle(0, 0, 26, 4, false);
		
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

	public function kill():Void
	{
		isDead = true;

		TweenUtils.tween(asset, 0.5, { rotation: 3.14 });
		TweenUtils.tween(this, 0.5, { y: this.y - 100 });
		haxe.Timer.delay(function()
		{
			TweenUtils.tween(this, 3, { y: this.y + 720 });
			haxe.Timer.delay(function()
			{
				this.isDead = false;
				this.body.x = 100;
				this.body.y = 0;
				this.asset.rotation = 0;
			}, 3000);
		}, 500);
	}
	
	override public function update(deltaTime:Float):Void
	{
		//update position to last frame's body position		
	
		if(!isDead)
		{
			updateBody();

			velocity = velocity.add(Vector2.DOWN.multiSingle(Globals.PLAYER_GRAVITY));
			body.x += velocity.x * deltaTime;
			body.y += velocity.y * deltaTime;

			checkPlayerBoundaries();
		}

		this.asset.sprite.texture = textureMap.get("idle");
		if(velocity.y < Globals.PLAYER_GRAVITY) this.asset.sprite.texture = textureMap.get("jump");
		if(velocity.y >  Globals.PLAYER_GRAVITY) this.asset.sprite.texture = textureMap.get("fall");
		if(this.isStomping) this.asset.sprite.texture = textureMap.get("stomp");
		if(this.isDead) this.asset.sprite.texture = textureMap.get("dead");

		super.update(deltaTime);
	}

	public function updateBody()
	{
		position.x = body.x;
		position.y = body.y;

		head.x = body.x + 3;
		head.y = body.y - 3;

		feet.x = body.x + 3;
		feet.y = body.y + 32;

		
	}
}
