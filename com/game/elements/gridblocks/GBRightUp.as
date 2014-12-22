package com.game.elements.gridblocks {
	
	import flash.display.MovieClip;
	import com.game.factory.Game;
	
	public class GBRightUp extends GridBlock {
		
		public function GBRightUp() {
			this.SetAllowedPaths(Game.PACMAN_WEST, Game.PACMAN_NORTH);
		}
	}
	
}
