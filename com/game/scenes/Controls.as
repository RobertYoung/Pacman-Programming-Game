package com.game.scenes {
	
	import flash.display.MovieClip;
	import com.game.controls.*;
	import flash.system.Security;
	
	public class Controls extends MovieClip {
		
		public function Controls() {
			flash.system.Security.allowDomain("*");

			this.SwitchToMovement();
		}
		
		//*******************//
		// SWITCH TO CONTROL //
		//*******************//
		public function SwitchToMovement()
		{
			this.ClearAllControls();
			
			var movementForward:MovementForward = new MovementForward();
			
			movementForward.name = "movement_forward";
			movementForward.x = 397;
			movementForward.y = 720;
			movementForward.nX = 397;
			movementForward.nY = 720;
			
			this.addChild(movementForward);
			
			var movementLeft:MovementLeft = new MovementLeft();
			
			movementLeft.name = "movement_left";
			movementLeft.x = 645;
			movementLeft.y = 720;
			movementLeft.nX = 645;
			movementLeft.nY = 720;
			
			this.addChild(movementLeft);
			
			var movementRight:MovementRight = new MovementRight();
			
			movementRight.name = "movement_right";
			movementRight.x = 893;
			movementRight.y = 720;
			movementRight.nX = 893;
			movementRight.nY = 720;
			
			this.addChild(movementRight);
			
			for (var i = 0; i < this.numChildren; i++)
			{
				trace(this.getChildAt(i).name);
			}
		}
		
		public function SwitchToControls()
		{
			this.ClearAllControls();
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
				//trace(this.getChildAt(i).name);
				var pattern:RegExp = /^movement_|controls_|actions_/;
				
				if (pattern.test(this.getChildAt(i).name))
				{
					this.removeChildAt(i);
				}
			}
		}
	}
	
}
