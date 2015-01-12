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
	import flash.events.MouseEvent
	import com.game.factory.UserData;
	
	public class Main extends MovieClip {
		
		var queue:LoaderMax;
		var level:Level;
		var stageNumber:int;
		
		public function Main() {
			this.GoToMenu();
			this.SetupUserLocalData();
		}
		
		private function SetupUserLocalData()
		{
			UserData.getInstance();
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
		
		public function GoToLevelSelection(e:MouseEvent = null, withStageNumber:int = 0)
		{
			this.RemoveChildren();
			
			queue = new LoaderMax({ name:"mainQueue", onComplete: LevelSelectionComplete });
			
			queue.append(new SWFLoader(Game.SWF_LOGO + ".swf", {name: Game.SWF_LOGO, container:this}));
			queue.append(new SWFLoader(Game.SWF_LEVEL_SELECTION + ".swf", {name: Game.SWF_LEVEL_SELECTION, container:this}));
			queue.append(new SWFLoader(Game.SWF_BACK_BUTTON + ".swf", {name: Game.SWF_BACK_BUTTON, container:this}));			
			
			queue.load();
			
			this.stageNumber = withStageNumber;
		}
		
		function LevelSelectionComplete(e:LoaderEvent)
		{
			var levelSelection:LevelSelection = LoaderMax.getContent(Game.SWF_LEVEL_SELECTION).rawContent as LevelSelection;
			
			levelSelection.Init();
			
			if (this.stageNumber != 0)
				levelSelection.GoToLevelSelection(this.stageNumber);
			
			trace("Level Number: " + this.stageNumber);
		}
		
		public function GoToLevel(setStageNumber:int, setLevelNumber:int)
		{
			this.RemoveChildren();
			
			level = new Level(this, setStageNumber, setLevelNumber);

			var game:Game = new Game(level);
			
			game.name = Game.SWF_GAME;
			
			this.addChild(game);
		}
	}
}
