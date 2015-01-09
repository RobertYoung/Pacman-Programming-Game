package com.game.scenes  {
	
	import flash.display.MovieClip;
/*	import flash.display.Loader;
	import flash.net.URLRequest;
	import com.game.factory.Game;
	
	import flash.system.Security;
	import flash.text.TextField;*/
	
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.events.LoaderEvent;
	import com.game.factory.Game;
	import com.game.elements.Level;
	import com.greensock.loading.data.SWFLoaderVars;
	import com.game.scenes.PacmanStage;
	
	public class Main extends MovieClip {
		
		//public var game:Game;
		
		var queue:LoaderMax;
		var level:Level;
		
		public function Main() {
			//flash.system.Security.allowDomain("*");

			//BuildLevel();
			
			queue = new LoaderMax({ name:"mainQueue" });
		
			queue.append(new SWFLoader(Game.SWF_LOGO + ".swf", {name: Game.SWF_LOGO, container:this}));
			queue.append(new SWFLoader(Game.SWF_MENU + ".swf", {name: Game.SWF_MENU, container:this}));
			
			queue.load();
		}
		
		private function RemoveChildren()
		{
			for (var i = (this.numChildren - 1); i >= 0; i--)
			{
				this.removeChildAt(i);
			}
		}
		
		public function GoToMenu()
		{
			this.RemoveChildren();
			
			queue = new LoaderMax({ name:"mainQueue" });
			
			queue.append(new SWFLoader(Game.SWF_LOGO + ".swf", {name: Game.SWF_LOGO, container:this}));
			queue.append(new SWFLoader(Game.SWF_MENU + ".swf", {name: Game.SWF_MENU, container:this}));
			
			queue.load();
		}
		
		public function GoToLevelSelection()
		{
			this.RemoveChildren();
			
			queue = new LoaderMax({ name:"mainQueue" });
			
			queue.append(new SWFLoader(Game.SWF_LOGO + ".swf", {name: Game.SWF_LOGO, container:this}));
			queue.append(new SWFLoader(Game.SWF_LEVEL_SELECTION + ".swf", {name: Game.SWF_LEVEL_SELECTION, container:this}));
			
			queue.load();
		}
		
		public function GoToLevel(setStageNumber:int, setLevelNumber:int)
		{
			this.RemoveChildren();
			
			level = new Level(this, "../assets/levels/level" + setStageNumber + "-" + setLevelNumber + ".json");
			
			/*queue = new LoaderMax({ name:"mainQueue", onComplete: BuildLevel});
			
			/*
			queue.append(new SWFLoader(Game.SWF_HEADER + ".swf", {name: Game.SWF_LOGO, container:this}));
			queue.append(new SWFLoader(Game.SWF_PACMAN_STAGE + ".swf", {name: Game.SWF_PACMAN_STAGE, container:this}));
			queue.append(new SWFLoader(Game.SWF_PACMAN_CODING_AREA + ".swf", {name: Game.SWF_PACMAN_CODING_AREA, container:this}));
			queue.append(new SWFLoader(Game.SWF_CONTROLS + ".swf", {name: Game.SWF_CONTROLS, container:this}));
			
			
			queue.append(new SWFLoader(Game.SWF_GAME + ".swf", {name: Game.SWF_GAME, container:this}));
			
			queue.load();
			*/
			
			var game:Game = new Game(level);
			
			game.name = Game.SWF_GAME;
			
			this.addChild(game);
		}
		
		/*
		private function BuildLevel(event:LoaderEvent)
		{
			var pacmanStage:PacmanStage = new PacmanStage(level);

			pacmanStage.x = 280;
			pacmanStage.y = 400;
			pacmanStage.name = Game.SWF_PACMAN_STAGE;

			this.addChildAt(pacmanStage, 1);
		}
		*/
		
		/*
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
			this.removeChild(this.getChildByName(Game.SWF_CONTROLS));
			
			var queue:LoaderMax = new LoaderMax({ name:"mainQueue" });
		
			queue.append(new SWFLoader("header.swf", {name: Game.SWF_HEADER, container:this}));
			queue.append(new SWFLoader("pacman_stage.swf", {name: Game.SWF_PACMAN_STAGE, container:this}));
			//queue.append(new SWFLoader("pacman_code.swf", {name: Game.SWF_PACMAN_CODING_AREA, container:this}));
			queue.append(new SWFLoader("controls.swf", {name: Game.SWF_CONTROLS, container:this}));
			
			queue.load();
		}
		*/
	}
}
