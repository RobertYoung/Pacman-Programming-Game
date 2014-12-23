package com.game.factory {
	
	import com.game.scenes.Main;
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import com.game.controls.Control;
	import com.game.elements.*;
	import flash.geom.Point;
	import com.greensock.TimelineMax;
	import com.greensock.TweenLite;
	import flash.geom.Point;
	import com.game.elements.GridPlaceholder;
	import com.game.elements.gridblocks.GridBlock;
	
	public class Game {

		public static const SWF_MAIN:String = "root1";
		public static const SWF_HEADER:String = "header";
		public static const SWF_PACMAN_STAGE:String = "pacman_stage";
		public static const SWF_PACMAN_CODING_AREA:String = "pacman_code";
		public static const SWF_CONTROLS:String = "controls";
		
		public static const PACMAN_NORTH:String = "pacman_north";
		public static const PACMAN_EAST:String = "pacman_east";
		public static const PACMAN_SOUTH:String = "pacman_south";
		public static const PACMAN_WEST:String = "pacman_west";
		
		private var main:Main;
		private var pacmanSequence:Array = new Array();
		private var pacmanTimeline:TimelineMax = new TimelineMax();
		private var pacmanStage:MovieClip;
		private var pacmanMC:DisplayObject;
		private var pacmanPoint:Point;
		private var pacmanRotationZ:int;
		
		public function Game(mc:Main) {
			main = mc;
		}

		public function Play() {
			// Adds the stack elements to an array
			AddControlsToArray();
			
			// Create variables for the movie clips
			pacmanStage = main.getChildByName(Game.SWF_PACMAN_STAGE)["rawContent"].getChildByName(Game.SWF_PACMAN_STAGE);
			pacmanMC = pacmanStage.getChildByName(Grid.PACMAN);
			
			if (pacmanMC == null)
				throw new Error("Pacman MovieClip not found on Pacman Stage");
			
			// Bring pacman to the front
			pacmanStage.setChildIndex(pacmanMC, pacmanStage.numChildren - 1);
			
			// Find which grid position Pacman is currently at
			FindPacmanGridPoint()
			
			for (var stack in pacmanSequence)
			{
				switch(pacmanSequence[stack])
				{
					case Control.MOVEMENT_FORWARD:
						// Gets the current grid placeholder of pacman
						var currentGridPlaceholder:GridPlaceholder = GetGridPlaceholderFromPoint(pacmanPoint.x, pacmanPoint.y);
						// Gets the current grid block inside the place holder of pacman
						var currentGridBlock:GridBlock = currentGridPlaceholder.GetGridBlockMovieClip();
						// The position pacman is facing
						var pacmanCardinalDirection = CalculatePacmanCardinalDirection();
						// Point instance for the next grid position
						var newPacmanPoint:Point = new Point(pacmanPoint.x, pacmanPoint.y);
					
						// Find out which way pacman is facing then move forward in that direct
						switch (CalculatePacmanCardinalDirection())
						{
							case Game.PACMAN_NORTH:
								newPacmanPoint.x -= 1;
							break;
							case Game.PACMAN_EAST:
								newPacmanPoint.y += 1;
							break;
							case Game.PACMAN_SOUTH:
								newPacmanPoint.x += 1;
							break;
							case Game.PACMAN_WEST:
								newPacmanPoint.y -= 1;
							break;
						}
						
						// The next grid which Pacman will move too
						var nextGridPlaceholder:GridPlaceholder = pacmanStage["grid_row" + newPacmanPoint.x + "_col" + newPacmanPoint.y];
						var nextGridBlock:GridBlock = nextGridPlaceholder.GetGridBlockMovieClip();
						
 						if (currentGridBlock.allowedPaths.getPos(pacmanCardinalDirection) != null)
						{
							var oppositePacmanCardinalDirection;
							
							switch (pacmanCardinalDirection)
							{
								case Game.PACMAN_EAST:
									oppositePacmanCardinalDirection = Game.PACMAN_WEST;
								break;
								case Game.PACMAN_NORTH:
									oppositePacmanCardinalDirection = Game.PACMAN_SOUTH;
								break;
								case Game.PACMAN_SOUTH:
									oppositePacmanCardinalDirection = Game.PACMAN_NORTH;
								break;
								case Game.PACMAN_WEST:
									oppositePacmanCardinalDirection = Game.PACMAN_EAST;
								break;
							}
							
							// Check that pacman is allowed to move into next block
							if (nextGridBlock.allowedPaths.getPos(oppositePacmanCardinalDirection) != null)
							{
								// Store new grid position
								var point:Point = new Point(nextGridPlaceholder.x, nextGridPlaceholder.y);
							
								// Create animation
								pacmanTimeline.add(new TweenLite(pacmanMC, 2, { x: nextGridPlaceholder.x, y: nextGridPlaceholder.y, onComplete: UpdatePacmanStage, onCompleteParams: [ newPacmanPoint ] }));
								
								pacmanPoint = newPacmanPoint;
							}else{
								throw new Error("Cannot move to that path due to next path");
							}
						}else{
							throw new Error("Cannot move to that path due to current path");
						};
					break;
					case Control.MOVEMENT_LEFT:
						pacmanRotationZ -= 90;
						pacmanTimeline.add(new TweenLite(pacmanMC, 2, { rotationZ: pacmanRotationZ }));
					break;
					case Control.MOVEMENT_RIGHT:
						pacmanRotationZ += 90;
						pacmanTimeline.add(new TweenLite(pacmanMC, 2, { rotationZ: pacmanRotationZ }));
					break;
				}
			}
			
			pacmanTimeline.play();
		}
		
		public function Reset()
		{
			main.ReloadLevel();
		}
		
		private function AddControlsToArray()
		{
			// Get list of all the sequences on the stack
			var stackContainer:DisplayObject = main.getChildByName(Game.SWF_PACMAN_CODING_AREA)["rawContent"]["pacmanCodingArea_mc"]["scrollArea_mc"]["stackContainer_mc"];
			var stackLength = 1;
			
			while (stackContainer["stack" + stackLength] != null)
			{
				pacmanSequence.push(stackContainer["stack" + stackLength].controlInStack);
				stackLength++;
			}
		}
		
		private function FindPacmanGridPoint()
		{
			for (var row = 1; row <= 8; row++)
			{
				for (var col = 1; col <= 8; col++)
				{
					if (pacmanMC.hitTestObject(pacmanStage["grid_row" + row + "_col" + col]))
						pacmanPoint = new Point(row, col);
				}
			}
		}
		
		// Finds which way Pacman is facing
		// NORTH - SOUTH - EAST - WEST
		private function CalculatePacmanCardinalDirection():String
		{
			var moduloRotation = pacmanRotationZ % 360;

			switch (moduloRotation)
			{
				case -270:
				case 90:
					return Game.PACMAN_SOUTH;
				case -180:
				case 180:
					return Game.PACMAN_WEST;
				case -90:
				case 270:
					return Game.PACMAN_NORTH;
				case 0:
					return Game.PACMAN_EAST;
				default:
					throw new Error("Error: Cannot calculate pacman cardinal direction");
			}
		}
		
		// Returns the grid placeholder from the given X and Y co-ordinates
		private function GetGridPlaceholderFromPoint(x:int, y:int):GridPlaceholder
		{
			return pacmanStage["grid_row" + x + "_col" + y];
		}
		
		private function UpdatePacmanStage(updatePacmanPoint:Point)
		{
			var currentGridPlaceholder:GridPlaceholder = GetGridPlaceholderFromPoint(updatePacmanPoint.x, updatePacmanPoint.y);
			
			trace(currentGridPlaceholder.TraceChildren());
			
			//***************//
			// GAME ELEMENTS //
			//***************//
			// PACDOT
			if (currentGridPlaceholder.ElementExists(Grid.PACDOT))
				currentGridPlaceholder.RemoveChildByName(Grid.PACDOT);
			
			if (currentGridPlaceholder.ElementExists(Grid.DOOR))
				currentGridPlaceholder.RemoveChildByName(Grid.DOOR);
			
			if (currentGridPlaceholder.ElementExists(Grid.KEY))
				currentGridPlaceholder.RemoveChildByName(Grid.KEY);
			
			//**********//
			// MONSTERS //
			//**********//
			// BLINKY
			if (currentGridPlaceholder.ElementExists(Grid.MONSTER_BLINKY))
				trace("GAME OVER");
			
			// CLYDE
			if (currentGridPlaceholder.ElementExists(Grid.MONSTER_CLYDE))
				trace("GAME OVER");
			
			// INKY
			if (currentGridPlaceholder.ElementExists(Grid.MONSTER_INKY))
				trace("GAME OVER");
			
			// PINKY
			if (currentGridPlaceholder.ElementExists(Grid.MONSTER_PINKY))
				trace("GAME OVER");
			
			//*********//
			// REWARDS //
			//*********//
			if (currentGridPlaceholder.ElementExists(Grid.REWARD_APPLE))
			{
				currentGridPlaceholder.RemoveChildByName(Grid.REWARD_APPLE);
				trace("COMPLETE: Next Level...");
			}
			
			if (currentGridPlaceholder.ElementExists(Grid.REWARD_CHERRY))
			{
				currentGridPlaceholder.RemoveChildByName(Grid.REWARD_CHERRY);
				trace("COMPLETE: Next Level...");
			}
			
			if (currentGridPlaceholder.ElementExists(Grid.REWARD_STRAWBERRY))
			{
				currentGridPlaceholder.RemoveChildByName(Grid.REWARD_STRAWBERRY);
				trace("COMPLETE: Next Level...");
			}
		}
		
		//************//
		// EXTENSIONS //
		//************//
		// Get the position of an item in an array
		Array.prototype.getPos = function (item)
		{
			for (var i = 0; i < this.length; ++i)
			{
				if (this[i] == item)
				{
					return i;
				}
			}
			return null;
		};
	}
	
}
