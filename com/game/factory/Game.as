package com.game.factory {
	
	import com.game.scenes.Main;
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import com.game.controls.Control;
	import com.game.elements.*;
	import flash.geom.Point;
	import com.greensock.TimelineMax;
	import com.greensock.TweenLite;
	
	public class Game {

		public static const SWF_MAIN:String = "main";
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
			
			// Bring pacman to the front
			pacmanStage.setChildIndex(pacmanMC, pacmanStage.numChildren - 1);
			
			// Find which grid position Pacman is currently at
			FindPacmanGridPoint()
			
			for (var stack in pacmanSequence)
			{
				switch(pacmanSequence[stack])
				{
					case Control.MOVEMENT_FORWARD:
						var newPacmanPoint:Point = new Point(pacmanPoint.x, pacmanPoint.y);
					
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
				
						var newPacmanGrid:GridPlaceholder = pacmanStage["grid_row" + newPacmanPoint.x + "_col" + newPacmanPoint.y];
						var point:Point = new Point(newPacmanGrid.x, newPacmanGrid.y);
					
						pacmanTimeline.add(new TweenLite(pacmanMC, 2, { x: newPacmanGrid.x, y: newPacmanGrid.y }));
						
						pacmanPoint = newPacmanPoint;
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
				
				trace(CalculatePacmanCardinalDirection());
			}
			
			
			
			pacmanTimeline.play();
		}
		
		private function AddControlsToArray()
		{
			// Get list of all the sequences on the stack
			var stackContainer:DisplayObject = main.getChildByName(Game.SWF_PACMAN_CODING_AREA)["rawContent"]["pacmanCodingArea_mc"]["scrollArea_mc"]["scrollArea_mc"];
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
	}
	
}
