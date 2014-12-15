package com.game.controls {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class Movement extends MovieClip {

		//***********//
		// VARIABLES //
		//***********//
		// Store point of where control dragged from
		public var nX:int;
		public var nY:int;
		
		//*************//
		// CONSTRUCTOR //
		//*************//
		public function Movement() {
			nX = this.x;
			nY = this.y;
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownFromControlArea);
			this.addEventListener(MouseEvent.MOUSE_UP, OnMouseUpFromControlArea);
		}
		
		//**********************//
		// MOUSE EVENT HANDLERS // 
		//**********************//
		function OnMouseDownFromControlArea(e:MouseEvent):void
		{
			this.startDrag();
		}
		
		function OnMouseUpFromControlArea(e:MouseEvent):void
		{
			this.stopDrag();
			
			if (e.target.dropTarget.parent.name == "pacmanCodingArea_mc")
			{
				e.target.removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownFromControlArea);
				e.target.removeEventListener(MouseEvent.MOUSE_UP, OnMouseUpFromControlArea);
				
				var newMovement:MovementForward = new MovementForward();
				
				newMovement.nX = nX;
				newMovement.nY = nY;
		
				newMovement.x = nX;
				newMovement.y = nY;
				
				this.stage.addChild(newMovement);
			}else{
				this.x = nX;
				this.y = nY;
			}
		}
	}
}
