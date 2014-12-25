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
		
		public function SwitchToControls()
		{
			this.ClearAllControls();
			
			var ifElse:ControlIfElse = new ControlIfElse();
			
			ifElse.name = Control.CONTROL_IF_ELSE;
			ifElse.x = 450;
			ifElse.y = 720;
			ifElse.nX = 450;
			ifElse.nY = 720;
			
			this.addChild(ifElse);
			
			var loop:ControlLoop = new ControlLoop();
			
			loop.name = Control.CONTROL_LOOP;
			loop.x = 823;
			loop.y = 720;
			loop.nX = 823;
			loop.nY = 720;
			
			this.addChild(loop);
		}
		
		public function SwitchToActions()
		{
			this.ClearAllControls();
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
