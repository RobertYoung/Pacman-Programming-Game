package com.game {
	
	import flash.display.MovieClip;
	import com.game.Level;
	
	public class PacmanStage extends MovieClip {
		
		var level:Level;
		
		public function PacmanStage(level:Level) {
			level = level;
			
			level.ConstructLevel();
			
			for (var i = 0; i < level.grids.length; i++)
			{
				if (level.grids[i].gridBlock == Grid.HORIZONTAL)
				{
					var gbHorizontal:GBHorizontal = new GBHorizontal();
					var gbPlaceholder:MovieClip = this["grid_row" + (level.grids[i].row) + "_col" + (level.grids[i].col)];
			
					gbHorizontal.x = gbPlaceholder.x;
					gbHorizontal.y = gbPlaceholder.y;
					
					this.addChild(gbHorizontal);
				}
			}
		}
	}
	
}
