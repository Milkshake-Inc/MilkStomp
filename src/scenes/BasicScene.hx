package scenes;

import components.entity.EntityComponent;
import differ.Collision;
import differ.shapes.Polygon;
import differ.shapes.Shape;
import milkshake.core.Graphics;
import milkshake.game.scene.camera.CameraPresets;
import milkshake.game.scene.Scene;
import milkshake.game.tile.renderers.BoltTileMapRenderer;
import milkshake.game.tile.TileMap;
import milkshake.game.tile.TileMapCollision;
import milkshake.game.tile.TileMapData;
import milkshake.utils.Color;
import pixi.BaseTexture;

using Lambda;

class BasicScene extends Scene
{
	var entityComponent:EntityComponent;
	var tilemapCollision(default, null):TileMapCollision;
	
	var graphics:Graphics;

	public function new()
	{
		super("BasicScene", [ "assets/tilesheets/main.png", "assets/sprites/character.png" ], CameraPresets.DEFAULT, Color.BLUE);
	}

	override public function create():Void
	{
		super.create();

		var clear = new Graphics();
		clear.begin(0x76D3DE);
		clear.drawRectangle(new pixi.Rectangle(0, 0, 1920, 1080));
		addNode(clear);

		var tileMapData = TileMapData.fromCSV(CompileTime.readFile("assets/tilemaps/main.csv"));

		addNode(new TileMap(tileMapData, new BoltTileMapRenderer(BaseTexture.fromImage("assets/tilesheets/main.png"), 64, false, false)));
		addNode(tilemapCollision = new TileMapCollision(tileMapData, 64));

		addNode(entityComponent = new EntityComponent());
		// Debug
		addNode(graphics = new Graphics());
	}

	override public function update(deltaTime:Float):Void
	{
		super.update(deltaTime);
	
		for(player in entityComponent.players) 
		{
			if(player.isDead) continue;

			var results = Collision.shapeWithShapes(player.body, cast tilemapCollision.rectangles);

			for(result in results)
			{
				player.body.x += result.separation.x;
				player.body.y += result.separation.y;

				player.updateBody();

				if(result.separation.y != 0) player.velocity.y = 0;
			}

			var floorResults = Collision.shapeWithShapes(player.feet, cast tilemapCollision.rectangles);
			player.isFloored = floorResults.length > 0;
		}
		for(playerA in entityComponent.players) 
		{
			for(playerB in entityComponent.players) 
			{
				if(playerA != playerB && !playerA.isDead && !playerB.isDead)
				{
					var result = Collision.shapeWithShape(playerA.feet, playerB.head);

					if(result != null)
					{
						if(!playerB.isDead && playerA.velocity.y > 0)
						{
							playerB.kill();
							playerA.velocity.y = -1;
						}
					}
				}
			}
		}

		// debugRender();
	}

	function debugRender()
	{
		graphics.clear();

		graphics.begin(Color.RED, 0.1, 1, Color.RED);
		tilemapCollision.rectangles.iter(drawPolygon.bind(graphics));

		for(player in entityComponent.players) 
		{
			if(player.isDead) continue;

			graphics.begin(Color.RED, 0.1, 1, Color.GREEN);
			drawPolygon(graphics, cast player.body);

			graphics.begin(Color.RED, 0.1, 1, Color.BLACK);
			drawPolygon(graphics, cast player.head);

			graphics.begin(Color.RED, 0.1, 1, Color.BLACK);
			drawPolygon(graphics, cast player.feet);
		}
	}

	function drawPolygon(graphics:Graphics, shape:Polygon)
	{
		for(index in 0 ... shape.transformedVertices.length)
		{
			var pointA = shape.transformedVertices[index];
			var pointB = index + 1 < shape.transformedVertices.length ? shape.transformedVertices[index + 1] : shape.transformedVertices[0];

			graphics.graphics.moveTo(pointA.x, pointA.y);
			graphics.graphics.lineTo(pointB.x, pointB.y);
		}
	}
}