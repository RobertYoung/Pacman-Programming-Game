package com.game.objects {
	
	public class KeyObject {
	
		public var isKey:Boolean = false;
		public var numberOfKeys:int = 1;

		public function KeyObject(setNumberOfKeys:int = 1) {
			numberOfKeys = setNumberOfKeys;
		}

		function SetNumberOfKeys(setNumberOfKeys:int):void
		{
			numberOfKeys = setNumberOfKeys;
		}	
	}
	
}
