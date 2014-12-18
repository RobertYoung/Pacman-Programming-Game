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
			
			// Send movement back to control area if control
			// is dropped on nothing
			if (e.target.dropTarget == null)
				MoveMovementToControlArea();
			else{
				// Regular expression for the stack. E.g stack1, stack2
				var pattern:RegExp = /stack\d/;
				var stackPosition = e.target.dropTarget.parent;
				
				trace(stackPosition.name);
				
				// Check if the control is dropped on the coding area in a stack
				// If it is, create new control
				if (pattern.test(stackPosition.name))
				{
					e.target.removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownFromControlArea);
					e.target.removeEventListener(MouseEvent.MOUSE_UP, OnMouseUpFromControlArea);
					
					//var stackPositionMC:MovieClip = e.target.dropTarget.root["pacmanCodingArea_mc"]["scrollArea_mc"][stackPosition.name];
					
					this.x = stackPosition.width / 2;
					this.y = stackPosition.height / 2;
					
					stackPosition.addChild(this);
					
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
