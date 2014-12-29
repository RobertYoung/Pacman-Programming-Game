package com.game.scenes {
	
	import flash.display.MovieClip;
	import com.game.controls.*;
	import flash.system.Security;
	import com.game.elements.ControlDropDown;
	
	public class Controls extends MovieClip {
		
		public var controlDropDown_mc:ControlDropDown;
		public var controlSelect_mc:MovieClip;
		public var movementSelect_mc:MovieClip;
		
		public function Controls() {
			trace("Control Constructor");
			flash.system.Security.allowDomain("*");

			this.SwitchToMovement();
			this.TraceChildren();
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
			
			this.addChild(movementForward);
			
			var movementLeft:MovementLeft = new MovementLeft();
			
			movementLeft.name = Control.MOVEMENT_LEFT;
			movementLeft.x = 645;
			movementLeft.y = 720;
			movementLeft.nX = 645;
			movementLeft.nY = 720;
			
			this.addChild(movementLeft);
			
			var movementRight:MovementRight = new MovementRight();
			
			movementRight.name = Control.MOVEMENT_RIGHT;
			movementRight.x = 893;
			movementRight.y = 720;
			movementRight.nX = 893;
			movementRight.nY = 720;
			
			this.addChild(movementRight);
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
			
			this.addChild(ifClear);
			
			var ifClearEnd:ControlIfHoleClearEnd = new ControlIfHoleClearEnd();
			
			ifClearEnd.name = Control.CONTROL_IF_CLEAR_END;
			ifClearEnd.x = 537;
			ifClearEnd.y = 720;
			ifClearEnd.nX = 537;
			ifClearEnd.nY = 720;
			
			this.addChild(ifClearEnd);
			
			var elseClear:ControlElseHoleClear = new ControlElseHoleClear();
			
			elseClear.name = Control.CONTROL_ELSE_CLEAR;
			elseClear.x = 726;
			elseClear.y = 720;
			elseClear.nX = 726;
			elseClear.nY = 720;
			
			this.addChild(elseClear);
			
			var elseClearEnd:ControlElseHoleClearEnd = new ControlElseHoleClearEnd();
			
			elseClearEnd.name = Control.CONTROL_ELSE_CLEAR_END;
			elseClearEnd.x = 912;
			elseClearEnd.y = 720;
			elseClearEnd.nX = 912;
			elseClearEnd.nY = 720;
			
			this.addChild(elseClearEnd);
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
			
			this.addChild(loop);
			
			var endLoop:ControlLoopEnd = new ControlLoopEnd();
			
			endLoop.name = Control.CONTROL_LOOP_END;
			endLoop.x = 770;
			endLoop.y = 720;
			endLoop.nX = 770;
			endLoop.nY = 720;
			
			this.addChild(endLoop);
		}
		
		public function SwitchToActions()
		{
			this.ClearAllControls();
			
			var flashlight:ActionFlashlight = new ActionFlashlight();
			
			flashlight.name = Control.ACTION_FLASHLIGHT;
			flashlight.x = 770;
			flashlight.y = 720;
			flashlight.nX = 770;
			flashlight.nY = 720;
			
			this.addChild(flashlight);
		}
		
		//********************//
		// CLEAR ALL CONTROLS //
		//********************//
		private function ClearAllControls()
		{
			// Remove controls starting for the end of the array
			for (var i = (this.numChildren - 1); i > 0; i--)
			{
				trace(this.getChildAt(i).name);
				//trace(this.getChildAt(i).name);
				var pattern:RegExp = /^movement_|control_|actions_/;
				
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
	}
	
}
