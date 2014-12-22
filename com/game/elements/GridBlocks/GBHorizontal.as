package com.game.elements.GridBlocks  {
	
	import flash.display.MovieClip;
	import com.game.factory.Game;
	
	public class GBHorizontal extends GridBlock {
		
		
		public function GBHorizontal() {
			this.SetAllowedPaths(Game.PACMAN_WEST, Game.PACMAN_EAST);
		}
	}
	
}
