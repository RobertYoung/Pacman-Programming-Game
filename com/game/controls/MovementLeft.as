package com.game.controls {
	
	import flash.display.MovieClip;
	
	
	public class MovementLeft extends Control {
		
		
		public function MovementLeft() {
			this.x = super.nX;
			this.y = super.nY;
			
			this.controlName = "Turn Left";
			this.controlDescription = "Turns Pacman 90 degress to the left. This helps you make Pacman turn corners";
		}
	}
	
}
