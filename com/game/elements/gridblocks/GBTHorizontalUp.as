package com.game.elements.gridblocks {
	
	import flash.display.MovieClip;
	import com.game.factory.Game;
	
	public class GBTHorizontalUp extends GridBlock {
		
		public function GBTHorizontalUp() {
			this.SetAllowedPaths(Game.PACMAN_NORTH, Game.PACMAN_EAST, Game.PACMAN_WEST);
		}
	}
	
}
