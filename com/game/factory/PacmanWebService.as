package com.game.factory {

	import com.alducente.services.WebService;
	import flash.events.*;
	import com.game.scenes.Header;
	import com.greensock.loading.LoaderMax;
	import com.game.scenes.Main;
	import com.game.scenes.Login;
	
	public class PacmanWebService {

		private static var instance:PacmanWebService;
		private static var isOkayToCreate:Boolean = false;
		private var levelData:LevelData;
		private var headerSWF:Header;
		private var loginSWF:Login;
		private var setCompleted:Boolean = false;
		private var stageNumber:int;
		private var levelNumber:int;
		private var getLevelDataCompleteFunction:Function;
		
		// Login
		private var username:String;
		private var password:String;
		
		private static const WEB_SERVICE_URL:String = "http://cmpproj.cms.livjm.ac.uk/cmpryoun/services/pacmanservice/PacmanService.asmx?WSDL";
		
		var webService:WebService = new WebService();
		
		public function PacmanWebService() {
			if (!isOkayToCreate)
				throw new Error(this + " is a Singleton. Access using getInstance()");
		}

		public static function getInstance():PacmanWebService
		{
			if (!instance)
			{
				isOkayToCreate = true;
				instance = new PacmanWebService();
				isOkayToCreate = false;
			}
			
			return instance;
		}
		
		// ***************//
		// SET LEVEL DATA //
		//****************//
		public function SetLevelData(newLevelData:LevelData, isCompleted:Boolean)
		{
			this.levelData = newLevelData;
			this.setCompleted = isCompleted;

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
			
			webService.SetLevelData(SetLevelDataComplete, levelDataJSON, setCompleted);
		}
		
		private function SetLevelDataComplete(response:XML)
		{
			trace("Response: " + response);
			trace(response.child("*").child("*").child("*"));
			
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
			trace("Response: " + response);
			trace(response.child("*").child("*").child("*"));
			
			var levelDataJSON = JSON.parse(response.child("*").child("*").child("*"));
			levelData = new LevelData();
			
			for (var prop:String in levelDataJSON)
			{
				levelData[prop] = levelDataJSON[prop];
			}
			
			this.getLevelDataCompleteFunction(levelData);
		}
		
		//**********************//
		// GET STAGE COMPLETION //
		//**********************//
		public function GetStageCompletion(withStageNumber:int)
		{
			// PUT IN WEB SERVICE
		}
		
		//************//
		// USER LOGIN //
		//************//
		public function UserLogin(setUsername:String, setPassword:String)
		{
			this.username = setUsername;
			this.password = setPassword;
			
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
			trace("Response: " + response);
			trace(response.child("*").child("*").child("*"));
			
			loginSWF = LoaderMax.getContent(Game.SWF_LOGIN).rawContent as Login;
			
			if (response.child("*").child("*").child("*") == "true")
			{
				this.loginSWF.LoginSuccessfull();
			}else{
				this.loginSWF.LoginFailure();
			}
		}
	}
	
}
