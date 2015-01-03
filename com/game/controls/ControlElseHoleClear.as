package com.game.controls {
	
	import flash.display.MovieClip;
	
	
	public class ControlElseHoleClear extends Control {
		
		
		public function ControlElseHoleClear() {
			this.x = super.nX
			this.y = super.nY;
			
			this.controlName = "Else";
			this.controlDescription = "If the hole isn't clear, do what is between the 'Else' and 'Else End'";
		}
	}
	
}
