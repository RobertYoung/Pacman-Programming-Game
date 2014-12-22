package com.game.elements.GridBlocks {
	
	import flash.display.MovieClip;
	import com.game.factory.Game;
	
	public class GBEndLeft extends GridBlock {
		
		
		public function GBEndLeft() {
			this.SetAllowedPaths(Game.PACMAN_EAST);
		}
	}
	
}
