package com.game.elements {
	
	import flash.display.MovieClip;
	import com.game.factory.Game;
	
	public class Pacman extends MovieClip {
		
		
		public function Pacman() {
			// constructor code
		}
		
		public function SetPosition(position:String)
		{
			switch(position)
			{
				case Game.PACMAN_NORTH:
					this.rotationZ -= 90;
				break;
				case Game.PACMAN_SOUTH:
					this.rotationZ += 90;
				break;
				case Game.PACMAN_WEST:
					this.rotationZ -= 180;
				break;
			}
			
		}
	}
	
}
