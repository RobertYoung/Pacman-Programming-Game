package com.game.scenes {
	
	import flash.display.MovieClip;
	import com.game.elements.*;
	import flash.ui.Keyboard;
	
	public class PacmanStage extends MovieClip {
		
		var level:Level;
		
		//*****************************************************************//
		// WHEN INSTANTIATED: LOOPS THROUGH ALL THE GRIDS IN THE LEVEL AND //
		// DISPLAYS THEM ON THE STAGE									   //
		//*****************************************************************//
		public function PacmanStage(level:Level) {
			level = level;
			
			for (var i = 0; i < level.grids.length; i++)
			{
				// Get the placeholder of the grid on the stage
				var gbPlaceholder:MovieClip = this["grid_row" + (level.grids[i].row) + "_col" + (level.grids[i].col)];
				
				// Add the correct grid block to the pacman stage
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
				
				// Add pacman if pacman start is true
				if (level.grids[i].pacmanStart == true)
				{
					var pacman:Pacman = new Pacman();
					
					pacman.x = gbPlaceholder.x;
					pacman.y = gbPlaceholder.y;
					
					this.addChild(pacman);
				}else if (level.grids[i].apple == true)
				{
					var apple:Apple = new Apple();
					
					apple.x = gbPlaceholder.x;
					apple.y = gbPlaceholder.y;
					
					this.addChild(apple);
				}else if (level.grids[i].cherry == true) {
					var cherry:Cherry = new Cherry();
					
					cherry.x = gbPlaceholder.x;
					cherry.y = gbPlaceholder.y;
					
					this.addChild(cherry);
				}else if (level.grids[i].strawberry == true){
					var strawberry:Strawberry = new Strawberry();
					
					strawberry.x = gbPlaceholder.x;
					strawberry.y = gbPlaceholder.y;
					
					this.addChild(strawberry);
				}else if (level.grids[i].blinky == true) {
					var blinky:Blinky = new Blinky();
				
					blinky.x = gbPlaceholder.x;
					blinky.y = gbPlaceholder.y;
					
					this.addChild(blinky);
				}else if (level.grids[i].clyde == true) {
					var clyde:Clyde = new Clyde();
				
					clyde.x = gbPlaceholder.x;
					clyde.y = gbPlaceholder.y;
					
					this.addChild(clyde);
				}else if (level.grids[i].pinky == true) {
					var pinky:Pinky = new Pinky();
				
					pinky.x = gbPlaceholder.x;
					pinky.y = gbPlaceholder.y;
					
					this.addChild(pinky);
				}else if (level.grids[i].inky == true) {
					var inky:Inky = new Inky();
				
					inky.x = gbPlaceholder.x;
					inky.y = gbPlaceholder.y;
					
					this.addChild(inky);
				}else if (level.grids[i].door == true) {
					var door:Door = new Door();
				
					door.x = gbPlaceholder.x;
					door.y = gbPlaceholder.y;
					
					this.addChild(door);
				}else if (level.grids[i].hole == true) {
					var hole:Hole = new Hole();
				
					hole.x = gbPlaceholder.x;
					hole.y = gbPlaceholder.y;
					
					this.addChild(hole);
				}else if (level.grids[i].key.isKey == true) {
					var key:Key = new Key(level.grids[i].key);
					
					key.x = gbPlaceholder.x;
					key.y = gbPlaceholder.y;
					
					this.addChild(key);
				}else if (level.grids[i].gridBlock != Grid.BLANK && level.grids[i].gridBlock != Grid.BOX) {
					var pacDot:PacDot = new PacDot();
					
					pacDot.x = gbPlaceholder.x;
					pacDot.y = gbPlaceholder.y;
					
					this.addChild(pacDot);
				}
			}
		}
	}
	
}
