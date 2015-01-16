package com.game.factory {

	import com.alducente.services.WebService;
	import flash.events.*;
	import com.game.scenes.Header;
	import com.greensock.loading.LoaderMax;
	import com.game.scenes.Main;
	
	public class PacmanWebService {

		private static var instance:PacmanWebService;
		private static var isOkayToCreate:Boolean = false;
		private var levelData:LevelData;
		private var headerSWF:Header;
		private var game:Game;
		
		private static const WEB_SERVICE_URL:String = "http://cmpproj.cms.livjm.ac.uk/cmpryoun/services/pacmanservice/PacmanService.asmx?WSDL";
		
		var webService:WebService = new WebService();
		
		public function PacmanWebService() {
			if (!isOkayToCreate)
				throw new Error(this + " is a Singleton. Access using getInstance()");
			
			headerSWF = LoaderMax.getContent(Game.SWF_HEADER).rawContent as Header;
			var main:Main = headerSWF.stage.getChildAt(0) as Main;
			
			if (main != null) {
				game = main.getChildByName(Game.SWF_GAME) as Game;
			}
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
		
		public function SetLevelData(newLevelData:LevelData)
		{
			this.levelData = newLevelData;

			webService.addEventListener(Event.CONNECT, SetLevelDataConnection);
			webService.connect(PacmanWebService.WEB_SERVICE_URL);
			headerSWF.SetWebServiceDisconnected();
			game.serverConnected = false;
		}
		
		private function SetLevelDataConnection(e:Event)
		{
			var levelDataJSON:String = JSON.stringify(this.levelData);
			
			webService.SetLevelData(Done, levelDataJSON);
		}
		
		private function Done(response:XML)
		{
			trace("Response: " + response);
			
			if (response.child("*").child("*").child("*") == "Saved") {
				headerSWF.SetWebServiceConnected();
				game.serverConnected = true;
			}else{
				headerSWF.SetWebServiceDisconnected();
				game.serverConnected = false;
			}
		}
	}
	
}
