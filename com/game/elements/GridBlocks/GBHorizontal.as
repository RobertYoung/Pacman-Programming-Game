package com.game.elements.gridblocks {
	
	import flash.display.MovieClip;
	import com.game.factory.Game;
	
	public class GBHorizontal extends GridBlock {
		
		public function GBHorizontal() {
			this.SetAllowedPaths(Game.PACMAN_EAST, Game.PACMAN_WEST);
		}
	}
	
}
