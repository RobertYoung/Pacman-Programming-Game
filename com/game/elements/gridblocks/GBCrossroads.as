package com.game.elements.gridblocks {
	
	import flash.display.MovieClip;
	import com.game.factory.Game;
	
	public class GBCrossroads extends GridBlock {
		
		
		public function GBCrossroads() {
			this.SetAllowedPaths(Game.PACMAN_EAST, Game.PACMAN_NORTH, Game.PACMAN_SOUTH, Game.PACMAN_WEST);
		}
	}
	
}
