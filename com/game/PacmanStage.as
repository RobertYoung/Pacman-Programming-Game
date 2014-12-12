package com.game {
	
	import flash.display.MovieClip;
	import com.game.Level;
	
	public class PacmanStage extends MovieClip {
		
		var level:Level;
		
		public function PacmanStage(level:Level) {
			level = level;
			
			//level.CreateArrayOfGrids();
			
			for (var i = 0; i < level.grids.length; i++)
			{
				// Get the placeholder of the grid on the stage
				var gbPlaceholder:MovieClip = this["grid_row" + (level.grids[i].row) + "_col" + (level.grids[i].col)];
				
				switch(level.grids[i].gridBlock)
				{
					case Grid.BLANK:
						var gbBlank:GBBlank = new GBBlank();
				
						gbBlank.x = gbPlaceholder.x;
						gbBlank.y = gbPlaceholder.y;
						
						this.addChild(gbBlank);
					break;
					case Grid.BOX:
						var gbBox:GBBox = new GBBox();
				
						gbBox.x = gbPlaceholder.x;
						gbBox.y = gbPlaceholder.y;
						
						this.addChild(gbBox);
					break;
					case Grid.HORIZONTAL:
						var gbHorizontal:GBHorizontal = new GBHorizontal();
				
						gbHorizontal.x = gbPlaceholder.x;
						gbHorizontal.y = gbPlaceholder.y;
						
						this.addChild(gbHorizontal);
					break;
					case Grid.VERTICAL:
						var gbVertical:GBVertical = new GBVertical();
				
						gbVertical.x = gbPlaceholder.x;
						gbVertical.y = gbPlaceholder.y;
						
						this.addChild(gbVertical);
					break;
					case Grid.END_UP:
						var gbEndUp:GBEndUp = new GBEndUp();
				
						gbEndUp.x = gbPlaceholder.x;
						gbEndUp.y = gbPlaceholder.y;
						
						this.addChild(gbEndUp);
					break;
					case Grid.END_DOWN:
						var gbEndDown:GBEndDown = new GBEndDown();
				
						gbEndDown.x = gbPlaceholder.x;
						gbEndDown.y = gbPlaceholder.y;
						
						this.addChild(gbEndDown);
					break;
					case Grid.END_RIGHT:
						var gbEndRight:GBEndRight = new GBEndRight();
				
						gbEndRight.x = gbPlaceholder.x;
						gbEndRight.y = gbPlaceholder.y;
						
						this.addChild(gbEndRight);
					break;
					case Grid.END_LEFT:
						var gbEndLeft:GBEndLeft = new GBEndLeft();
				
						gbEndLeft.x = gbPlaceholder.x;
						gbEndLeft.y = gbPlaceholder.y;
						
						this.addChild(gbEndLeft);
					break;
					case Grid.LEFT_DOWN:
						var gbLeftDown:GBLeftDown = new GBLeftDown();
				
						gbLeftDown.x = gbPlaceholder.x;
						gbLeftDown.y = gbPlaceholder.y;
						
						this.addChild(gbLeftDown);
					break;
					case Grid.LEFT_UP:
						var gbLeftUp:GBLeftUp = new GBLeftUp();
				
						gbLeftUp.x = gbPlaceholder.x;
						gbLeftUp.y = gbPlaceholder.y;
						
						this.addChild(gbLeftUp);
					break;
					case Grid.RIGHT_DOWN:
						var gbRightDown:GBRightDown = new GBRightDown();
				
						gbRightDown.x = gbPlaceholder.x;
						gbRightDown.y = gbPlaceholder.y;
						
						this.addChild(gbRightDown);
					break;
					case Grid.RIGHT_UP:
						var gbRightUp:GBRightUp = new GBRightUp();
				
						gbRightUp.x = gbPlaceholder.x;
						gbRightUp.y = gbPlaceholder.y;
						
						this.addChild(gbRightUp);
					break;
					case Grid.T_HORIZONTAL_DOWN:
						var gbTHorizontalDown:GBTHorizontalDown = new GBTHorizontalDown();
				
						gbTHorizontalDown.x = gbPlaceholder.x;
						gbTHorizontalDown.y = gbPlaceholder.y;
						
						this.addChild(gbTHorizontalDown);
					break;
					case Grid.T_HORIZONTAL_UP:
						var gbTHorizontalUp:GBTHorizontalUp = new GBTHorizontalUp();
				
						gbTHorizontalUp.x = gbPlaceholder.x;
						gbTHorizontalUp.y = gbPlaceholder.y;
						
						this.addChild(gbTHorizontalUp);
					break;
					case Grid.T_VERTCIAL_LEFT:
						var gbTVerticalLeft:GBTVerticalLeft = new GBTVerticalLeft();
				
						gbTVerticalLeft.x = gbPlaceholder.x;
						gbTVerticalLeft.y = gbPlaceholder.y;
						
						this.addChild(gbTVerticalLeft);
					break;
					case Grid.T_VERTICAL_RIGHT:
						var gbTVerticalRight:GBTVerticalRight = new GBTVerticalRight();
				
						gbTVerticalRight.x = gbPlaceholder.x;
						gbTVerticalRight.y = gbPlaceholder.y;
						
						this.addChild(gbTVerticalRight);
					break;
					case Grid.CROSSROADS:
						var gbCrossroads:GBCrossroads = new GBCrossroads();
				
						gbCrossroads.x = gbPlaceholder.x;
						gbCrossroads.y = gbPlaceholder.y;
						
						this.addChild(gbCrossroads);
					break;
				}
			}
		}
	}
	
}
