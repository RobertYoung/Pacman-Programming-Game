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
		
		var queue:LoaderMax;
		var level:Level;
		
		public function Main() {
			this.GoToMenu();
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
			
			queue = new LoaderMax({ name:"mainQueue", onComplete: LevelSelectionComplete });
			
			queue.append(new SWFLoader(Game.SWF_LOGO + ".swf", {name: Game.SWF_LOGO, container:this}));
			queue.append(new SWFLoader(Game.SWF_LEVEL_SELECTION + ".swf", {name: Game.SWF_LEVEL_SELECTION, container:this}));
			queue.append(new SWFLoader(Game.SWF_BACK_BUTTON + ".swf", {name: Game.SWF_BACK_BUTTON, container:this}));			
			
			queue.load();
		}
		
		private function LevelSelectionComplete(e:LoaderEvent)
		{
			var levelSelection:LevelSelection = LoaderMax.getContent(Game.SWF_LEVEL_SELECTION).rawContent as LevelSelection;
			
			levelSelection.Init();
		}
		
		public function GoToLevel(setStageNumber:int, setLevelNumber:int)
		{
			this.RemoveChildren();
			
			level = new Level(this, "../assets/levels/level" + setStageNumber + "-" + setLevelNumber + ".json");

			var game:Game = new Game(level);
			
			game.name = Game.SWF_GAME;
			
			this.addChild(game);
		}
	}
}
