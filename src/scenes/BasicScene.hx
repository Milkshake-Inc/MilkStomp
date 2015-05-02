package scenes;

import components.entity.EntityComponent;
import differ.Collision;
import milkshake.core.Graphics;
import milkshake.game.scene.camera.CameraPresets;
import milkshake.game.scene.Scene;
import milkshake.game.tile.renderers.BoltTileMapRenderer;
import milkshake.game.tile.TileMap;
import milkshake.game.tile.TileMapCollision;
import milkshake.game.tile.TileMapData;
import milkshake.utils.Color;
import pixi.BaseTexture;
import pixi.Rectangle;

class BasicScene extends Scene
{
	var entityComponent:EntityComponent;		
	var tilemapCollision(default, null):TileMapCollision;
	
	var graphics:Graphics;

	public function new()
	{
		super("BasicScene", [ "assets/tilesheets/main.png" ], CameraPresets.DEFAULT, Color.BLUE);
	}

	override public function create():Void
	{
		super.create();

		var tileMapData = TileMapData.fromCSV(CompileTime.readFile("assets/tilemaps/main.csv"));
		var tilemap = new TileMap(tileMapData, new BoltTileMapRenderer(BaseTexture.fromImage("assets/tilesheets/main.png"), 64, true, false));

		addNode(new TileMap(tileMapData, new BoltTileMapRenderer(BaseTexture.fromImage("assets/tilesheets/main.png"), 64, true, false)));
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
			var results = Collision.shapeWithShapes(player.body, cast tilemapCollision.rectangles);

			for(result in results)
			{
				player.body.x += result.separation.x;
				player.body.y += result.separation.y;

				player.velocity.y = 0;
			}
		}

		debugRender();
		
	}

	function debugRender()
	{
		graphics.clear();
		graphics.begin(Color.RED, 0.1, 1, Color.RED);

		for(rectangle in tilemapCollision.rectangles)
		{
			for(index in 0 ... rectangle.transformedVertices.length)
			{
				var pointA = rectangle.transformedVertices[index];
				var pointB = index + 1 < rectangle.transformedVertices.length ? rectangle.transformedVertices[index + 1] : rectangle.transformedVertices[0];

				graphics.graphics.moveTo(pointA.x, pointA.y);
				graphics.graphics.lineTo(pointB.x, pointB.y);
			}
		}

		for(player in entityComponent.players) graphics.graphics.drawRect(player.body.x, player.body.y, 64, 64);
	}
}