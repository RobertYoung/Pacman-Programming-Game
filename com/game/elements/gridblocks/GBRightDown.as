package com.game.elements.gridblocks {
	
	import flash.display.MovieClip;
	import com.game.factory.Game;
	
	public class GBRightDown extends GridBlock {
		
		public function GBRightDown() {
			this.SetAllowedPaths(Game.PACMAN_WEST, Game.PACMAN_SOUTH);
		}
	}
	
}
