package com.game.scenes  {
	
	import flash.display.MovieClip;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.events.LoaderEvent;
	import com.game.factory.Game;
	import com.game.elements.Level;
	import com.greensock.loading.data.SWFLoaderVars;
	import com.game.scenes.PacmanStage;
	import flash.events.MouseEvent
	import com.game.factory.PacmanSharedObjectHelper;
	import flash.text.TextField;
	import com.game.factory.PacmanWebService;
	import com.game.factory.LevelData;
	import flash.geom.Point;
	import com.game.elements.LoadingView;
	
	public class Main extends MovieClip {
		
		var queue:LoaderMax;
		var level:Level;
		var stageNumber:int;
		//var pacmanService:PacmanWebService;
		var firstLoad:Boolean = true;
		
		public function Main() {
			this.GoToLogin();
			this.SetupUserLocalData();
			//this.pacmanService = PacmanWebService.getInstance();
		}
		
		private function SetupUserLocalData()
		{
			PacmanSharedObjectHelper.getInstance();
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
			
			if (firstLoad)
			{
				firstLoad = false;
				this.addChild(loadingView);
				this.GetDataFromWebService();
				PacmanSharedObjectHelper.getInstance().SetWebServiceConnect(true);
			}
		}

		private var levelsArray:Array = [ new Point(1,1), new Point(1,2), new Point(1,3), new Point(1,4), new Point(1,5), new Point(1,6),
											new Point(2,1), new Point(2,2), new Point(2,3), new Point(2,4), new Point(2,5), new Point(2,6),
											new Point(3,1), new Point(3,2), new Point(3,3), new Point(3,4), new Point(3,5), new Point(3,6) ];
		private var arrayPoint:int = 0;
		private var loadingView:LoadingView = new LoadingView();
		
		private function GetDataFromWebService()
		{
			/*
			// Get all data from webservice and store to shared object
			for (var stageNum = 1; stageNum <= 3; stageNum++)
			{
				for (var levelNum = 1; levelNum <= 6; levelNum++)
				{
					var pacmanWebService:PacmanWebService = new PacmanWebService();

					pacmanWebService.GetLevelData(stageNum, levelNum, SaveLevelDataToSharedObject);
				}
			}
			*/
			
			this.GetLevelsData();
			this.GetAchievementsData();
		}
		
		private function GetAchievementsData()
		{
			var pacmanWebService:PacmanWebService = new PacmanWebService();
			
			pacmanWebService.GetTimeAchievements(this.SetAchievementsData);
		}
		
		private function SetAchievementsData(achievements:Object)
		{
			var pacmanSharedObject:PacmanSharedObjectHelper = PacmanSharedObjectHelper.getInstance();
			
			if (achievements.TimeAchievement1Completed == true)
				pacmanSharedObject.SetTimeAchievement(1);
			if (achievements.TimeAchievement2Completed == true)
				pacmanSharedObject.SetTimeAchievement(2);
			if (achievements.TimeAchievement3Completed == true)
				pacmanSharedObject.SetTimeAchievement(3);
			if (achievements.TimeAchievement4Completed == true)
				pacmanSharedObject.SetTimeAchievement(4);
			if (achievements.TimeAchievement5Completed == true)
				pacmanSharedObject.SetTimeAchievement(5);
			if (achievements.TimeAchievement6Completed == true)
				pacmanSharedObject.SetTimeAchievement(6);
		}
		
		private function GetLevelsData()
		{
			var levelPoint:Point = levelsArray[arrayPoint];
			
			if (levelPoint != null)
			{
				var pacmanWebService:PacmanWebService = new PacmanWebService();

				pacmanWebService.GetLevelData(levelPoint.x, levelPoint.y, SaveLevelDataToSharedObject);
			}else{
				arrayPoint = 0;
			}
		}
		
		private function SaveLevelDataToSharedObject(levelData:LevelData)
		{
			arrayPoint++;
			
			if (arrayPoint == 18)
			{
				this.removeChild(loadingView);
			}

			var stageNum:int = levelData.stageNumber;
			var levelNum:int = levelData.levelNumber;
			
			PacmanSharedObjectHelper.getInstance().SetLevelData(stageNum, levelNum, levelData);
			
			this.GetLevelsData();
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
		}
		
		public function GoToLevel(setStageNumber:int, setLevelNumber:int)
		{
			this.RemoveChildren();
			
			level = new Level(this, setStageNumber, setLevelNumber);

			var game:Game = new Game(level);
			
			game.name = Game.SWF_GAME;
			
			this.addChild(game);
		}
		
		public function GoToAchievements()
		{
			this.RemoveChildren();
			
			queue = new LoaderMax({ name:"mainQueue", onComplete: AchievementsComplete });
			
			queue.append(new SWFLoader(Game.SWF_ACHIEVEMENTS + ".swf", {name: Game.SWF_ACHIEVEMENTS, container:this}));
			queue.append(new SWFLoader(Game.SWF_LOGO + ".swf", {name: Game.SWF_LOGO, container:this}));
			queue.append(new SWFLoader(Game.SWF_BACK_BUTTON + ".swf", {name: Game.SWF_BACK_BUTTON, container:this}));	
			
			queue.load();
		}
		
		private function AchievementsComplete(e:LoaderEvent)
		{
			var achievements:Achievements = LoaderMax.getContent(Game.SWF_ACHIEVEMENTS).rawContent as Achievements;
			
			achievements.Init();
		}
		
		public function GoToHelp()
		{
			this.RemoveChildren();
			
			queue = new LoaderMax({ name:"mainQueue", onComplete: HelpComplete });
			
			queue.append(new SWFLoader(Game.SWF_HELP + ".swf", {name: Game.SWF_HELP, container:this}));
			queue.append(new SWFLoader(Game.SWF_LOGO + ".swf", {name: Game.SWF_LOGO, container:this}));
			queue.append(new SWFLoader(Game.SWF_BACK_BUTTON + ".swf", {name: Game.SWF_BACK_BUTTON, container:this}));	
			
			queue.load();
		}
		
		private function HelpComplete(e:LoaderEvent)
		{
			var help:Help = LoaderMax.getContent(Game.SWF_HELP).rawContent as Help;
			
			help.Init();
		}
		
		private function GoToLogin()
		{
			this.RemoveChildren();
			
			queue = new LoaderMax({ name:"mainQueue", onComplete: LoginComplete });
			
			queue.append(new SWFLoader(Game.SWF_LOGIN + ".swf", {name: Game.SWF_LOGIN, container:this}));
			queue.append(new SWFLoader(Game.SWF_LOGO + ".swf", {name: Game.SWF_LOGO, container:this}));
			
			queue.load();
		}
		
		private function LoginComplete(e:LoaderEvent)
		{
			var login:Login = LoaderMax.getContent(Game.SWF_LOGIN).rawContent as Login;
			
			login.Init();
		}
	}
}
