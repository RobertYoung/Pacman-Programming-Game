package com.game.elements.gridblocks {
	
	import flash.display.MovieClip;
	import com.game.factory.Game;
	
	public class GBLeftDown extends GridBlock {
		
		public function GBLeftDown() {
			this.SetAllowedPaths(Game.PACMAN_EAST, Game.PACMAN_SOUTH);
		}
	}
	
}
