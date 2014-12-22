package com.game.elements.gridblocks {
	
	import flash.display.MovieClip;
	import com.game.factory.Game;
	
	public class GBEndDown extends GridBlock {
		
		public function GBEndDown() {
			this.SetAllowedPaths(Game.PACMAN_NORTH);
		}
	}
	
}
