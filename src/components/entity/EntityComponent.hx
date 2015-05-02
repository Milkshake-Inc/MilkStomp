package components.entity;

import components.entity.player.LocalPlayer;
import components.entity.player.Player;
import milkshake.core.DisplayObject;

class EntityComponent extends DisplayObject
{
	public var players(default, null):Array<Player>;

	public function new()
	{
		super("entityComponent");
		
		players = [
			new LocalPlayer()
		];
		
		for(player in players) addNode(player);
	}
}