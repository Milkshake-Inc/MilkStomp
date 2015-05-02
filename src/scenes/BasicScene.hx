package scenes;

import milkshake.core.Graphics;
import milkshake.core.Sprite;
import milkshake.game.scene.camera.CameraPresets;
import milkshake.game.scene.Scene;
import milkshake.game.tile.renderers.BoltTileMapRenderer;
import milkshake.game.tile.TileMap;
import milkshake.game.tile.TileMapData;
import milkshake.utils.Color;
import pixi.BaseTexture;
import pixi.Rectangle;

class BasicScene extends Scene
{
	public function new()
	{
		super("BasicScene", [ "assets/tilesheets/main.png" ], CameraPresets.DEFAULT, Color.BLUE);
	}

	override public function create():Void
	{
		super.create();

		var tileMapData = TileMapData.fromCSV(CompileTime.readFile("assets/tilemaps/main.csv"));
		var tilemap = new TileMap(tileMapData, new BoltTileMapRenderer(BaseTexture.fromImage("assets/tilesheets/main.png"), 64, true, false));

		addNode(tilemap);

		var player = Sprite.fromUrl("assets/sprites/player.png");

		addNode(player);
	}

	override public function update(deltaTime:Float):Void
	{
		super.update(deltaTime);
	}
}