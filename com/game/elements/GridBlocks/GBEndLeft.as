﻿package com.game.elements.gridblocks {
	
	import flash.display.MovieClip;
	import com.game.factory.Game;
	
	public class GBEndLeft extends GridBlock {
		
		
		public function GBEndLeft() {
			this.SetAllowedPaths(Game.PACMAN_EAST);
		}
	}
	
}
