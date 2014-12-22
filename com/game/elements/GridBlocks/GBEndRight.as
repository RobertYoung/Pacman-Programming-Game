package com.game.elements.GridBlocks {
	
	import flash.display.MovieClip;
	import com.game.factory.Game;
	
	public class GBEndRight extends GridBlock {
		
		
		public function GBEndRight() {
			this.SetAllowedPaths(Game.PACMAN_WEST);
		}
	}
	
}
