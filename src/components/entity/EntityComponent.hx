package components.entity;

import components.entity.player.LocalPlayer;
import components.entity.player.Player;
import milkshake.components.input.Input;
import milkshake.core.DisplayObject;

class EntityComponent extends DisplayObject
{
	public var players(default, null):Array<Player>;

	public function new()
	{
		super("entityComponent");
		
		players = [
			new LocalPlayer(new Input())
		];
		
		for(player in players) addNode(player);
	}
}