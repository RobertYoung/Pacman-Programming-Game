package com.game.elements.gridblocks {
	
	import flash.display.MovieClip;
	import com.game.factory.Game;
	
	public class GBTVerticalRight extends GridBlock {
		
		public function GBTVerticalRight() {
			this.SetAllowedPaths(Game.PACMAN_NORTH, Game.PACMAN_EAST, Game.PACMAN_SOUTH);
		}
	}
	
}
