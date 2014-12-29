package com.game.scenes {
	
	import flash.display.MovieClip;
	import com.game.elements.*;
	import flash.ui.Keyboard;
	import com.game.elements.Stack;
	import com.game.elements.gridblocks.*;
	
	public class PacmanStage extends MovieClip {
		
		var level:Level;
		var stack:Stack;
		
		//*****************************************************************//
		// WHEN INSTANTIATED: LOOPS THROUGH ALL THE GRIDS IN THE LEVEL AND //
		// DISPLAYS THEM ON THE STAGE									   //
		//*****************************************************************//
		public function PacmanStage(level:Level) {
			level = level;
			
			for (var i = 0; i < level.grids.length; i++)
			{
				// Get the placeholder of the grid on the stage
				var gbPlaceholder:GridPlaceholder = this["grid_row" + (level.grids[i].row) + "_col" + (level.grids[i].col)];
				
				// Add the correct grid block to the pacman stage
				switch(level.grids[i].gridBlock)
				{
					case Grid.BLANK:
						var gbBlank:GBBlank = new GBBlank();
					
						gbBlank.name = Grid.BLANK;
						gbPlaceholder.SetGridBlock(Grid.BLANK);
						gbPlaceholder.addChild(gbBlank);
					break;
					case Grid.BOX:
						var gbBox:GBBox = new GBBox();
					
						gbBox.name = Grid.BOX;
						gbPlaceholder.SetGridBlock(Grid.BOX);
						gbPlaceholder.addChild(gbBox);
					break;
					case Grid.HORIZONTAL:
						var gbHorizontal:GBHorizontal = new GBHorizontal();
				
						gbHorizontal.name = Grid.HORIZONTAL;
						gbPlaceholder.SetGridBlock(Grid.HORIZONTAL);
						gbPlaceholder.addChild(gbHorizontal);
					break;
					case Grid.VERTICAL:
						var gbVertical:GBVertical = new GBVertical();
						
						gbVertical.name = Grid.VERTICAL;
						gbPlaceholder.SetGridBlock(Grid.VERTICAL);					
						gbPlaceholder.addChild(gbVertical);
					break;
					case Grid.END_UP:
						var gbEndUp:GBEndUp = new GBEndUp();

						gbEndUp.name = Grid.END_UP;
						gbPlaceholder.SetGridBlock(Grid.END_UP);
						gbPlaceholder.addChild(gbEndUp);
					break;
					case Grid.END_DOWN:
						var gbEndDown:GBEndDown = new GBEndDown();
				
						gbEndDown.name = Grid.END_DOWN;
						gbPlaceholder.SetGridBlock(Grid.END_DOWN);
						gbPlaceholder.addChild(gbEndDown);
					break;
					case Grid.END_RIGHT:
						var gbEndRight:GBEndRight = new GBEndRight();
				
						gbEndRight.name = Grid.END_RIGHT;
						gbPlaceholder.SetGridBlock(Grid.END_RIGHT);
						gbPlaceholder.addChild(gbEndRight);
					break;
					case Grid.END_LEFT:
						var gbEndLeft:GBEndLeft = new GBEndLeft();

						gbEndLeft.name = Grid.END_LEFT;
						gbPlaceholder.SetGridBlock(Grid.END_LEFT);
						gbPlaceholder.addChild(gbEndLeft);
					break;
					case Grid.LEFT_DOWN:
						var gbLeftDown:GBLeftDown = new GBLeftDown();

						gbLeftDown.name = Grid.LEFT_DOWN;
						gbPlaceholder.SetGridBlock(Grid.LEFT_DOWN);
						gbPlaceholder.addChild(gbLeftDown);
					break;
					case Grid.LEFT_UP:
						var gbLeftUp:GBLeftUp = new GBLeftUp();
				
						gbLeftUp.name = Grid.LEFT_UP;
						gbPlaceholder.SetGridBlock(Grid.LEFT_UP);
						gbPlaceholder.addChild(gbLeftUp);
					break;
					case Grid.RIGHT_DOWN:
						var gbRightDown:GBRightDown = new GBRightDown();

						gbRightDown.name = Grid.RIGHT_DOWN;
						gbPlaceholder.SetGridBlock(Grid.RIGHT_DOWN);
						gbPlaceholder.addChild(gbRightDown);
					break;
					case Grid.RIGHT_UP:
						var gbRightUp:GBRightUp = new GBRightUp();

						gbRightUp.name = Grid.RIGHT_UP;
						gbPlaceholder.SetGridBlock(Grid.RIGHT_UP);
						gbPlaceholder.addChild(gbRightUp);
					break;
					case Grid.T_HORIZONTAL_DOWN:
						var gbTHorizontalDown:GBTHorizontalDown = new GBTHorizontalDown();
				
						gbTHorizontalDown.name = Grid.T_HORIZONTAL_DOWN;
						gbPlaceholder.SetGridBlock(Grid.T_HORIZONTAL_DOWN);
						gbPlaceholder.addChild(gbTHorizontalDown);
					break;
					case Grid.T_HORIZONTAL_UP:
						var gbTHorizontalUp:GBTHorizontalUp = new GBTHorizontalUp();
				
						gbTHorizontalUp.name = Grid.T_HORIZONTAL_UP;
						gbPlaceholder.SetGridBlock(Grid.T_HORIZONTAL_UP);					
						gbPlaceholder.addChild(gbTHorizontalUp);
					break;
					case Grid.T_VERTCIAL_LEFT:
						var gbTVerticalLeft:GBTVerticalLeft = new GBTVerticalLeft();

						gbTVerticalLeft.name = Grid.T_VERTCIAL_LEFT;
						gbPlaceholder.SetGridBlock(Grid.T_VERTCIAL_LEFT);
						gbPlaceholder.addChild(gbTVerticalLeft);
					break;
					case Grid.T_VERTICAL_RIGHT:
						var gbTVerticalRight:GBTVerticalRight = new GBTVerticalRight();
			
						gbTVerticalRight.name = Grid.T_VERTICAL_RIGHT;
						gbPlaceholder.SetGridBlock(Grid.T_VERTICAL_RIGHT);
						gbPlaceholder.addChild(gbTVerticalRight);
					break;
					case Grid.CROSSROADS:
						var gbCrossroads:GBCrossroads = new GBCrossroads();
				
						gbCrossroads.name = Grid.CROSSROADS;
						gbPlaceholder.SetGridBlock(Grid.CROSSROADS);
						gbPlaceholder.addChild(gbCrossroads);
					break;
				}
				
				// Add pacman if pacman start is true
				if (level.grids[i].pacmanStart == true)
				{
					var pacman:Pacman = new Pacman();
					
					pacman.x = gbPlaceholder.x;
					pacman.y = gbPlaceholder.y;
					pacman.name = Grid.PACMAN;
					
					this.addChild(pacman);
				}else if (level.grids[i].apple == true){
					var apple:Apple = new Apple();
					
					apple.name = Grid.REWARD_APPLE;
					gbPlaceholder.addChild(apple);
				}else if (level.grids[i].cherry == true) {
					var cherry:Cherry = new Cherry();
					
					cherry.name = Grid.REWARD_CHERRY;
					gbPlaceholder.addChild(cherry);
				}else if (level.grids[i].strawberry == true){
					var strawberry:Strawberry = new Strawberry();
					
					strawberry.name =  Grid.REWARD_STRAWBERRY;
					gbPlaceholder.addChild(strawberry);
				}else if (level.grids[i].blinky == true) {
					var blinky:Blinky = new Blinky();
					
					blinky.name = Grid.MONSTER_BLINKY;
					gbPlaceholder.addChild(blinky);
				}else if (level.grids[i].clyde == true) {
					var clyde:Clyde = new Clyde();
					
					clyde.name = Grid.MONSTER_CLYDE;
					gbPlaceholder.addChild(clyde);
				}else if (level.grids[i].pinky == true) {
					var pinky:Pinky = new Pinky();
					
					pinky.name = Grid.MONSTER_PINKY;
					gbPlaceholder.addChild(pinky);
				}else if (level.grids[i].inky == true) {
					var inky:Inky = new Inky();
					
					gbPlaceholder.addChild(inky);
				}else if (level.grids[i].door == true) {
					var door:Door = new Door();
					
					door.name = Grid.DOOR;
					gbPlaceholder.addChild(door);
				}else if (level.grids[i].hole == true) {
					var hole:Hole = new Hole();
					
					hole.name = Grid.HOLE;

					if (level.grids[i].holeWithMonster == true)
					{
						hole.hasMonster = true;
						trace(i + " has mosnter");
					}
					
					gbPlaceholder.addChild(hole);
				}else if (level.grids[i].key.isKey == true) {
					var key:Key = new Key(level.grids[i].key);
					
					key.name = Grid.KEY;
					gbPlaceholder.addChild(key);
				}else if (level.grids[i].gridBlock != Grid.BLANK && level.grids[i].gridBlock != Grid.BOX) {
					var pacDot:PacDot = new PacDot();
					
					pacDot.name = Grid.PACDOT;
					gbPlaceholder.addChild(pacDot);
				}
			}
		}
	}
	
}
