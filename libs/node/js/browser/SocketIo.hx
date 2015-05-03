package js.browser;

import js.npm.socketio.Listener;
import js.npm.socketio.Namespace;

@:native("io") extern class SocketIo 
{
	public static function connect(?host:String, ?details:Dynamic):Namespace;
	public static var version:String;
	public static var protocol:Int;
	public static var transports:Array<Dynamic>;

	public static function Socket(options:Dynamic):Void;
}

extern class Socket 
{
	public static function Socket(options:Dynamic):Void;

	public var connected:Bool;
	public var open:Bool;
	public var connecting:Bool;
	public var reconnecting:Bool;
	public var namespaces:Dynamic;
	public var buffer:Array<Dynamic>;
	public var doBuffer:Bool;

	public function of(name:String):Namespace;
	public function connect(?fn:Void -> Void):Socket;
	public function packet(data:Dynamic):Socket;
	public function disconnect():Socket;

	public function addListener(event:String, fn:Listener ):Dynamic;
	public function on(event:String, fn:Listener):Dynamic;
	public function once(event:String, fn:Listener):Void;
	public function removeListener(event:String, listener:Listener):Void;
	public function removeAllListeners(event:String):Void;
	public function listeners(event:String):Array<Listener>;
	public function setMaxListeners(m:Int):Void;
	public function emit(event:String, ?arg1:Dynamic, ?arg2:Dynamic, ?arg3:Dynamic):Void;
}

extern class Flag 
{
	public function send():Void;
	public function emit():Void;
}