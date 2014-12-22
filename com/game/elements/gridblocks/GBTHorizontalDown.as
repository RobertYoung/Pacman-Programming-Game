package com.game.elements.gridblocks {
	
	import flash.display.MovieClip;
	import com.game.factory.Game;
	
	public class GBTHorizontalDown extends GridBlock {
		
		public function GBTHorizontalDown() {
			this.SetAllowedPaths(Game.PACMAN_SOUTH, Game.PACMAN_EAST, Game.PACMAN_WEST);
		}
	}
	
}
