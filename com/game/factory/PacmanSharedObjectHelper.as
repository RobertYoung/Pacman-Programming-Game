package com.game.factory {

	import flash.net.SharedObject;
	
	public class PacmanSharedObjectHelper {

		private static var instance:PacmanSharedObjectHelper;
		private static var isOkayToCreate:Boolean = false;
		
		private static const PACMAN_LOCAL_DATA:String = "pacmanLocalData";
		private static const USER_STAGE:String = "userStage";
		private static const USER_LEVEL:String = "userLevel";
		private static const USER_HIGH_SCORE:String = "userHighScore";
		private static const STAGE1_LEVEL1:String = "stage1level1";
		
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
		
		public function PacmanSharedObjectHelper() {
			if (!isOkayToCreate)
				throw new Error(this + " is a Singleton. Access using getInstance()");
			
			userLocalData = SharedObject.getLocal(PacmanSharedObjectHelper.PACMAN_LOCAL_DATA);
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
		
		public function GetHighScore():int
		{
			var highScore = this.userLocalData.data[PacmanSharedObjectHelper.USER_HIGH_SCORE];
			
			if (highScore == undefined)
				highScore = 0;
			
			return highScore;
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

			this["stage" + stageNumber + "level" + levelNumber] = levelData;
			
			return levelData;
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
			
			if (levelData.levelScore > levelData.highScore)
				levelData.highScore = levelData.levelScore;
			
			this.userLocalData.data["stage" + stageNumber + "level" + levelNumber] = levelData as LevelData;
			userLocalData.flush();
		}
	}
	
}
