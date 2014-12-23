package com.game.controls {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class PopUp extends MovieClip {
		
		public var delete_mc:MovieClip;
		
		private var controlMC:Control;
		
		public function PopUp(control:Control) {
			delete_mc.addEventListener(MouseEvent.MOUSE_UP, DeleteControl);
			
			controlMC = control;
			
			controlMC.stage.addEventListener(MouseEvent.MOUSE_UP, HidePopUp);
		}
		
		function DeleteControl(e:MouseEvent)
		{
			controlMC.stage.removeEventListener(MouseEvent.MOUSE_UP, HidePopUp);
			controlMC.DeleteControl();
		}
		
		function HidePopUp(e:MouseEvent)
		{
			// Do nothing if the user clicks on the delete movie clip
			if (e.target.name == "delete_mc")
				return;
			
			// If the user clicks outside the popup, remove the pop up
			// and event listeners
			if (e.target.name != controlMC.name){
				controlMC.stage.removeEventListener(MouseEvent.MOUSE_UP, HidePopUp);
				delete_mc.removeEventListener(MouseEvent.MOUSE_UP, DeleteControl);
				controlMC.removeChild(this);
			}
		}
	}
	
}
