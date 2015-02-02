package com.game.factory {

	import flash.net.SharedObject;
	import com.game.scenes.Controls;
	
	public class PacmanSharedObjectHelper {

		private static var instance:PacmanSharedObjectHelper;
		private static var isOkayToCreate:Boolean = false;
		
		private static const PACMAN_LOCAL_DATA:String = "pacmanLocalData";
		private static const USER_STAGE:String = "userStage";
		private static const USER_LEVEL:String = "userLevel";
		private static const USER_HIGH_SCORE:String = "userHighScore";
		private static const USER_CONTROLS_SYMBOL:String = "userControlsSymbol";
		private static const WEB_SERVICE_CONNECT:String = "webServiceConnect";
		private static const GAME_COMPLETION:String = "gameCompletion";
		private static const ACHIEVEMENT_COMPLETE_1_MIN:String = "complete1Min";
		private static const ACHIEVEMENT_COMPLETE_2_MIN:String = "complete2Min";
		private static const ACHIEVEMENT_COMPLETE_3_MIN:String = "complete3Min";
		private static const ACHIEVEMENT_COMPLETE_4_MIN:String = "complete4Min";
		private static const ACHIEVEMENT_COMPLETE_5_MIN:String = "complete5Min";
		private static const ACHIEVEMENT_COMPLETE_6_MIN:String = "complete6Min";
		private static const USERNAME:String = "username";
		
		public var userLocalData:SharedObject;
		
		public var stage1level1:LevelData = new LevelData(1, 1);
		public var stage1level2:LevelData = new LevelData(1, 2);
		public var stage1level3:LevelData = new LevelData(1, 3);
		public var stage1level4:LevelData = new LevelData(1, 4);
		public var stage1level5:LevelData = new LevelData(1, 5);
		public var stage1level6:LevelData = new LevelData(1, 6);
		public var stage2level1:LevelData = new LevelData(2, 1);
		public var stage2level2:LevelData = new LevelData(2, 2);
		public var stage2level3:LevelData = new LevelData(2, 3);
		public var stage2level4:LevelData = new LevelData(2, 4);
		public var stage2level5:LevelData = new LevelData(2, 5);
		public var stage2level6:LevelData = new LevelData(2, 6);
		public var stage3level1:LevelData = new LevelData(3, 1);
		public var stage3level2:LevelData = new LevelData(3, 2);
		public var stage3level3:LevelData = new LevelData(3, 3);
		public var stage3level4:LevelData = new LevelData(3, 4);
		public var stage3level5:LevelData = new LevelData(3, 5);
		public var stage3level6:LevelData = new LevelData(3, 6);
		
		public var stage1level1Incomplete:Array = new Array(); // Of data type LevelData
		public var stage1level2Incomplete:Array = new Array();
		public var stage1level3Incomplete:Array = new Array();
		public var stage1level4Incomplete:Array = new Array();
		public var stage1level5Incomplete:Array = new Array();
		public var stage1level6Incomplete:Array = new Array();
		public var stage2level1Incomplete:Array = new Array();
		public var stage2level2Incomplete:Array = new Array();
		public var stage2level3Incomplete:Array = new Array();
		public var stage2level4Incomplete:Array = new Array();
		public var stage2level5Incomplete:Array = new Array();
		public var stage2level6Incomplete:Array = new Array();
		public var stage3level1Incomplete:Array = new Array();
		public var stage3level2Incomplete:Array = new Array();
		public var stage3level3Incomplete:Array = new Array();
		public var stage3level4Incomplete:Array = new Array();
		public var stage3level5Incomplete:Array = new Array();
		public var stage3level6Incomplete:Array = new Array();
		
		public function PacmanSharedObjectHelper() {
			if (!isOkayToCreate)
				throw new Error(this + " is a Singleton. Access using getInstance()");
			
			userLocalData = SharedObject.getLocal(PacmanSharedObjectHelper.PACMAN_LOCAL_DATA);
			userLocalData.clear();
			//this.SetAllLevelsComplete();
			userLocalData.flush();
		}
		
		public static function getInstance():PacmanSharedObjectHelper
		{
			if (!instance)
			{
				isOkayToCreate = true;
				instance = new PacmanSharedObjectHelper();
				isOkayToCreate = false;
			}
			
			return instance;
		}

		//*****//
		// GET //
		//*****//
		public function GetStage():int
		{
			return this.userLocalData.data[PacmanSharedObjectHelper.USER_STAGE];
		}
		
		public function GetLevel():int
		{
			return this.userLocalData.data[PacmanSharedObjectHelper.USER_LEVEL];
		}
		
		public function GetLevelData(stageNumber:int, levelNumber:int):LevelData
		{
			var savedLevelData = this.userLocalData.data["stage" + stageNumber + "level" + levelNumber];

			if (savedLevelData == null)
				savedLevelData = new LevelData(stageNumber, levelNumber);
			
			var levelData:LevelData = this["stage" + stageNumber + "level" + levelNumber] as LevelData;
			
			if (levelData == null)
				levelData = new LevelData(stageNumber, levelNumber);
			
			levelData.highScore = savedLevelData.highScore;
			levelData.levelScore = savedLevelData.levelScore;
			levelData.bonusScore = savedLevelData.bonusScore;
			levelData.pacDotScore = savedLevelData.pacDotScore;
			levelData.cherryScore = savedLevelData.cherryScore;
			levelData.appleScore = savedLevelData.appleScore;
			levelData.strawberryScore = savedLevelData.strawberryScore;
			levelData.ifScore = savedLevelData.ifScore;
			levelData.ifElseScore = savedLevelData.ifElseScore;
			levelData.loopScore = savedLevelData.loopScore;
			levelData.completed = savedLevelData.completed;
			levelData.timeCompleted = savedLevelData.timeCompleted;
			levelData.username = savedLevelData.username;
			levelData.control = savedLevelData.control;

			this["stage" + stageNumber + "level" + levelNumber] = levelData;
			
			return levelData;
		}
		
		public function GetIncompleteLevelData(stageNumber:int, levelNumber:int)
		{
			var savedIncompleteLevelData = this.userLocalData.data["stage" + stageNumber + "level" + levelNumber + "Incomplete"];

			if (savedIncompleteLevelData == null)
				savedIncompleteLevelData = new Array();
			
			var levelIncompleteData:Array = this["stage" + stageNumber + "level" + levelNumber + "Incomplete"] as Array;
			
			if (levelIncompleteData == null)
				levelIncompleteData = new Array();
			
			this["stage" + stageNumber + "level" + levelNumber + "Incomplete"] = savedIncompleteLevelData;
		}
		
		public function GetTotalScore():int
		{
			var totalScore:int = 0;
			
			for (var stageNum = 1; stageNum <= 3; stageNum++)
			{
				for (var levelNum = 1; levelNum <= 6; levelNum++)
				{
					totalScore += this.GetLevelData(stageNum, levelNum).highScore;
				}
			}
			
			return totalScore;
		}
		
		public function GetStageCompletion(stageNumber:int)
		{
			//throw new Error("OLD METHOD: USE WEB SERVICE");
			var completed:Boolean = true;
			
			for (var levelNum = 1; levelNum <= 6; levelNum++)
			{
				if (this.GetLevelData(stageNumber, levelNum).completed == false)
					completed = false;
			}
			
			return completed;
		}
		
		public function GetGameCompletion():Boolean
		{
			if (this.GetStageCompletion(1) == true && this.GetStageCompletion(2) == true && this.GetStageCompletion(3) == true)
			{
				return true;
			}
			
			return false;
		}
		
		public function GetUserControlsSymbol():int
		{
			var controlSymbol:int = this.userLocalData.data[PacmanSharedObjectHelper.USER_CONTROLS_SYMBOL];
			
			if (controlSymbol == 0)
				controlSymbol = Controls.CONTROLS_TEXTUAL;
			
			return controlSymbol;
		}
		
		public function GetWebServiceConnect():Boolean
		{
			return this.userLocalData.data[PacmanSharedObjectHelper.WEB_SERVICE_CONNECT];
		}
		
		public function GetTimeAchievement(time:int):Boolean
		{
			return this.userLocalData.data["complete" + time + "Min"];
		}
		
		public function GetUsername():String
		{
			return this.userLocalData.data[PacmanSharedObjectHelper.USERNAME];
		}
		
		//*****//
		// SET //
		//*****//
		public function SetStage(stageNumber:int)
		{
			this.userLocalData.data[PacmanSharedObjectHelper.USER_STAGE] = stageNumber;
		}
		
		public function SetLevel(levelNumber:int)
		{
			this.userLocalData.data[PacmanSharedObjectHelper.USER_LEVEL] = levelNumber;
		}
		
		public function SetStageAndLevel(stageNumber:int, levelNumber:int)
		{
			this.SetStage(stageNumber);
			this.SetLevel(levelNumber);
		}
		
		public function SetLevelData(stageNumber:int, levelNumber:int, newLevelData:LevelData)
		{
			var levelData:LevelData = this["stage" + stageNumber + "level" + levelNumber] as LevelData;
			
			levelData = newLevelData;
			//levelData.username = this.GetUsername();
			
			if (levelData.levelScore > levelData.highScore)
				levelData.highScore = levelData.levelScore;
			
			this.userLocalData.data["stage" + stageNumber + "level" + levelNumber] = levelData as LevelData;
			userLocalData.flush();
		}
		
		public function SetIncompleteLevelData(stageNumber:int, levelNumber:int, newLevelData:LevelData)
		{
			this.GetIncompleteLevelData(stageNumber, levelNumber);
			
			var incompleteLevelArray:Array = this["stage" + stageNumber + "level" + levelNumber + "Incomplete"] as Array;
			
			incompleteLevelArray.push(newLevelData);
			
			this.userLocalData.data["stage" + stageNumber + "level" + levelNumber + "Incomplete"] = incompleteLevelArray;
			userLocalData.flush();
		}
		
		public function SetUserControlsSymbol(userControlSymbol:int)
		{
			this.userLocalData.data[PacmanSharedObjectHelper.USER_CONTROLS_SYMBOL] = userControlSymbol;
		}
		
		public function SetWebServiceConnect(connect:Boolean)
		{
			this.userLocalData.data[PacmanSharedObjectHelper.WEB_SERVICE_CONNECT] = connect;
		}
		
		public function SetTimeAchievement(time:int):Boolean
		{
			return this.userLocalData.data["complete" + time + "Min"] = true;
		}
		
		public function SetUsername(username:String)
		{
			this.userLocalData.data[PacmanSharedObjectHelper.USERNAME] = username;
		}
		
		//***************//
		// DEBUG METHODS //
		//***************//
		public function SetAllLevelsComplete()
		{
			for (var stageNum = 1; stageNum <= 3; stageNum++)
			{
				for (var levelNum = 1; levelNum <= 6; levelNum++)
				{
					var levelData:LevelData = new LevelData(stageNum, levelNum);
					
					if (stageNum == 1 && levelNum == 1)
						levelData.completed = false;
					else
						levelData.completed = true;
					
					this.SetLevelData(stageNum, levelNum, levelData);
				}
			}
		}
	}
	
}
