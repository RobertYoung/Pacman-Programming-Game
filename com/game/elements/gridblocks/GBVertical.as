package com.game.elements.gridblocks {
	
	import flash.display.MovieClip;
	import com.game.factory.Game;
	
	public class GBVertical extends GridBlock {
		
		public function GBVertical() {
			this.SetAllowedPaths(Game.PACMAN_NORTH, Game.PACMAN_SOUTH);
		}
	}
	
}
