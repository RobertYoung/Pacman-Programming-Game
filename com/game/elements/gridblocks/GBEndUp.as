package com.game.elements.gridblocks {
	
	import flash.display.MovieClip;
	import com.game.factory.Game;
	
	public class GBEndUp extends GridBlock {
		
		public function GBEndUp() {
			this.SetAllowedPaths(Game.PACMAN_NORTH);
		}
	}
	
}
