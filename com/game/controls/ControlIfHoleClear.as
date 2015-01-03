package com.game.controls {
	
	import flash.display.MovieClip;
	
	
	public class ControlIfHoleClear extends Control {
		
		
		public function ControlIfHoleClear() {
			this.x = super.nX
			this.y = super.nY;
			
			this.controlName = "If Clear";
			this.controlDescription = "If the hole is clear, run the next block of code between this and the 'If Clear End'. Make sure you are using the flashlight to see into the hole";
		}
	}
	
}
