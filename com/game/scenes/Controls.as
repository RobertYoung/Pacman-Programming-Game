package com.game.scenes {
	
	import flash.display.MovieClip;
	import com.game.controls.*;
	import flash.system.Security;
	import com.game.elements.ControlDropDown;
	import com.game.factory.Game;
	import com.greensock.loading.LoaderMax;
	import com.game.factory.PacmanSharedObjectHelper;
	import com.game.elements.Stack;
	
	public class Controls extends MovieClip {
		
		public static const CONTROLS_TEXTUAL:int = 1;
		public static const CONTROLS_GRAPHICAL:int = 2;
		public static const CONTROLS_TEXTUAL_GRAPHICAL:int = 3;
		public static const CONTROLS_MOVEMENT:String = "controls_movement";
		public static const CONTROLS_IF:String = "controls_if";
		public static const CONTROLS_LOOP:String = "controls_loop";
		public static const CONTROLS_ACTION:String = "controls_action";
		
		public var game:Game;
		
		public var controlDropDown_mc:ControlDropDown;
		public var controlSelect_mc:MovieClip;
		public var movementSelect_mc:MovieClip;
		
		private var currentSymbol:int = 0;
		private var currentControl:String = Controls.CONTROLS_MOVEMENT;
		
		public function Controls() {
			if (this.currentSymbol == 0)
				this.currentSymbol = PacmanSharedObjectHelper.getInstance().GetUserControlsSymbol();
		}
		
		//******//
		// INIT //
		//******//
		public function Init()
		{
			var main:Main = this.stage.getChildAt(0) as Main;
			
			if (main != null) {
				game = main.getChildByName(Game.SWF_GAME) as Game;
			}

			this.SwitchToMovement();
			game.SetLevelControl(this.currentSymbol);
		}
		
		//*******************//
		// SWITCH TO CONTROL //
		//*******************//
		public function SwitchToMovement()
		{
			this.ClearAllControls();
			
			var movementForward:MovementForward = new MovementForward();
			
			movementForward.name = Control.MOVEMENT_FORWARD;
			movementForward.x = 397;
			movementForward.y = 720;
			movementForward.nX = 397;
			movementForward.nY = 720;
			movementForward.gotoAndStop(this.currentSymbol);
			
			this.addChild(movementForward);
			
			var movementLeft:MovementLeft = new MovementLeft();
			
			movementLeft.name = Control.MOVEMENT_LEFT;
			movementLeft.x = 645;
			movementLeft.y = 720;
			movementLeft.nX = 645;
			movementLeft.nY = 720;
			movementLeft.gotoAndStop(this.currentSymbol);
			
			this.addChild(movementLeft);
			
			var movementRight:MovementRight = new MovementRight();
			
			movementRight.name = Control.MOVEMENT_RIGHT;
			movementRight.x = 893;
			movementRight.y = 720;
			movementRight.nX = 893;
			movementRight.nY = 720;
			movementRight.gotoAndStop(this.currentSymbol);
			
			this.addChild(movementRight);
			
			this.currentControl = Controls.CONTROLS_MOVEMENT;
		}
		
		public function SwitchToIfClear()
		{
			this.ClearAllControls();
			
			var ifClear:ControlIfHoleClear = new ControlIfHoleClear();
			
			ifClear.name = Control.CONTROL_IF_CLEAR;
			ifClear.x = 350;
			ifClear.y = 720;
			ifClear.nX = 350;
			ifClear.nY = 720;
			ifClear.gotoAndStop(this.currentSymbol);
			
			this.addChild(ifClear);
			
			var ifClearEnd:ControlIfHoleClearEnd = new ControlIfHoleClearEnd();
			
			ifClearEnd.name = Control.CONTROL_IF_CLEAR_END;
			ifClearEnd.x = 537;
			ifClearEnd.y = 720;
			ifClearEnd.nX = 537;
			ifClearEnd.nY = 720;
			ifClearEnd.gotoAndStop(this.currentSymbol);
			
			this.addChild(ifClearEnd);
			
			var elseClear:ControlElseHoleClear = new ControlElseHoleClear();
			
			elseClear.name = Control.CONTROL_ELSE_CLEAR;
			elseClear.x = 726;
			elseClear.y = 720;
			elseClear.nX = 726;
			elseClear.nY = 720;
			elseClear.gotoAndStop(this.currentSymbol);
			
			this.addChild(elseClear);
			
			var elseClearEnd:ControlElseHoleClearEnd = new ControlElseHoleClearEnd();
			
			elseClearEnd.name = Control.CONTROL_ELSE_CLEAR_END;
			elseClearEnd.x = 912;
			elseClearEnd.y = 720;
			elseClearEnd.nX = 912;
			elseClearEnd.nY = 720;
			elseClearEnd.gotoAndStop(this.currentSymbol);
			
			this.addChild(elseClearEnd);
			
			this.currentControl = Controls.CONTROLS_IF;
		}
		
		public function SwitchToLoop()
		{
			this.ClearAllControls();
			
			var loop:ControlLoop = new ControlLoop();
			
			loop.name = Control.CONTROL_LOOP;
			loop.x = 478;
			loop.y = 720;
			loop.nX = 478;
			loop.nY = 720;
			loop.gotoAndStop(this.currentSymbol);
			
			this.addChild(loop);
			
			var endLoop:ControlLoopEnd = new ControlLoopEnd();
			
			endLoop.name = Control.CONTROL_LOOP_END;
			endLoop.x = 770;
			endLoop.y = 720;
			endLoop.nX = 770;
			endLoop.nY = 720;
			endLoop.gotoAndStop(this.currentSymbol);
			
			this.addChild(endLoop);
			
			this.currentControl = Controls.CONTROLS_LOOP;
		}
		
		public function SwitchToActions()
		{
			this.ClearAllControls();
			
			var flashlight:ActionFlashlight = new ActionFlashlight();
			
			flashlight.name = Control.ACTION_FLASHLIGHT;
			flashlight.x = 380;
			flashlight.y = 720;
			flashlight.nX = 380;
			flashlight.nY = 720;
			flashlight.gotoAndStop(this.currentSymbol);
			
			this.addChild(flashlight);
			
			var pickUpKey:ActionPickUpKey = new ActionPickUpKey();
			
			pickUpKey.name = Control.ACTION_PICK_UP_KEY;
			pickUpKey.x = 623;
			pickUpKey.y = 720;
			pickUpKey.nX = 623;
			pickUpKey.nY = 720;
			pickUpKey.gotoAndStop(this.currentSymbol);
			
			this.addChild(pickUpKey);
			
			var useKey:ActionUseKey = new ActionUseKey();
			
			useKey.name = Control.ACTION_USE_KEY;
			useKey.x = 867;
			useKey.y = 720;
			useKey.nX = 867;
			useKey.nY = 720;
			useKey.gotoAndStop(this.currentSymbol);
			
			this.addChild(useKey);
			
			this.currentControl = Controls.CONTROLS_ACTION;
		}
		
		//********************//
		// CLEAR ALL CONTROLS //
		//********************//
		private function ClearAllControls()
		{
			// Remove controls starting for the end of the array
			for (var i = (this.numChildren - 1); i > 0; i--)
			{
				var pattern:RegExp = /^movement_|control_|action_/;
				
				if (pattern.test(this.getChildAt(i).name))
				{
					this.removeChildAt(i);
				}
			}
		}
		
		//***************//
		// DEBUG METHODS //
		//***************//
		public function TraceChildren()
		{
			for (var i = 0; i < this.numChildren; i++)
				trace(this.getChildAt(i).name);
		}
		
		//*******************************//
		// SWITCHING TEXTUAL / GRAPHICAL //
		//*******************************//
		public function SwitchToTextual()
		{
			trace("Switch to textual");
			PacmanSharedObjectHelper.getInstance().SetUserControlsSymbol(Controls.CONTROLS_TEXTUAL);
			this.currentSymbol = Controls.CONTROLS_TEXTUAL;
			game.SetLevelControl(Controls.CONTROLS_TEXTUAL);
			this.ReloadControls();
		}
		
		public function SwitchToGraphical()
		{
			trace("switch to graphical");
			PacmanSharedObjectHelper.getInstance().SetUserControlsSymbol(Controls.CONTROLS_GRAPHICAL);
			this.currentSymbol = Controls.CONTROLS_GRAPHICAL;
			game.SetLevelControl(Controls.CONTROLS_GRAPHICAL);
			this.ReloadControls();
		}
		
		public function SwitchToTextualGraphical()
		{
			trace("switch to textual graphical");
			PacmanSharedObjectHelper.getInstance().SetUserControlsSymbol(Controls.CONTROLS_TEXTUAL_GRAPHICAL);
			this.currentSymbol = Controls.CONTROLS_TEXTUAL_GRAPHICAL;
			game.SetLevelControl(Controls.CONTROLS_TEXTUAL_GRAPHICAL);
			this.ReloadControls();
		}
		
		private function ReloadControls()
		{
			switch (this.currentControl)
			{
				case Controls.CONTROLS_MOVEMENT:
					this.SwitchToMovement();
				break;
				case Controls.CONTROLS_IF:
					this.SwitchToIfClear();
				break;
				case Controls.CONTROLS_LOOP:
					this.SwitchToLoop();
				break;
				case Controls.CONTROLS_ACTION:
					this.SwitchToActions();
				break;
			}
			
			var pacmanCodingArea:MovieClip = LoaderMax.getContent(Game.SWF_PACMAN_CODING_AREA).rawContent as MovieClip;
			var pacmanCodingAreaMC:MovieClip = pacmanCodingArea.getChildByName("pacmanCodingArea_mc") as MovieClip;
			var scrollArea:MovieClip = pacmanCodingAreaMC.getChildByName("scrollArea_mc") as MovieClip;
			var stackContainer:MovieClip = scrollArea.getChildByName("stackContainer_mc") as MovieClip;
			
			var i = 1;
			
			while (stackContainer["stack" + i] != null)
			{
				var stack:Stack = stackContainer["stack" + i] as Stack;
				var controlInStack:String = stack.controlInStack;
				
				if (controlInStack)
				{
					var control:Control = stack.getChildByName(controlInStack) as Control;
					control.gotoAndStop(this.currentSymbol);
				}
				
				i++;
			}
		}
	}
	
}
