package com.game.elements {
	
	import flash.display.MovieClip;
	
	
	public class GridPlaceholder extends MovieClip {
		
		public var gridBlock:String;
		
		public function GridPlaceholder() {

		}
		
		public function SetGridBlock(newGridBlock:String)
		{
			gridBlock = newGridBlock;
		}
	}
	
}
