package scenes;

import milkshake.core.Graphics;
import milkshake.game.scene.camera.CameraPresets;
import milkshake.game.scene.Scene;
import milkshake.utils.Color;
import pixi.Rectangle;

class BasicScene extends Scene
{
	public function new()
	{
		super("BasicScene", [ ], CameraPresets.DEFAULT, Color.BLUE);
	}

	override public function create():Void
	{
		super.create();

		var graphics = new Graphics();
		graphics.begin(0xFF0000);
		graphics.drawRectangle(new Rectangle(0, 0, 100, 100));

		addNode(graphics);
	}

	override public function update(deltaTime:Float):Void
	{
		super.update(deltaTime);
	}
}