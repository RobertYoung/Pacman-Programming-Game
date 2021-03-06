﻿package com.game.factory {
	
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
	import flash.utils.Timer;
	import com.game.scenes.Controls;
	import fl.transitions.Tween;
	import com.greensock.events.TweenEvent;
	
	public class Game extends MovieClip {
		
		public static const SWF_MAIN:String = "root1";
		public static const SWF_LOGIN:String = "login";
		public static const SWF_MENU:String = "menu";
		public static const SWF_LOGO:String = "logo";
		public static const SWF_BACK_BUTTON:String = "back_button";
		public static const SWF_GAME:String = "game";
		public static const SWF_HELP:String = "help";
		public static const SWF_LEVEL_SELECTION:String = "level_selection";
		public static const SWF_ACHIEVEMENTS:String = "achievements";
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
		private var monsterHoleTimeline:TimelineMax = new TimelineMax();
		private var monsterHole;
		private var pacmanKeys:Number = 0;
		private var pacmanKeysActual:Number = 0;
		private var loopArray:Array = new Array(); 
		private var timer:Timer = new Timer(1000);
		private var monsterIfElseRandomTimeline:TimelineMax = new TimelineMax();
		
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
			levelData.username = PacmanSharedObjectHelper.getInstance().GetUsername();
			
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
			
			this.totalScore = PacmanSharedObjectHelper.getInstance().GetTotalScore();
			
			// Reset level data
			this.levelData.levelScore = 0;
			this.levelData.bonusScore = 0;
			this.levelData.appleScore = 0;
			this.levelData.cherryScore = 0;
			this.levelData.ifElseScore = 0;
			this.levelData.ifScore = 0;
			this.levelData.control = 0;
			this.levelData.completed = false;
			this.levelData.loopScore = 0;
			this.levelData.pacDotScore = 0;
			this.levelData.strawberryScore = 0;
			this.levelData.timeCompleted = 0;

			header.SetHighScoreText(this.levelData.highScore);
			header.SetScoreText(this.levelData.levelScore);
			header.SetTotalHighScoreText(this.totalScore);
			header.Init();
			timer.start();
			
			var controls:Controls = LoaderMax.getContent(Game.SWF_CONTROLS).rawContent as Controls;
			
			controls.Init();
			
			if (this.levelData.stageNumber == 2)
			{
				this.IfElseMonsterAnimation();
			}
			
			// Logic to set controls
			switch (PacmanSharedObjectHelper.getInstance().GetUserControls())
			{
				case 0:
				case 1:
					switch (this.levelData.stageNumber)
					{
						case 1:
							controls.SwitchToGraphical();
						break;
						case 2:
							controls.SwitchToTextualGraphical();
						break;
						case 3:
							controls.SwitchToTextual();
						break;
					}
				break;
				case 2:
					switch (this.levelData.stageNumber)
					{
						case 1:
							controls.SwitchToTextualGraphical();
						break;
						case 2:
							controls.SwitchToTextual();
						break;
						case 3:
							controls.SwitchToGraphical();
						break;
					}
				break;
				case 3:
					switch (this.levelData.stageNumber)
					{
						case 1:
							controls.SwitchToTextual();
						break;
						case 2:
							controls.SwitchToGraphical();
						break;
						case 3:
							controls.SwitchToTextualGraphical();
						break;
					}
				break;
			}
		}
		
		private function BackButtonPressed(e:MouseEvent)
		{
			var main:Main = this.root as Main;
			
			main.GoToLevelSelection(e, level.stageNumber);
		}
		
		private function BuildLevel()
		{
			level.ImplementHoleWithMonster();
			
			pacmanStage = new PacmanStage(level);

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
			pacmanTimeline.clear();
			monsterHoleTimeline.clear();
			pacmanSequence = new Array();
			pacmanTimeline = new TimelineMax();
			monsterHoleTimeline = new TimelineMax();
			pacmanKeys = 0;
			pacmanKeysActual = 0;
			levelData.levelScore = 0;
			levelData.bonusScore = 0;
			loopArray = new Array();
			timer.reset();
		}
		
		private function UpdateScores(incrementScoreBy:int)
		{
			this.levelData.levelScore += incrementScoreBy;
			header.SetScoreText(this.levelData.levelScore);
			
			if (this.levelData.levelScore > this.levelData.highScore){
				header.SetHighScoreText(this.levelData.levelScore);
				this.totalScore += incrementScoreBy;
				header.SetTotalHighScoreText(this.totalScore);
			}
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
			// Stop the timer
			this.levelData.timeCompleted = this.timer.currentCount;
			
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
		
		public function Stop()
		{
			this.ResetAfterUserError();
			this.ResetAllAnimations();
			this.ResetPlayState();
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
				this.levelData.pacDotScore += Game.SCORE_PAC_DOT;
			}
			
			//**********//
			// MONSTERS //
			//**********//
			// BLINKY
			if (currentGridPlaceholder.ElementExists(Grid.MONSTER_BLINKY) || currentGridPlaceholder.ElementExists(Grid.MONSTER_CLYDE) ||
				currentGridPlaceholder.ElementExists(Grid.MONSTER_INKY) || currentGridPlaceholder.ElementExists(Grid.MONSTER_PINKY))
			{
				var monsterAlertView:AlertView = new AlertView("Ooopppppps", "Pacman has been killed by a monster", "Navigate around the monster", this.ResetAfterUserError);
				this.addChild(monsterAlertView);
				this.pacmanTimeline.stop();
				return;
			}
			
			//*********//
			// REWARDS //
			//*********//
			if (currentGridPlaceholder.ElementExists(Grid.REWARD_APPLE))
			{
				currentGridPlaceholder.RemoveChildByName(Grid.REWARD_APPLE);
				this.UpdateScores(Game.SCORE_APPLE);
				this.levelData.appleScore += Game.SCORE_APPLE;
				LevelComplete();
				return;
			}
			
			if (currentGridPlaceholder.ElementExists(Grid.REWARD_CHERRY))
			{
				currentGridPlaceholder.RemoveChildByName(Grid.REWARD_CHERRY);
				this.UpdateScores(Game.SCORE_CHERRY);
				this.levelData.cherryScore += Game.SCORE_CHERRY;
				LevelComplete();
				return;
			}
			
			if (currentGridPlaceholder.ElementExists(Grid.REWARD_STRAWBERRY))
			{
				currentGridPlaceholder.RemoveChildByName(Grid.REWARD_STRAWBERRY);
				this.UpdateScores(Game.SCORE_STRAWBERRY);
				this.levelData.strawberryScore += Game.SCORE_STRAWBERRY;
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
			this.SaveIncompleteData();
			
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
			this.ResetAllAnimations();
			
			// Store level data
			levelData.pacmanSequence = this.pacmanSequence;
			levelData.completed = true;
			levelData.username = PacmanSharedObjectHelper.getInstance().GetUsername();
			
			this.SaveData(true);

			var pacmanWebService:PacmanWebService = new PacmanWebService();
			
			// Check for achievements
			if (levelData.timeCompleted <= 60) {
				// Less than 1 minute
				PacmanSharedObjectHelper.getInstance().SetTimeAchievement(1);
				pacmanWebService.SetTimeAchievement(1);
			}else if (levelData.timeCompleted <= 120) {
				// Less than 2 minutes
				PacmanSharedObjectHelper.getInstance().SetTimeAchievement(2);
				pacmanWebService.SetTimeAchievement(2);
			}else if (levelData.timeCompleted <= 180) {
				// Less than 3 minutes
				PacmanSharedObjectHelper.getInstance().SetTimeAchievement(3);
				pacmanWebService.SetTimeAchievement(3);
			}else if (levelData.timeCompleted <= 240) {
				// Less than 4 minutes
				PacmanSharedObjectHelper.getInstance().SetTimeAchievement(4);
				pacmanWebService.SetTimeAchievement(4);
			}else if (levelData.timeCompleted <= 300) {
				// Less than 5 minutes
				PacmanSharedObjectHelper.getInstance().SetTimeAchievement(5);
				pacmanWebService.SetTimeAchievement(5);
			}else if (levelData.timeCompleted <= 360){
				// Less than 6 minutes
				PacmanSharedObjectHelper.getInstance().SetTimeAchievement(6);
				pacmanWebService.SetTimeAchievement(6);
			}
			
			if (level.levelNumber == 6 && level.stageNumber == 3)
			{
				level.levelNumber = 0;
				level.stageNumber = 0;
			}else if (level.levelNumber == 6)
			{
				level.stageNumber += 1;
				level.levelNumber = 1;				
			}else{
				level.levelNumber += 1;
			}
			
			if (PacmanSharedObjectHelper.getInstance().GetGameCompletion() == true)
			{
				var gameComplete:LevelCompleteAlertView = new LevelCompleteAlertView(level.stageNumber, level.levelNumber, levelData.levelScore, levelData.highScore, levelData.bonusScore, "game complete", "CONGRATULATIONS!! You have successfully completed Program Pacman");
				
				this.addChild(gameComplete);
			}else{
				var levelComplete:LevelCompleteAlertView = new LevelCompleteAlertView(level.stageNumber, level.levelNumber, levelData.levelScore, levelData.highScore, levelData.bonusScore);
				
				this.addChild(levelComplete);
			}
			
			PacmanSharedObjectHelper.getInstance().SetStageAndLevel(level.stageNumber, level.levelNumber);
		}
		
		private function SaveData(isCompleted:Boolean)
		{
			PacmanSharedObjectHelper.getInstance().SetLevelData(this.level.stageNumber, this.level.levelNumber, levelData);
			this.SaveToDatabase(isCompleted);
		}
		
		private function SaveIncompleteData()
		{
			levelData.pacmanSequence = this.pacmanSequence;
			levelData.completed = false;
			
			PacmanSharedObjectHelper.getInstance().SetIncompleteLevelData(this.level.stageNumber, this.level.levelNumber, levelData);
			this.SaveToDatabase(false);
		}
		
		private function SaveToDatabase(isCompleted:Boolean)
		{
			var saveToDatabaseWebService:PacmanWebService = new PacmanWebService();

			this.levelData.username = this.main.usernameStored;
			
			saveToDatabaseWebService.SetLevelData(this.levelData, isCompleted);
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
						this.levelData.ifScore += Game.SCORE_IF;
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
						this.levelData.ifElseScore += Game.SCORE_IF_ELSE;
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
						
						var showMonsterFunction:Function = null;
					
						// Checks if the placeholder has a hole
						if (this.nextGridPlaceholder.ElementExists(Grid.HOLE))
						{
							var hole:Hole = this.nextGridPlaceholder.getChildByName(Grid.HOLE) as Hole;
							
							monsterHole = nextGridPlaceholder.getChildByName(Grid.MONSTER);
							
							if (monsterHole != null)
							{
								this.monsterHoleTimeline.add(new TweenLite(monsterHole, 2, { alpha: 1 }));
								this.monsterHoleTimeline.stop();
								showMonsterFunction = this.ShowMonster;
							}
						}
						
						pacmanTimeline.add(new TweenLite(pacmanMC, 2, { frame: 20, useFrames: true, ease:Linear.easeNone, onStart: showMonsterFunction }));
						pacmanTimeline.addLabel(Game.LABEL_FLASHLIGHT_ON);
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
						this.levelData.loopScore += Game.SCORE_LOOP;
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
		
		private function UpdateKeyOnHeader()
		{
			trace("Actual keys: " + this.pacmanKeysActual);
			this.header.UpdateKey(this.pacmanKeysActual);
		}
		
		//*********//
		// ACTIONS //
		//*********//
		private function ShowMonster()
		{
			this.monsterHoleTimeline.timeScale(1);
			this.monsterHoleTimeline.play();
		}
		
		private function TurnFlashLightOff()
		{
			trace("Flashlight off");
			this.monsterHoleTimeline.timeScale(30);
			this.monsterHoleTimeline.reverse();
			this.pacmanMC.gotoAndStop(1);
		}
		
		private function DecrementNumberOfKeys(key:MovieClip)
		{
			key["numberOfKeys_txt"].text -= 1;
			this.pacmanKeysActual++;
			this.UpdateKeyOnHeader();
		}
		
		private function RemoveElement(movieClip:MovieClip)
		{
			movieClip.parent.removeChild(movieClip);
		}
		
		private function RemoveDoor(movieClip:MovieClip)
		{
			this.pacmanKeysActual--;
			this.UpdateKeyOnHeader();
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
		
		public function SetLevelControl(setLevelControl:int)
		{
			this.levelData.control = setLevelControl;
		}
		
		//************************************//
		// IF - ELSE RANDOM MONSTER ANIMATION //
		//************************************//
		private function IfElseMonsterAnimation()
		{
			// Timeline
			var holeArray:Array = new Array();
			
			for (var row = 1; row <= 8; row++)
			{
				for (var col = 1; col <= 8; col++)
				{
					var gridPlaceholder:GridPlaceholder = pacmanStage["grid_row" + row + "_col" + col] as GridPlaceholder;
					
					if (gridPlaceholder.ElementExists(Grid.HOLE))
					{
						var gridHole:Hole = gridPlaceholder.getChildByName(Grid.HOLE) as Hole;
						var point:Point = gridPlaceholder.localToGlobal(new Point(gridHole.x, gridHole.y));
						holeArray.push(point);
					}
				}
			}
			
			for (var holeQuestionMark = 0; holeQuestionMark < holeArray.length; holeQuestionMark++)
			{
				var questionMark:QuestionMark = new QuestionMark();
				var questionMarkHolePoint:Point = holeArray[holeQuestionMark] as Point;
				var questionMarkAnimation:TimelineMax = new TimelineMax();
				
				questionMark.x = questionMarkHolePoint.x;
				questionMark.y = questionMarkHolePoint.y;
				
				this.addChild(questionMark);
				
				questionMarkAnimation.append(new TweenMax(questionMark, 5, { rotation:4000 }));
				questionMarkAnimation.append(new TweenMax(questionMark, 1, { rotation:-2000, autoAlpha:0 }));
				questionMarkAnimation.play();
			}
			
			for (var hole = 0; hole < holeArray.length; hole++)
			{
				var animation:TimelineMax = new TimelineMax();
				var monster:MovieClip = this.CreateRandomMonster();
				var holePoint:Point = holeArray[hole] as Point;
				
				monster.x = holePoint.x;
				monster.y = holePoint.y;
				monster.scaleX = 100;
				monster.scaleY = 100;
				monster.alpha = 0;
				
				this.addChild(monster);

				animation.append(new TweenMax(monster, 4, {scaleX:0, scaleY:0, autoAlpha:1, rotation:1000, ease:Bounce.easeOut, onComplete:ResetIfElseMonsterAnimation }));
				animation.play();
			}
		}
		
		private var monstersCreated:Array = new Array();
		
		private function CreateRandomMonster():MovieClip
		{
			var randomNum:Number = this.GenerateRandomNumber(1, 4);
			var monsterCreated:Boolean = false;
			
			while (monsterCreated == false)
			{
				if (this.monstersCreated.indexOf(randomNum) == -1)
				{
					monsterCreated = true;
					this.monstersCreated.push(randomNum);
					
					switch(randomNum)
					{
						case 1:
							return new Blinky();							
						case 2:
							return new Clyde();
						case 3:
							return new Pinky();
						case 4:
							return new Inky();
					}
				}else{
					randomNum = this.GenerateRandomNumber(1, 4);
				}
			}
			
			return null;
		}
		
		private function ResetIfElseMonsterAnimation()
		{
			if (this.monstersCreated.length > 0)
				this.monstersCreated = new Array();
		}
		
		private function GenerateRandomNumber(minVal:Number, maxVal:Number):Number
		{
			return (Math.floor(Math.random() * (maxVal - minVal + 1)) + minVal);
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
