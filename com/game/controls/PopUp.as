package com.game.controls {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class PopUp extends MovieClip {
		
		
		public function PopUp() {
			//delete_mc.addEventListener(MouseEvent.MOUSE_UP, DeleteControl)
			//trace("hit");
		}
		
		function DeleteControl(e:MouseEvent)
		{
			trace("remove");
		}
	}
	
}
