package com.game.factory {

	import com.alducente.services.WebService;
	import flash.events.*;
	
	public class PacmanWebService {

		private static var instance:PacmanWebService;
		private static var isOkayToCreate:Boolean = false;
		private var levelData:LevelData;
		
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
		
		public function SetLevelData(newLevelData:LevelData)
		{
			this.levelData = newLevelData;

			webService.addEventListener(Event.CONNECT, SetLevelDataConnection);
			webService.connect(PacmanWebService.WEB_SERVICE_URL);
		}
		
		private function SetLevelDataConnection(e:Event)
		{
			var levelDataJSON:String = JSON.stringify(this.levelData);
			
			webService.SetLevelData(Done, levelDataJSON);
		}
		
		private function Done(response:XML)
		{
			trace("Response: " + response);
		}
		
		/*
		public function ConnectToWebService()
		{
			webService.addEventListener(Event.CONNECT, Connected);
			webService.connect(PacmanWebService.WEB_SERVICE_URL);
		}
		
		public function Connected(e:Event)
		{
			webService["Add"](Done, 4, 5);
		}
		
		public function Done(response:XML)
		{
			/*
			var responseNamespace = response.namespace();
			var body:XML = response.responseNamespace::Body[0];
			var bodyNamespace = body.namespace();
			var helloWorldResponse = body.bodyNamespace::HelloWorldResponse[0];
			var nodeName:QName = new QName("http://tempuri.org", "HelloWorldResult");
			var result = body.descendants(nodeName);
			
			var helloWorld = body.responseNamespace::HelloWorldResponse[0];
			
			
			var responseNamespace = response.namespace();
			var body:XML = response.responseNamespace::Body[0];
			
			
			trace("Response: " + response);
			trace("test: " + response.children());
			trace("Child: " + response.child("*").child("*").child("*"));
			
			var xmlList:XMLList = new XMLList();
			
			for each (var child in response.children())
			{
				trace(child);
			}
		}*/
	}
	
}
