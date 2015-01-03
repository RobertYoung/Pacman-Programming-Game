package com.game.objects {
	
	public class KeyObject {
	
		public var isKey:Boolean = false;
		public var numberOfKeys:int = 1;
		public var actualNumberOfKeys:int = 1; // Due to the animation, need to store the amount of keys in a hidden variable

		public function KeyObject(setNumberOfKeys:int = 1) {
			numberOfKeys = setNumberOfKeys;
			actualNumberOfKeys = setNumberOfKeys;
		}

		function SetNumberOfKeys(setNumberOfKeys:int):void
		{
			numberOfKeys = setNumberOfKeys;
		}	
		
		function SetActualNumberOfKeys(setActualNumberOfKeys:int):void
		{
			this.actualNumberOfKeys = setActualNumberOfKeys;
		}
	}
	
}
