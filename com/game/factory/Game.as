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
	import com.greensock.layout.AlignMode;
	import com.greensock.plugins.*;
	import com.greensock.easing.*;
	
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
		private var pacmanMC:MovieClip;
		private var pacmanPoint:Point;
		private var pacmanRotationZ:int;
		private var currentGridPlaceholder:GridPlaceholder;
		private var currentGridBlock:GridBlock;
		private var pacmanCardinalDirection:String;
		private var nextPacmanPoint:Point;
		private var nextGridPlaceholder:GridPlaceholder;
		private var nextGridBlock:GridBlock;
		private var monsterTimeline:TimelineMax = new TimelineMax();
		private var monsterHole;

		public function Game(mc:Main) {
			main = mc;
			
			TweenPlugin.activate([FramePlugin]);
		}

		//**************//
		// GAME BUTTONS //
		//**************//
		public function Play() {
			// Adds the stack elements to an array
			AddControlsToArray();
			
			// Create variables for the movie clips
			pacmanStage = main.getChildByName(Game.SWF_PACMAN_STAGE)["rawContent"].getChildByName(Game.SWF_PACMAN_STAGE);
			pacmanMC = pacmanStage.getChildByName(Grid.PACMAN) as MovieClip;
			
			if (pacmanMC == null) 
				throw new Error("Pacman MovieClip not found on Pacman Stage");
			
			// Bring pacman to the front
			pacmanStage.setChildIndex(pacmanMC, pacmanStage.numChildren - 1);
			
			// Find which grid position Pacman is currently at
			FindPacmanGridPoint()
			
			// Go throw the controls in the array and identify the action 
			// pacman should take
			CompileSequence();
			
			// Start the animation
			pacmanTimeline.play();
		}
		
		public function Reset()
		{
			main.ReloadLevel();
		}
		
		public function ResetAfterUserError()
		{
			main.ResetAfterUserError();
		}

		//******************//
		// CONTROLS METHODS //
		//******************//
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
		
		//**********************//
		// PACMAN STAGE METHODS //
		//**********************//
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
		private function CalculatePacmanCardinalDirection()
		{
			var moduloRotation = pacmanRotationZ % 360;

			switch (moduloRotation)
			{
				case -270:
				case 90:
					pacmanCardinalDirection = Game.PACMAN_SOUTH;
				break;
				case -180:
				case 180:
					pacmanCardinalDirection = Game.PACMAN_WEST;
				break;
				case -90:
				case 270:
					pacmanCardinalDirection = Game.PACMAN_NORTH;
				break;
				case 0:
					pacmanCardinalDirection = Game.PACMAN_EAST;
				break;
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
				LevelComplete();
			}
			
			if (currentGridPlaceholder.ElementExists(Grid.REWARD_CHERRY))
			{
				currentGridPlaceholder.RemoveChildByName(Grid.REWARD_CHERRY);
				LevelComplete();
			}
			
			if (currentGridPlaceholder.ElementExists(Grid.REWARD_STRAWBERRY))
			{
				currentGridPlaceholder.RemoveChildByName(Grid.REWARD_STRAWBERRY);
				LevelComplete();
			}
		}
		
		//*******************//
		// ANIMATION METHODS //
		//*******************//
		public function ResetAllAnimations()
		{
			pacmanTimeline.clear();
		}
		
		//*************//
		// ALERT VIEWS //
		//*************//
		private function NoControlAdded()
		{
			this.ResetAllAnimations();
			
			var alertView:AlertView = new AlertView("Alert", "The sequence you entered is not correct, please try again", "Are there any missing controls?", this.ResetAfterUserError);
			
			main.addChild(alertView);
		}
		
		private function InvalidSequenceDueToPaths()
		{
			this.ResetAllAnimations();
			
			var incorrectSequenceAlertView:AlertView = new AlertView("Ooops", "The sequence you entered is not correct, please try again", "Take it a step at a time", this.ResetAfterUserError);
								
			main.addChild(incorrectSequenceAlertView);
		}
		
		private function LevelComplete()
		{
			trace("COMPLETE: Next Level...");
			this.ResetAllAnimations();
			
			var levelComplete:AlertView = new AlertView("Well Done !", "You have successfully reached the end of the level", "", this.NextLevel);
			
			main.addChild(levelComplete);
		}
		
		private function CompileSequence()
		{
			trace(pacmanSequence);
			for (var stack in pacmanSequence)
			{
				switch(pacmanSequence[stack])
				{
					case null:
						pacmanTimeline.add(new TweenLite(pacmanMC, 2, { onStart: NoControlAdded }));
					break;
					case Control.MOVEMENT_FORWARD:
						// Gets the current grid placeholder of pacman
						this.GetCurrentGridplaceholder();
						// Gets the current grid block inside the place holder of pacman
						this.GetCurrentGridBlock();
						// The position pacman is facing
						this.CalculatePacmanCardinalDirection();
						// Point instance for the next grid position
						this.GetNextPacmanPoint();
						// The next grid which Pacman will move too
						this.GetNextGridPlaceholder();
						// The next grid block within the grid placeholder
						this.GetNextGridBlock();
						
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
								pacmanTimeline.add(new TweenLite(pacmanMC, 2, { x: nextGridPlaceholder.x, y: nextGridPlaceholder.y, onComplete: UpdatePacmanStage, onCompleteParams: [ this.nextPacmanPoint ], onStart: this.TurnFlashLightOff }));
								
								pacmanPoint = this.nextPacmanPoint;
							}else{
								pacmanTimeline.add(new TweenLite(pacmanMC, 2, { onStart: InvalidSequenceDueToPaths }));
								//throw new Error("Cannot move to that path due to next path");
							}
						}else{
							pacmanTimeline.add(new TweenLite(pacmanMC, 2, { onStart: InvalidSequenceDueToPaths }));
							//throw new Error("Cannot move to that path due to current path");
						};
					break;
					case Control.MOVEMENT_LEFT:
						pacmanRotationZ -= 90;
						pacmanTimeline.add(new TweenLite(pacmanMC, 2, { rotationZ: pacmanRotationZ, onStart: this.TurnFlashLightOff }));
					break;
					case Control.MOVEMENT_RIGHT:
						pacmanRotationZ += 90;
						pacmanTimeline.add(new TweenLite(pacmanMC, 2, { rotationZ: pacmanRotationZ, onStart: this.TurnFlashLightOff }));
					break;
					case Control.ACTION_FLASHLIGHT:
						pacmanTimeline.add(new TweenLite(pacmanMC, 2, { frame: 20, useFrames: true, ease:Linear.easeNone, onStart: this.ShowMonster}));
						
						// The next grid
						// Gets the current grid placeholder of pacman
						this.GetCurrentGridplaceholder();
						// Gets the current grid block inside the place holder of pacman
						this.GetCurrentGridBlock();
						// The position pacman is facing
						this.CalculatePacmanCardinalDirection();
						// Point instance for the next grid position
						this.GetNextPacmanPoint();
						// The next grid which Pacman will move too
						this.GetNextGridPlaceholder();
						
						// Checks if the placeholder has a hole
						if (this.nextGridPlaceholder.getChildByName(Grid.HOLE))
						{
							var hole:Hole = this.nextGridPlaceholder.getChildByName(Grid.HOLE) as Hole;
							
							monsterHole = nextGridPlaceholder.getChildByName(Grid.MONSTER);
							
							if (monsterHole != null)
							{
								this.monsterTimeline.add(new TweenLite(monsterHole, 2, { alpha: 1 }));
								this.monsterTimeline.stop();
							}
						}
					break;
				}
			}
		}

		private function GetCurrentGridplaceholder()
		{
			// Gets the current grid placeholder of pacman
			this.currentGridPlaceholder = this.GetGridPlaceholderFromPoint(pacmanPoint.x, pacmanPoint.y);
		}
		
		private function GetCurrentGridBlock()
		{
			this.currentGridBlock =	this.currentGridPlaceholder.GetGridBlockMovieClip();
		}
		
		private function GetNextPacmanPoint()
		{
			this.nextPacmanPoint = new Point(pacmanPoint.x, pacmanPoint.y);
					
			// Find out which way pacman is facing then move forward in that direct
			switch (pacmanCardinalDirection)
			{
				case Game.PACMAN_NORTH:
					this.nextPacmanPoint.x -= 1;
				break;
				case Game.PACMAN_EAST:
					this.nextPacmanPoint.y += 1;
				break;
				case Game.PACMAN_SOUTH:
					this.nextPacmanPoint.x += 1;
				break;
				case Game.PACMAN_WEST:
					this.nextPacmanPoint.y -= 1;
				break;
			}
		}
		
		private function GetNextGridPlaceholder()
		{
			nextGridPlaceholder = pacmanStage["grid_row" + this.nextPacmanPoint.x + "_col" + this.nextPacmanPoint.y];
		}
		
		private function GetNextGridBlock()
		{
			nextGridBlock = nextGridPlaceholder.GetGridBlockMovieClip();
		}
		
		private function ShowMonster()
		{
			this.monsterTimeline.play();
		}
		
		private function TurnFlashLightOff()
		{
			this.pacmanMC.gotoAndStop(1);
			this.monsterTimeline.timeScale(4);
			this.monsterTimeline.reverse();
		}
		
		//********************//
		// NEXT LEVEL METHODS //
		//********************//
		private function NextLevel()
		{
			trace("Next Level");
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
		}
	}
	
}
