package com.game.factory {
	
	import com.game.scenes.Main;
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import com.game.controls.Control;
	import com.game.elements.*;
	import com.game.scenes.PacmanStage;
	import flash.geom.Point;
	import com.greensock.TimelineMax;
	import com.greensock.TweenLite;
	import flash.geom.Point;
	import com.game.elements.GridPlaceholder;
	import com.game.elements.gridblocks.GridBlock;
	import com.greensock.layout.AlignMode;
	import com.greensock.plugins.*;
	import com.greensock.easing.*;
	import com.game.controls.ControlElseHoleClear;
	import com.greensock.TweenMax;
	import com.game.controls.ControlLoop;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import com.game.factory.Game;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.events.LoaderEvent;
	import flash.system.Security;
	import flash.text.TextField;
	import com.game.scenes.BackButton;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.game.scenes.Header;
	
	public class Game extends MovieClip {
		
		public static const SWF_MAIN:String = "root1";
		public static const SWF_MENU:String = "menu";
		public static const SWF_LOGO:String = "logo";
		public static const SWF_BACK_BUTTON:String = "back_button";
		public static const SWF_GAME:String = "game";
		public static const SWF_LEVEL_SELECTION:String = "level_selection";
		public static const SWF_HEADER:String = "header";
		public static const SWF_PACMAN_STAGE:String = "pacman_stage";
		public static const SWF_PACMAN_STAGE_CONTAINER:String = "pacman_stage_container";
		public static const SWF_PACMAN_CODING_AREA:String = "pacman_code";
		public static const SWF_CONTROLS:String = "controls";
		
		public static const PACMAN_NORTH:String = "pacman_north";
		public static const PACMAN_EAST:String = "pacman_east";
		public static const PACMAN_SOUTH:String = "pacman_south";
		public static const PACMAN_WEST:String = "pacman_west";
		
		private static const LABEL_FLASHLIGHT_ON:String = "flashlight_on";
		
		private static const SCORE_PAC_DOT:int = 125;
		private static const SCORE_CHERRY:int = 555;
		private static const SCORE_APPLE:int = 755;
		private static const SCORE_STRAWBERRY:int = 955;
		private static const SCORE_IF:int = 2050;
		private static const SCORE_IF_ELSE:int = 2250;
		private static const SCORE_LOOP:int = 1895;
		
		private var main:Main;
		private var level:Level;
		private var header:Header;
		private var pacmanSequence:Array = new Array();
		private var pacmanTimeline:TimelineMax = new TimelineMax();
		private var stackContainer:DisplayObject
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
		private var pacmanKeys:Number = 0;
		private var loopArray:Array = new Array(); 
		
		// Level data
		var levelData:LevelData;
		var totalScore:int;

		public function Game(setLevel:Level = null) {
			level = setLevel;
			
			TweenPlugin.activate([FramePlugin]);
			
			flash.system.Security.allowDomain("*");

			if (level != null)
				LoadGame();
			
			this.levelData = PacmanSharedObjectHelper.getInstance().GetLevelData(level.stageNumber, level.levelNumber);
			
			this.addEventListener(Event.ADDED_TO_STAGE, Init);			
		}
		
		private function Init(e:Event)
		{
			main = this.stage.getChildAt(0) as Main;
		}
		
		public function LoadGame()
		{
			var queue = new LoaderMax({ name:"mainQueue", onComplete: OnCompleteBuildLevel});
		
			queue.append(new SWFLoader(Game.SWF_HEADER + ".swf", {name: Game.SWF_HEADER, container:this}));
			queue.append(new SWFLoader(Game.SWF_PACMAN_STAGE + ".swf", {name: Game.SWF_PACMAN_STAGE_CONTAINER, container:this}));
			queue.append(new SWFLoader(Game.SWF_PACMAN_CODING_AREA + ".swf", {name: Game.SWF_PACMAN_CODING_AREA, container:this}));
			queue.append(new SWFLoader(Game.SWF_BACK_BUTTON + ".swf", {name: Game.SWF_BACK_BUTTON, container:this}));
			queue.append(new SWFLoader(Game.SWF_CONTROLS + ".swf", {name: Game.SWF_CONTROLS, container:this}));
			
			queue.load();
		}
		
		private function OnCompleteBuildLevel(event:LoaderEvent)
		{
			BuildLevel();
			
			var backButton:BackButton = LoaderMax.getContent(Game.SWF_BACK_BUTTON).rawContent as BackButton;
			
			backButton.AddMouseUpEventListener(BackButtonPressed);
			
			header = LoaderMax.getContent(Game.SWF_HEADER).rawContent as Header;
			
			this.levelData.levelScore = 0;
			this.levelData.bonusScore = 0;
			this.totalScore = PacmanSharedObjectHelper.getInstance().GetTotalScore();

			header.SetHighScoreText(this.levelData.highScore);
			header.SetScoreText(this.levelData.levelScore);
			header.SetTotalHighScoreText(this.totalScore);
		}
		
		private function BackButtonPressed(e:MouseEvent)
		{
			var main:Main = this.root as Main;
			
			main.GoToLevelSelection(e, level.stageNumber);
		}
		
		private function BuildLevel()
		{
			var pacmanStage:PacmanStage = new PacmanStage(level);

			pacmanStage.x = 280;
			pacmanStage.y = 400;
			pacmanStage.name = Game.SWF_PACMAN_STAGE;

			this.addChildAt(pacmanStage, 1);
		}
		
		public function ReloadLevel()
		{
			ResetAllAnimations();
			
			for (var i = (this.numChildren - 1); i >= 0; i--)
				this.removeChildAt(i);
			
			LoadGame();
		}
		
		public function ResetAfterUserError()
		{
			this.removeChild(this.getChildByName(Game.SWF_HEADER));
			this.removeChild(this.getChildByName(Game.SWF_PACMAN_STAGE));
			this.removeChild(this.getChildByName(Game.SWF_PACMAN_STAGE_CONTAINER));
			this.removeChild(this.getChildByName(Game.SWF_CONTROLS));
			
			var queue = new LoaderMax({ name:"mainQueue", onComplete: OnCompleteBuildLevel});
		
			queue.append(new SWFLoader(Game.SWF_HEADER + ".swf", {name: Game.SWF_HEADER, container:this}));
			queue.append(new SWFLoader(Game.SWF_PACMAN_STAGE + ".swf", {name: Game.SWF_PACMAN_STAGE_CONTAINER, container:this}));
			queue.append(new SWFLoader(Game.SWF_CONTROLS + ".swf", {name: Game.SWF_CONTROLS, container:this}));
			
			queue.load();
		}
		
		public function ResetPlayState()
		{
			pacmanSequence = new Array();
			pacmanTimeline = new TimelineMax();
			monsterTimeline = new TimelineMax();
			pacmanKeys = 0;
			levelData.levelScore = 0;
			levelData.bonusScore = 0;
			loopArray = new Array();
		}
		
		private function UpdateScores(incrementScoreBy:int)
		{
			this.levelData.levelScore += incrementScoreBy;
			header.SetScoreText(this.levelData.levelScore);
			
			if (this.levelData.levelScore > this.levelData.highScore)
				header.SetHighScoreText(this.levelData.levelScore);
			
			this.totalScore += incrementScoreBy;
			header.SetTotalHighScoreText(this.totalScore);
		}
		
		private function UpdateBonusScore(incrementScoreBy:int)
		{
			this.levelData.bonusScore += incrementScoreBy;
			this.levelData.levelScore += incrementScoreBy;
			this.totalScore += incrementScoreBy;
		}

		//**************//
		// GAME BUTTONS //
		//**************//
		public function Play() {
			// Reset the game state if they have pressed play already
			this.ResetPlayState();
			
			// Adds the stack elements to an array
			this.AddControlsToArray();
			
			// Create variables for the movie clips
			this.pacmanStage = this.getChildByName(Game.SWF_PACMAN_STAGE) as MovieClip;//["rawContent"].getChildByName(Game.SWF_PACMAN_STAGE);
			this.pacmanMC = pacmanStage.getChildByName(Grid.PACMAN) as MovieClip;
			
			if (this.pacmanMC == null) 
				throw new Error("Pacman MovieClip not found on Pacman Stage");
			
			// Bring pacman to the front
			this.pacmanStage.setChildIndex(pacmanMC, pacmanStage.numChildren - 1);
			
			// Find which grid position Pacman is currently at
			this.FindPacmanGridPoint()
			
			// Sets the pacman rotationZ to the pacman stored rotationZ which is set from the JSON data
			this.pacmanRotationZ = this.pacmanMC.rotationZ;
			
			// Go throw the controls in the array and identify the action 
			// pacman should take
			this.CompileSequence();
			
			// Start the animation
			this.pacmanTimeline.play();
		}

		//******************//
		// CONTROLS METHODS //
		//******************//
		private function AddControlsToArray()
		{
			// Get list of all the sequences on the stack
			stackContainer = this.getChildByName(Game.SWF_PACMAN_CODING_AREA)["rawContent"]["pacmanCodingArea_mc"]["scrollArea_mc"]["stackContainer_mc"];
			var stackLength = 1;
			var inLoop:Boolean = false;
			var loopArray:Array = new Array();
			
			while (stackContainer["stack" + stackLength] != null)
			{
				var controlInStack:String = stackContainer["stack" + stackLength].controlInStack;
			
				pacmanSequence.push(controlInStack);
				
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
			if (currentGridPlaceholder.ElementExists(Grid.PACDOT)) {
				currentGridPlaceholder.RemoveChildByName(Grid.PACDOT);
				this.UpdateScores(Game.SCORE_PAC_DOT);
			}
			
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
				this.UpdateScores(Game.SCORE_APPLE);
				LevelComplete();
				return;
			}
			
			if (currentGridPlaceholder.ElementExists(Grid.REWARD_CHERRY))
			{
				currentGridPlaceholder.RemoveChildByName(Grid.REWARD_CHERRY);
				this.UpdateScores(Game.SCORE_CHERRY);
				LevelComplete();
				return;
			}
			
			if (currentGridPlaceholder.ElementExists(Grid.REWARD_STRAWBERRY))
			{
				currentGridPlaceholder.RemoveChildByName(Grid.REWARD_STRAWBERRY);
				this.UpdateScores(Game.SCORE_STRAWBERRY);
				LevelComplete();
				return;
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
		private function SequenceIncorrectAlertView(hint:String)
		{
			this.ResetAllAnimations();
			
			var alertView:AlertView = new AlertView("Alert", "The sequence you entered is not correct, please try again", hint, this.ResetAfterUserError);
			
			this.addChild(alertView);
		}
		
		private function NoControlAdded()
		{
			this.SequenceIncorrectAlertView("Are there any missing controls?");
		}
		
		private function InvalidSequenceDueToPaths()
		{
			this.SequenceIncorrectAlertView("Take it a step at a time");
		}
		
		private function MissingIfClear()
		{
			this.SequenceIncorrectAlertView("All 'End If' controls must have a matching 'If Clear'");
		}
		
		private function MissingIfClearEnd()
		{
			this.SequenceIncorrectAlertView("All 'If Clear' controls must end with an 'End If'");
		}
		
		private function MissingElseClear()
		{
			this.SequenceIncorrectAlertView("All 'End Else' controls must have a matching 'Else'");
		}
		
		private function MissingElseClearEnd()
		{
			this.SequenceIncorrectAlertView("All 'Else' controls must end with an 'End Else'");
		}
		
		private function MissingFlashLight()
		{
			this.SequenceIncorrectAlertView("Pacman can't see if the hole is clear. Try using the flashlight");
		}
		
		private function MissingHoleCheck()
		{
			this.SequenceIncorrectAlertView("You need to check if the hole is clear first before moving over it");
		}
		
		private function NoKeyAlertView()
		{
			this.SequenceIncorrectAlertView("Are you sure there is a key to pick up in this grid?");
		}
		
		private function NoKeyToOpenDoorAlertView()
		{
			this.SequenceIncorrectAlertView("You need a key to open the door");
		}
		
		private function NoDoorAlertView()
		{
			this.SequenceIncorrectAlertView("There seems to be no door open");
		}
		
		private function DoorInPath()
		{
			this.SequenceIncorrectAlertView("There is a door in the way! It needs a key and then unlocked to be opened");
		}
		
		private function NoLoopAmountInputted()
		{
			this.SequenceIncorrectAlertView("The loop control needs an amount entering - How many times should it loop?");
		}
		
		private function IncorrectLoopAmountInputted()
		{
			this.SequenceIncorrectAlertView("The loop amount cannot be 0 or 1");
		}
		
		private function MissingLoopEnd()
		{
			this.SequenceIncorrectAlertView("The Loop control needs a Loop End");
		}
		
		private function LevelRequiresLoop()
		{
			this.ResetAllAnimations();
			
			var alertView:AlertView = new AlertView("Loop Control", "Stage 3 requires you to use loops", "Select Loop from the controls at the bottom - Make sure it has a start and end loop", this.ResetAfterUserError);
			
			this.addChild(alertView);
		}
		
		private function LevelComplete()
		{
			trace("COMPLETE: Next Level...");
			this.ResetAllAnimations();
			
			// Store level data
			levelData.pacmanSequence = this.pacmanSequence;
			levelData.timeCompleted = null;
			levelData.completed = true;
			
			PacmanSharedObjectHelper.getInstance().SetLevelData(this.level.stageNumber, this.level.levelNumber, levelData);
			
			if (level.levelNumber == 6 && level.stageNumber == 3)
			{
				trace("GAME COMPLETE");
				return;
			}else if (level.levelNumber == 6)
			{
				level.stageNumber += 1;
				level.levelNumber = 1;				
			}else{
				level.levelNumber += 1;
			}
			
			var levelComplete:LevelCompleteAlertView = new LevelCompleteAlertView(level.stageNumber, level.levelNumber, levelData.levelScore, levelData.highScore, levelData.bonusScore);
			
			this.addChild(levelComplete);
			
			PacmanSharedObjectHelper.getInstance().SetStageAndLevel(level.stageNumber, level.levelNumber);
		}
		
		private function CompileSequence()
		{
			// Make sure the user is using loops in stage 3
			if (this.level.stageNumber == 3 && pacmanSequence.indexOf(Control.CONTROL_LOOP) == -1)
			{
				this.LevelRequiresLoop();
				
				return;
			}

			for (var stackPos = 0; stackPos < pacmanSequence.length; stackPos++)
			{
				switch(pacmanSequence[stackPos])
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
								// Check if the next grid block is a hole
								if (this.nextGridPlaceholder.ElementExists(Grid.HOLE))
								{
									// If it is, check if it has been checked for monsters
									if (!this.ControlExistsBefore(Control.ACTION_FLASHLIGHT, stackPos).exists)
									{
										pacmanTimeline.add(new TweenLite(pacmanMC, 2, { onStart: this.MissingHoleCheck }));
										return;
									}
								}
								
								// Check if there is a door
								var gridDoor:Door = this.currentGridPlaceholder.getChildByName(Grid.DOOR) as Door;
								
								if (gridDoor)// && this.pacmanSequence[stackPos - 1] != Control.ACTION_USE_KEY)
								{
									if (!gridDoor.isOpen)
									{
										pacmanTimeline.add(new TweenLite(pacmanMC, 2, { onStart: this.DoorInPath }));
										return;
									}
								}
								
								// Store new grid position
								var point:Point = new Point(nextGridPlaceholder.x, nextGridPlaceholder.y);
							
								// Create animation
								pacmanTimeline.add(new TweenLite(pacmanMC, 2, { x: nextGridPlaceholder.x, y: nextGridPlaceholder.y, onComplete: UpdatePacmanStage, onCompleteParams: [ this.nextPacmanPoint ], onStart: this.TurnFlashLightOff, onComplete: UpdateScores }));
								
								pacmanPoint = this.nextPacmanPoint;
							}else{
								pacmanTimeline.add(new TweenLite(pacmanMC, 2, { onStart: InvalidSequenceDueToPaths }));
							}
						}else{
							pacmanTimeline.add(new TweenLite(pacmanMC, 2, { onStart: InvalidSequenceDueToPaths }));
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
					case Control.CONTROL_IF_CLEAR:
						// Check if flashlight is on
						var pacmanLabelsArray = pacmanTimeline.getLabelsArray();
						var flashlightOn:Boolean = false;
					
						for (var pacmanLabel in pacmanLabelsArray)
						{
							if (pacmanLabelsArray[pacmanLabel].name == Game.LABEL_FLASHLIGHT_ON)
							{
								if (pacmanLabelsArray[pacmanLabel].time == pacmanTimeline.duration())
									flashlightOn = true;
							}
						}
						
						var controlIfClearEndExists:ControlExists = this.ControlExistsAfter(Control.CONTROL_IF_CLEAR_END, stackPos);

						// Display error that there is no if clear end
						if (controlIfClearEndExists.exists == false)
						{
							pacmanTimeline.add(new TweenLite(pacmanMC, 2, { onStart: this.MissingIfClearEnd }));
							return;
						}
						
						if (flashlightOn == false)
						{
							pacmanTimeline.add(new TweenLite(pacmanMC, 2, { onStart: this.MissingFlashLight }));
							break;
						}
							
						// If monster hole is null, hole is clear
						if (this.monsterHole == null)
						{
							trace("Hole is clear");
							// Play sequence until ifClearEndPosision
						}else{
							// Go to CONTORL_IF_CLEAR_END
							trace("There is a monster!");
							stackPos = controlIfClearEndExists.position;
						}
						
						this.UpdateBonusScore(Game.SCORE_IF);
					break;
					case Control.CONTROL_IF_CLEAR_END:
						// Check there is a matching IF_CLEAR
						var controlIfClearExists:ControlExists = this.ControlExistsBefore(Control.CONTROL_IF_CLEAR, stackPos);

						if (controlIfClearExists.exists == false)
						{
							this.MissingIfClear();
							return;
						}
						
						// Check if the next control is a CONTROL_ELSE_CLEAR
						var nextPos:Number = stackPos + 1;
						
						if (pacmanSequence[nextPos] == Control.CONTROL_ELSE_CLEAR)
						{
							var controlIfElseClearEndExists:ControlExists = this.ControlExistsAfter(Control.CONTROL_ELSE_CLEAR_END, stackPos);
							
							// Display error that there is no if clear end
							if (controlIfElseClearEndExists.exists == false)
							{
								pacmanTimeline.add(new TweenLite(pacmanMC, 2, { onStart: this.MissingElseClearEnd }));
								return;
							}
							
							stackPos = controlIfElseClearEndExists.position;
						}
					break;
					case Control.CONTROL_ELSE_CLEAR:
						var controlElseClearEndExists:ControlExists = this.ControlExistsAfter(Control.CONTROL_ELSE_CLEAR_END, stackPos);
					
						if (controlElseClearEndExists.exists == false)
						{
							pacmanTimeline.add(new TweenLite(pacmanMC, 2, { onStart: this.MissingElseClearEnd }));
							return;
						}
						
						this.UpdateBonusScore(Game.SCORE_IF_ELSE);
					break;
					case Control.CONTROL_ELSE_CLEAR_END:
						var controlElseClearExists:ControlExists = this.ControlExistsBefore(Control.CONTROL_ELSE_CLEAR, stackPos);
					
						if (controlElseClearExists.exists == false)
						{
							pacmanTimeline.add(new TweenLite(pacmanMC, 2, { onStart: this.MissingElseClear }));
							return;
						}
					break;
					case Control.ACTION_FLASHLIGHT:
						pacmanTimeline.add(new TweenLite(pacmanMC, 2, { frame: 20, useFrames: true, ease:Linear.easeNone, onStart: this.ShowMonster }));
						pacmanTimeline.addLabel(Game.LABEL_FLASHLIGHT_ON);
						
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
						if (this.nextGridPlaceholder.ElementExists(Grid.HOLE))
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
					case Control.ACTION_PICK_UP_KEY:
						// Gets the current grid placeholder of pacman
						this.GetCurrentGridplaceholder();
						// Gets the current grid block inside the place holder of pacman
						this.GetCurrentGridBlock();
					
						var key:Key;
					
						if (this.currentGridPlaceholder.ElementExists(Grid.KEY))
						{
							key = this.currentGridPlaceholder.getChildByName(Grid.KEY) as Key;
						}
					
						// Check if key exists in the current grid
						if (key == null || key.key.actualNumberOfKeys == 0)
						{
							pacmanTimeline.add(new TweenLite(pacmanMC, 2, { onStart: this.NoKeyAlertView }));
							return;
						}
						
						this.pacmanKeys++;
						
						// Check how many keys there are
						if (key.key.actualNumberOfKeys > 1)
						{
							pacmanTimeline.add(new TweenMax(key, 1, { glowFilter: { color: 0xffffff, alpha: 1, blurX: 30, blurY: 30, strength: 2 }, ease: Sine.easeIn, onComplete: this.DecrementNumberOfKeys, onCompleteParams: [ key ] }));
							pacmanTimeline.add(new TweenMax(key, 1, { glowFilter: { color: 0xffffff, alpha: 0, blurX: 30, blurY: 30 }, ease: Sine.easeIn }));
						}else{
							pacmanTimeline.add(new TweenMax(key, 0.8, { glowFilter: { color: 0xffffff, alpha: 1, blurX: 30, blurY: 30, strength: 2 }, ease: Sine.easeIn, onComplete: this.DecrementNumberOfKeys, onCompleteParams: [ key ] }));
							pacmanTimeline.add(new TweenMax(key, 0.8, { glowFilter: { color: 0xffffff, alpha: 0, blurX: 30, blurY: 30 }, ease: Sine.easeIn }));
							pacmanTimeline.add(new TweenLite(key, 0.4, { alpha: 0, onComplete: this.RemoveElement, onCompleteParams: [key] }));
						}
						
						key.key.actualNumberOfKeys--;
					break;
					case Control.ACTION_USE_KEY:
						// Gets the current grid placeholder of pacman
						this.GetCurrentGridplaceholder();
						// Gets the current grid block inside the place holder of pacman
						this.GetCurrentGridBlock();
					
						if (!this.currentGridPlaceholder.ElementExists(Grid.DOOR))
						{
							pacmanTimeline.add(new TweenLite(pacmanMC, 2, { onStart: this.NoDoorAlertView }));
							return;
						}
					
						// Validate pacman has a key to open the door
						if (this.pacmanKeys < 1)
						{
							pacmanTimeline.add(new TweenLite(pacmanMC, 2, { onStart: this.NoKeyToOpenDoorAlertView }));
							return;
						}
						
						var door:Door = this.currentGridPlaceholder.getChildByName(Grid.DOOR) as Door;
						
						pacmanTimeline.add(new TweenLite(door, 2, { alpha: 0, onComplete: this.RemoveDoor, onCompleteParams: [door] }));
						
						door.SetOpen();
						
						this.pacmanKeys--;
					break;
					case Control.CONTROL_LOOP:
						// Gets the current grid placeholder of pacman
						this.GetCurrentGridplaceholder();
						// Gets the current grid block inside the place holder of pacman
						this.GetCurrentGridBlock();
					
						var currentStack:Stack = this.stackContainer["stack" + (stackPos + 1)];
						trace("currentStack: " + currentStack);
						var loop:ControlLoop = currentStack.getChildByName(Control.CONTROL_LOOP) as ControlLoop;
						var loopTimes:Number = loop.GetLoopTimes();
					
						// Checks if there is any number inputted for the loop amount
						if (isNaN(loopTimes))
						{
							this.NoLoopAmountInputted();
							return;
						}
						
						// Checks to see if 0 or 1 has been inputted
						if (loopTimes <= 1)
						{
							pacmanTimeline.add(new TweenLite(pacmanMC, 2, { onStart: this.IncorrectLoopAmountInputted }));
							return;
						}
						
						var loopEndExists:ControlExists = this.ControlExistsAfter(Control.CONTROL_LOOP_END, stackPos);
						
						// Checks if there is a loop end
						if (!loopEndExists.exists)
						{
							pacmanTimeline.add(new TweenLite(pacmanMC, 2, { onStart: this.MissingLoopEnd }));
							return;
						}
						
						var newLoop:Loop = new Loop(stackPos, loopTimes - 1);
						
						this.loopArray.unshift(newLoop);
						
						this.UpdateBonusScore(Game.SCORE_LOOP);
					break;
					case Control.CONTROL_LOOP_END:
						// Get the first loop in the array
						var currentLoop:Loop = this.loopArray[0] as Loop;
					
						// If it doesnt' exist, carry on
						if (currentLoop == null)
							return;
						
						// Check the amount of times it needs to loop
						if (currentLoop.amount > 0)
						{
							stackPos = currentLoop.startPosition;
							currentLoop.amount--;
						}else{
							// If it reaches 0, remove it from the array (remove from 0 position)
							this.loopArray.shift();
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
		
		//*********//
		// ACTIONS //
		//*********//
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
		
		private function DecrementNumberOfKeys(key:MovieClip)
		{
			key["numberOfKeys_txt"].text -= 1;
		}
		
		private function RemoveElement(movieClip:MovieClip)
		{
			movieClip.parent.removeChild(movieClip);
		}
		
		private function RemoveDoor(movieClip:MovieClip)
		{
			this.RemoveElement(movieClip);
		}
		
		private function ControlExistsBefore(controlName:String, fromPosition:Number):ControlExists
		{
			for (var i = fromPosition; i > 0; i--)
			{
				if (pacmanSequence[i] == controlName)
					return new ControlExists(true, i);
			}
			
			return new ControlExists();
		}
		
		private function ControlExistsAfter(controlName:String, fromPosition:Number):ControlExists
		{
			for (var i = fromPosition; i < pacmanSequence.length; i++)
			{
				if (pacmanSequence[i] == controlName)
					return new ControlExists(true, i);
			}
			
			return new ControlExists();
		}
		
		//********************//
		// NEXT LEVEL METHODS //
		//********************//
		private function NextLevel()
		{
			trace("Next Level");
		}
		
		//*******************//
		// GET LEVEL DETAILS //
		//*******************//
		public function GetLevelDetails():Level
		{
			return this.level;
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

class ControlExists
{
	public var exists:Boolean;
	public var position:Number;
	
	public function ControlExists(controlExists:Boolean = false, controlPosition:Number = 0)
	{
		this.exists = controlExists;
		this.position = controlPosition;
	}
}

class Loop
{
	public var startPosition:Number;
	public var amount:Number;
	
	public function Loop(setStartPosition:Number, setAmount:Number)
	{
		this.startPosition = setStartPosition;
		this.amount = setAmount;
	}
}
