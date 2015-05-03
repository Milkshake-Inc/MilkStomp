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

	public function new(playerIndex:Int, id:String)
	{
		super(id);

		var baseTexture = BaseTexture.fromImage("assets/sprites/character.png");

		textureMap = new Map();
		textureMap.set("idle", new Texture(baseTexture, new pixi.Rectangle(0, 64 * playerIndex, 64, 64)));
		textureMap.set("jump", new Texture(baseTexture, new pixi.Rectangle(64, 64 * playerIndex, 64, 64)));
		textureMap.set("fall", new Texture(baseTexture, new pixi.Rectangle(64 * 2, 64 * playerIndex, 64, 64)));
		textureMap.set("stomp", new Texture(baseTexture, new pixi.Rectangle(64 * 3, 64 * playerIndex, 64, 64)));
		textureMap.set("dead", new Texture(baseTexture, new pixi.Rectangle(64 * 4, 64 * playerIndex, 64, 64)));

		asset = new Sprite(textureMap.get("idle"));
		asset.anchor = new Vector2(0.5, 0);
		// asset.pivot = new Vector2(16, 16);
		asset.x = 32;
		// asset.y = 16;

		addNode(asset);
		
		head = Polygon.rectangle(0, 0, 58, 20, false);
		body = Polygon.square(0, 0, 64, false);
		feet = Polygon.rectangle(0, 0, 58, 20, false);
		
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
			TweenUtils.tween(this, 3, { y: this.y + (1080 + 400 - y) });
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

			velocity.y = milkshake.utils.MathHelper.clamp(velocity.y, -2, 1.5);
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
		feet.y = body.y + 64 - 10;

		
	}
}
