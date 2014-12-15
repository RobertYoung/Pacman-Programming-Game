package com.game.controls {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.*;
	
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
			
			trace(e.target.dropTarget.parent.name);
			
			// Send movement back to control area if control
			// is dropped on nothing
			if (e.target.dropTarget == null)
				MoveMovementToControlArea();
			else{
				// Check if the control is dropped on the coding area
				// If it is, create new control
				if (e.target.dropTarget.parent.name == "scrollArea_mc")
				{
					e.target.removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownFromControlArea);
					e.target.removeEventListener(MouseEvent.MOUSE_UP, OnMouseUpFromControlArea);
					
					var scrollView:MovieClip = e.target.dropTarget.root["pacmanCodingArea_mc"]["scrollArea_mc"];
					
					this.x = scrollView.width / 2;
					this.y - 50;
					
					scrollView.addChild(this);
					
					CreateMovement();
				}else{
					MoveMovementToControlArea();
				}	
			}
		}
		
		//*******************//
		// CREATE AND DELETE //
		//*******************//
		function CreateMovement()
		{
			var MovementClass:Class = GetClass();
			var newMovement = new MovementClass();
				
			newMovement.nX = nX;
			newMovement.nY = nY;
	
			newMovement.x = nX;
			newMovement.y = nY;
			
			this.stage.addChild(newMovement);
		}
		
		function DeleteMovement()
		{
			
		}
		
		//**********//
		// MOVEMENT //
		//**********//
		function MoveMovementToControlArea()
		{
			this.x = nX;
			this.y = nY;
		}
		
		//*******************//
		// CLASS INFORMATION //
		//*******************//
		function GetClass():Class {
			return Class(getDefinitionByName(getQualifiedClassName(this)));
		}
	}
}
