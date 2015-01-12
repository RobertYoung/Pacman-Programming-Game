package com.game.factory {

	import flash.net.SharedObject;
	
	public class UserData {

		private static var instance:UserData;
		private static var isOkayToCreate:Boolean = false;
		
		private static const PACMAN_LOCAL_DATA:String = "pacmanLocalData";
		private static const USER_STAGE:String = "userStage";
		private static const USER_LEVEL:String = "userLevel";
		
		public var userLocalData:SharedObject;
		
		public function UserData() {
			if (!isOkayToCreate)
				throw new Error(this + " is a Singleton. Access using getInstance()");
			
			
			userLocalData = SharedObject.getLocal(UserData.PACMAN_LOCAL_DATA);
			
			userLocalData.data[UserData.USER_STAGE] = 1;
			userLocalData.data[UserData.USER_LEVEL] = 1;
			userLocalData.flush();
		}
		
		public static function getInstance():UserData
		{
			if (!instance)
			{
				isOkayToCreate = true;
				instance = new UserData();
				isOkayToCreate = false;
			}
			
			return instance;
		}

		//*****//
		// GET //
		//*****//
		public function GetStage():int
		{
			return this.userLocalData.data[UserData.USER_STAGE];
		}
		
		public function GetLevel():int
		{
			return this.userLocalData.data[UserData.USER_LEVEL];
		}
		
		//*****//
		// SET //
		//*****//
		public function SetStage(stageNumber:int)
		{
			this.userLocalData.data[UserData.USER_STAGE] = stageNumber;
		}
		
		public function SetLevel(levelNumber:int)
		{
			this.userLocalData.data[UserData.USER_LEVEL] = levelNumber;
		}
		
		public function SetStageAndLevel(stageNumber:int, levelNumber:int)
		{
			this.SetStage(stageNumber);
			this.SetLevel(levelNumber);
		}
	}
	
}
