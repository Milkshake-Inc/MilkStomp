package components.entity;

import components.entity.player.WASDKeysLocalPlayer;
import components.entity.player.ArrowKeysLocalPlayer;
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
			new ArrowKeysLocalPlayer(0, new Input()),
			new WASDKeysLocalPlayer(3, new Input())
		];
		
		players[1].body.x = 500;
		
		for(player in players) addNode(player);
	}
}