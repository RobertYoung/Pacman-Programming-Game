package com.game.scenes  {
	
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import com.game.factory.Game;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.events.LoaderEvent;
	import flash.system.Security;
	import flash.text.TextField;
	
	public class Main extends MovieClip {
		
		public var game:Game;
		
		public function Main() {
			flash.system.Security.allowDomain("*");

			BuildLevel();
		}
		
		public function BuildLevel()
		{
			game = new Game(this);

			var queue:LoaderMax = new LoaderMax({ name:"mainQueue" });
		
			queue.append(new SWFLoader("header.swf", {name: Game.SWF_HEADER, container:this}));
			queue.append(new SWFLoader("pacman_stage.swf", {name: Game.SWF_PACMAN_STAGE, container:this}));
			queue.append(new SWFLoader("pacman_code.swf", {name: Game.SWF_PACMAN_CODING_AREA, container:this}));
			queue.append(new SWFLoader("controls.swf", {name: Game.SWF_CONTROLS, container:this}));
			
			queue.load();
		}
		
		public function ReloadLevel()
		{
			game.ResetAllAnimations();
			
			game = new Game(this);
			
			this.removeChild(this.getChildByName(Game.SWF_HEADER));
			this.removeChild(this.getChildByName(Game.SWF_PACMAN_STAGE));
			this.removeChild(this.getChildByName(Game.SWF_PACMAN_CODING_AREA));
			this.removeChild(this.getChildByName(Game.SWF_CONTROLS));
			
			BuildLevel();
		}
		
		public function ResetAfterUserError()
		{
			game = new Game(this);
			
			this.removeChild(this.getChildByName(Game.SWF_HEADER));
			this.removeChild(this.getChildByName(Game.SWF_PACMAN_STAGE));
			
			var queue:LoaderMax = new LoaderMax({ name:"mainQueue" });
		
			queue.append(new SWFLoader("header.swf", {name: Game.SWF_HEADER, container:this}));
			queue.append(new SWFLoader("pacman_stage.swf", {name: Game.SWF_PACMAN_STAGE, container:this}));
			//queue.append(new SWFLoader("pacman_code.swf", {name: Game.SWF_PACMAN_CODING_AREA, container:this}));
			//queue.append(new SWFLoader("controls.swf", {name: Game.SWF_CONTROLS, container:this}));
			
			queue.load();
		}
	}
}
