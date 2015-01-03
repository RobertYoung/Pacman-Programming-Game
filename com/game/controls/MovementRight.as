package com.game.controls {
	
	import flash.display.MovieClip;
	
	public class MovementRight extends Control {
		
		public function MovementRight() {
			this.x = super.nX;
			this.y = super.nY;
			
			this.controlName = "Turn Right";
			this.controlDescription = "Turns Pacman 90 degress to the right. This helps you make Pacman turn corners";
		}
	}
	
}
