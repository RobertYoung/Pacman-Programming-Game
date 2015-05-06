package com.game.factory {

	import com.alducente.services.WebService;
	import flash.events.*;
	import com.game.scenes.Header;
	import com.greensock.loading.LoaderMax;
	import com.game.scenes.Main;
	import com.game.scenes.Login;
	import com.game.objects.StagesCompletion;
	import flash.utils.*;
	
	public class PacmanWebService {

		private static var instance:PacmanWebService;
		private static var isOkayToCreate:Boolean = false;
		private var levelData:LevelData;
		private var headerSWF:Header;
		//private var loginSWF:Login;
		private var setCompleted:Boolean = false;
		private var stageNumber:int;
		private var levelNumber:int;
		private var getLevelDataCompleteFunction:Function;
		
		// Login
		private var username:String;
		private var password:String;
		private var gender:String;
		
		private static const WEB_SERVICE_URL:String = "http://iamrobertyoung.co.uk/services/pacmanservice/PacmanService.asmx?WSDL";
		
		var webService:WebService = new WebService();
		
		public function PacmanWebService() {
			/*
			if (!isOkayToCreate)
				throw new Error(this + " is a Singleton. Access using getInstance()");
			*/
			
			username = PacmanSharedObjectHelper.getInstance().GetUsername();
		}

		/*
		public static function getInstance():PacmanWebService
		{
			if (!instance)
			{
				isOkayToCreate = true;
				instance = new PacmanWebService();
				isOkayToCreate = false;
			}
			
			return instance;
		}*/
		
		// ***************//
		// SET LEVEL DATA //
		//****************//
		public function SetLevelData(newLevelData:LevelData, isCompleted:Boolean)
		{
			this.levelData = newLevelData;
			this.setCompleted = isCompleted;
			trace("USERNAME: " + this.levelData.username);
			this.levelData.username;

			webService = new WebService();
			webService.addEventListener(Event.CONNECT, SetLevelDataConnection);
			webService.connect(PacmanWebService.WEB_SERVICE_URL);
			headerSWF = LoaderMax.getContent(Game.SWF_HEADER).rawContent as Header;
			headerSWF.SetWebServiceDisconnected();
			PacmanSharedObjectHelper.getInstance().SetWebServiceConnect(false);
		}
		
		private function SetLevelDataConnection(e:Event)
		{
			var levelDataJSON:String = JSON.stringify(this.levelData);
			trace(levelDataJSON);
			webService.SetLevelData(SetLevelDataComplete, levelDataJSON, setCompleted);
		}
		
		private function SetLevelDataComplete(response:XML)
		{
			//trace("Response: " + response);
			trace("WEB SERVICE - SET LEVEL DATA: " + response.child("*").child("*").child("*"));
			
			if (response.child("*").child("*").child("*") == "Saved") {
				headerSWF.SetWebServiceConnected();
				PacmanSharedObjectHelper.getInstance().SetWebServiceConnect(true);
			}else{
				headerSWF.SetWebServiceDisconnected();
				PacmanSharedObjectHelper.getInstance().SetWebServiceConnect(false);
			}
		}
		
		//****************//
		// GET LEVEL DATA //
		//****************//
		private var getLevelDataStageNumber;
		
		public function GetLevelData(withStageNumber:int, withLevelNumber:int, onComplete:Function)
		{
			username = PacmanSharedObjectHelper.getInstance().GetUsername();
			stageNumber = withStageNumber;
			levelNumber = withLevelNumber;
			this.getLevelDataCompleteFunction = onComplete;
			
			webService = new WebService();
			webService.addEventListener(Event.CONNECT, GetLevelDataConnection);
			webService.connect(PacmanWebService.WEB_SERVICE_URL);
		}
		
		private function GetLevelDataConnection(e:Event)
		{
			webService.GetLevelData(GetLevelDataComplete, username, stageNumber, levelNumber);
		}
		
		private function GetLevelDataComplete(response:XML)
		{
			//trace("Response: " + response);
			trace("WEB SERVICE - GET LEVEL DATA: " + response.child("*").child("*").child("*"));

			var levelResponse = response.child("*").child("*").child("*").toString();
			
			if (levelResponse != "Level data does not exist" || levelResponse != "User does not exist")
			{
				levelData = new LevelData();
				
				levelData.stageNumber = stageNumber;
				levelData.levelNumber = levelNumber;
				
				try{
					var levelDataJSON = JSON.parse(levelResponse);				
			
					for (var prop:String in levelDataJSON)
					{
						levelData[prop] = levelDataJSON[prop];
					}
				
					this.getLevelDataCompleteFunction(levelData);
				}catch (e:Error) {
					this.getLevelDataCompleteFunction(levelData);
				}
			}
		}
		
		//**********************//
		// GET STAGE COMPLETION //
		//**********************//
		private var getStageCompletionOnComplete:Function;
		
		public function GetStageCompletion(onComplete:Function = null)
		{
			this.getStageCompletionOnComplete = onComplete;
			
			webService = new WebService();
			webService.addEventListener(Event.CONNECT, GetStageCompleteConnection);
			webService.connect(PacmanWebService.WEB_SERVICE_URL);
		}
		
		private function GetStageCompleteConnection(e:Event)
		{
			webService.GetStageComplete(GetStageCompleteComplete, username);
		}
		
		private function GetStageCompleteComplete(response:XML)
		{
			//trace("Response: " + response);
			trace("WEB SERVICE - GET STAGE COMPLETE: " + response.child("*").child("*").child("*"));
			
			if (this.getStageCompletionOnComplete != null)
			{
				var responseJSON = JSON.parse(response.child("*").child("*").child("*").toString());
				var stagesCompletion:StagesCompletion = new StagesCompletion();

				for (var prop:String in responseJSON)
				{
					stagesCompletion[prop] = responseJSON[prop];
				}
				
				getStageCompletionOnComplete(stagesCompletion);
			}
		}
		
		//**********************//
		// SET TIME ACHIEVEMENT //
		//**********************//
		private var setTimeAchievementOnComplete:Function;
		private var timeAchievement:int;
		
		public function SetTimeAchievement(time:int, onComplete:Function = null)
		{
			this.setTimeAchievementOnComplete = onComplete;
			this.timeAchievement = time;
			
			webService = new WebService();
			webService.addEventListener(Event.CONNECT, SetTimeAchievementConnection);
			webService.connect(PacmanWebService.WEB_SERVICE_URL);
		}
		
		private function SetTimeAchievementConnection(e:Event)
		{
			webService.SetTimeAchievement(SetTimeAchievementComplete, username, timeAchievement);
		}
		
		private function SetTimeAchievementComplete(response:XML)
		{
			//trace("Response: " + response);
			trace("WEB SERVICE - SET TIME ACHIEVEMENT: " + response.child("*").child("*").child("*"));
			
			if (this.setTimeAchievementOnComplete != null)
			{
				this.setTimeAchievementOnComplete();
			}
		}
		
		//****************************//
		// GET TIME ACHIEVEMENTS DATA //
		//****************************//
		private var getTimeAchievementsOnComplete:Function;
		
		public function GetTimeAchievements(onComplete:Function = null)
		{
			this.getTimeAchievementsOnComplete = onComplete;
			
			webService = new WebService();
			webService.addEventListener(Event.CONNECT, GetTimeAchievementsConnection);
			webService.connect(PacmanWebService.WEB_SERVICE_URL);
		}
		
		private function GetTimeAchievementsConnection(e:Event)
		{
			webService.GetTimeAchievements(GetTimeAchievementsComplete, this.username);
		}
		
		private function GetTimeAchievementsComplete(response:XML)
		{
			//trace("Response: " + response);
			trace("WEB SERVICE - GET TIME ACHIEVEMENTS: " + response.child("*").child("*").child("*"));
			
			var jsonObject:Object;
			
			try {
				jsonObject = JSON.parse(response.child("*").child("*").child("*"));
			}catch (e:Error)
			{
				
			}
			
			this.getTimeAchievementsOnComplete(jsonObject);
		}
		
		//************//
		// USER LOGIN //
		//************//
		private var userLoginOnComplete:Function;
		
		public function UserLogin(setUsername:String, setPassword:String, onComplete:Function = null)
		{
			this.username = setUsername;
			this.password = setPassword;
			this.userLoginOnComplete = onComplete;
			
			webService = new WebService();
			webService.addEventListener(Event.CONNECT, UserLoginConnection);
			webService.connect(PacmanWebService.WEB_SERVICE_URL);
		}
		
		private function UserLoginConnection(e:Event)
		{
			webService.UserLogin(UserLoginComplete, username, password);
		}
		
		private function UserLoginComplete(response:XML)
		{
			//trace("Response: " + response);
			trace("WEB SERVICE - USER LOGIN: " + response.child("*").child("*").child("*"));
			
			if (this.userLoginOnComplete != null)
				this.userLoginOnComplete(response.child("*").child("*").child("*"));
		}
		
		//*********//
		// SIGN UP //
		//*********//
		private var signUpOnComplete:Function;
		
		public function UserSignup(setUsername:String, setPassword:String, setGender:String, onComplete:Function = null)
		{
			this.username = setUsername;
			this.password = setPassword;
			this.gender = setGender;
			this.signUpOnComplete = onComplete;
			
			webService = new WebService();
			webService.addEventListener(Event.CONNECT, UserSignupConnection);
			webService.connect(PacmanWebService.WEB_SERVICE_URL);
		}
		
		private function UserSignupConnection(e:Event)
		{
			webService.UserSignup(UserSignupComplete, username, password, gender);
		}
		
		private function UserSignupComplete(response:XML)
		{
			//trace("Response: " + response);
			trace("WEB SERVICE - SIGN UP: " + response.child("*").child("*").child("*"));
			
			if (this.signUpOnComplete != null)
				this.signUpOnComplete(response.child("*").child("*").child("*"));
		}
	}
}
