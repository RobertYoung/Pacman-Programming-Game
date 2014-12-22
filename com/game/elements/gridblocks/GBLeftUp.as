package com.game.elements.gridblocks {
	
	import flash.display.MovieClip;
	import com.game.factory.Game;
	
	public class GBLeftUp extends GridBlock {
		
		public function GBLeftUp() {
			this.SetAllowedPaths(Game.PACMAN_NORTH, Game.PACMAN_EAST);
		}
	}
	
}
