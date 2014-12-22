package com.game.elements.gridblocks{
	
	import flash.display.MovieClip;
	
	public class GridBlock extends MovieClip {

		public var allowedPaths:Array = new Array();
		
		public function GridBlocks() {
			
		}

		public function SetAllowedPaths(... args)
		{
			for (var i = 0; i < args.length; i++)
			{
				//TODO: Check it is a string
				allowedPaths.push(args[i]);
			}
		}
	}
	
}
