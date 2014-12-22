package com.game.elements.gridblocks {
	
	import flash.display.MovieClip;
	import com.game.factory.Game;
	
	public class GBTVerticalLeft extends GridBlock {
		
		public function GBTVerticalLeft() {
			this.SetAllowedPaths(Game.PACMAN_WEST, Game.PACMAN_NORTH, Game.PACMAN_SOUTH);
		}
	}
	
}
