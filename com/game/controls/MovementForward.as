package com.game.controls {
	
	import flash.display.MovieClip;
	
	public class MovementForward extends Control {
		
		public function MovementForward() 
		{
			this.x = super.nX
			this.y = super.nY;
			
			this.controlName = "Move Forward";
			this.controlDescription = "Moves Pacman forward one grid in the direction he is facing. " + 
										"You can only move forward if the maze allows you too!";
		}
		
	}
	
}
