package com.game.controls {		import flash.display.MovieClip;	import flash.events.MouseEvent;	import flash.utils.*;
	import flash.events.TimerEvent;
		public class Control extends MovieClip {		//***********//		// CONSTANTS //		//***********//		public static const MOVEMENT_FORWARD:String = "movement_forward";		public static const MOVEMENT_LEFT:String = "movement_left";		public static const MOVEMENT_RIGHT:String = "movement_right";				//***********//		// VARIABLES //		//***********//		// Store point of where control dragged from		public var nX:int;		public var nY:int;
		
		var movementForward:MovementForward;
		var movementLeft:MovementLeft;
		var movementRight:MovementRight;
		
		var popupTimer:Timer;				//*************//		// CONSTRUCTOR //		//*************//		public function Control() {			nX = this.x;			nY = this.y;						this.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownFromControlArea);			this.addEventListener(MouseEvent.MOUSE_UP, OnMouseUpFromControlArea);
			
			this.gotoAndStop(1);		}				//**********************//		// MOUSE EVENT HANDLERS // 		//**********************//		function OnMouseDownFromControlArea(e:MouseEvent):void		{			this.startDrag();		}				function OnMouseUpFromControlArea(e:MouseEvent):void		{			this.stopDrag();						// Send movement back to control area if control			// is dropped on nothing			if (e.target.dropTarget == null)				MoveMovementToControlArea();			else{				// Regular expression for the stack. E.g stack1, stack2				var pattern:RegExp = /stack\d/;				var stackPosition = e.target.dropTarget.parent;								// Check if the control is dropped on the coding area in a stack				// If it is, create new control				if (pattern.test(stackPosition.name))				{					e.target.removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownFromControlArea);					e.target.removeEventListener(MouseEvent.MOUSE_UP, OnMouseUpFromControlArea);					
					e.target.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownFromStackArea);
					e.target.addEventListener(MouseEvent.MOUSE_UP, OnMouseUpFromStackArea);
										this.x = stackPosition.width / 2;					this.y = stackPosition.height / 2;										stackPosition.addChild(this);					stackPosition.controlInStack = this.name;					
										CreateMovement();				}else{					MoveMovementToControlArea();				}				}		}
		
		function OnMouseDownFromStackArea(e:MouseEvent)
		{
			trace("OnMouseDownFromStackArea");
			popupTimer = new Timer(1000, 1);
			
			popupTimer.start();
			popupTimer.addEventListener(TimerEvent.TIMER_COMPLETE, TimerCompleteDisplayPopup);
		}
		
		function OnMouseUpFromStackArea(e:MouseEvent)
		{
			popupTimer.stop();
		}		
		//**********************//
		// TIMER EVENT HANDLERS //
		//**********************//
		function TimerCompleteDisplayPopup (e:TimerEvent) {
			// Display popup
			trace("popup");
			
			var popup:PopUp = new PopUp();
			
			popup.x = mouseX;
			popup.y = mouseY;
			
			this.addChild(popup);
		};
					//*******************//		// CREATE AND DELETE //		//*******************//		function CreateMovement()		{			var MovementClass:Class = GetClass();			var newMovement = new MovementClass();
					newMovement.nX = nX;			newMovement.nY = nY;				newMovement.x = nX;			newMovement.y = nY;						newMovement.name = this.name;						this.stage.addChild(newMovement);		}				function DeleteMovement()		{					}				//**********//		// MOVEMENT //		//**********//		function MoveMovementToControlArea()		{			this.x = nX;			this.y = nY;		}				//*******************//		// CLASS INFORMATION //		//*******************//		function GetClass():Class {
			return getDefinitionByName(getQualifiedClassName(this)) as Class;		}	}}