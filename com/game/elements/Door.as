package com.game.elements {
	
	import flash.display.MovieClip;
	
	
	public class Door extends MovieClip {
		
		public var isOpen:Boolean = false;
		
		public function Door() {
			
		}
		
		public function SetOpen()
		{
			this.isOpen = true;
		}
	}
	
}
