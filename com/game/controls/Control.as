package com.game.controls {		import flash.display.MovieClip;	import flash.events.MouseEvent;	import flash.utils.*;
	import flash.events.TimerEvent;
	import com.game.elements.Stack;
	import com.game.factory.Game;
	import com.game.scenes.Main;
	import com.game.scenes.Controls;
	import flash.events.Event;
	import com.greensock.loading.display.ContentDisplay;
		public class Control extends MovieClip {		//***********//		// CONSTANTS //		//***********//		public static const MOVEMENT_FORWARD:String = "movement_forward";		public static const MOVEMENT_LEFT:String = "movement_left";		public static const MOVEMENT_RIGHT:String = "movement_right";
		public static const CONTROL_IF_CLEAR:String = "control_if_clear";
		public static const CONTROL_IF_CLEAR_END:String = "control_if_clear_end";
		public static const CONTROL_ELSE_CLEAR:String = "control_else_clear";
		public static const CONTROL_ELSE_CLEAR_END:String = "control_else_clear_end";
		public static const CONTROL_LOOP:String = "control_loop";		public static const CONTROL_LOOP_END:String = "control_loop_end";
		public static const ACTION_FLASHLIGHT:String = "action_flashlight";
		public static const ACTION_PICK_UP_KEY:String = "action_pick_up_key";
		public static const ACTION_USE_KEY:String = "action_use_key";
				//***********//		// VARIABLES //		//***********//		// Store point of where control dragged from		public var nX:int;		public var nY:int;
		
		// Information about the control
		public var controlName:String;
		public var controlDescription:String;
		
		
		var movementForward:MovementForward;
		var movementLeft:MovementLeft;
		var movementRight:MovementRight;
		var controlIfHoleClear:ControlIfHoleClear;
		var controlIfHoleClearEnd:ControlIfHoleClearEnd;
		var controlElseHoleClear:ControlElseHoleClear;
		var controlElseHoleClearEnd:ControlElseHoleClearEnd;
		var controlLoop:ControlLoop;
		var controlLoopEnd:ControlLoopEnd;
		var actionFlashlight:ActionFlashlight;
		var actionPickUpKey:ActionPickUpKey;
		var actionUseKey:ActionUseKey;
		var popupTimer:Timer;				//*************//		// CONSTRUCTOR //		//*************//		public function Control() {			nX = this.x;			nY = this.y;						this.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownFromControlArea);			this.addEventListener(MouseEvent.MOUSE_UP, OnMouseUpFromControlArea);
			
			this.gotoAndStop(1);		}				//**********************//		// MOUSE EVENT HANDLERS // 		//**********************//		function OnMouseDownFromControlArea(e:MouseEvent):void		{			this.startDrag();		}				function OnMouseUpFromControlArea(e:MouseEvent):void		{			this.stopDrag();						// Send movement back to control area if control			// is dropped on nothing			if (e.target.dropTarget == null)				MoveControlToControlArea();			else{				// Regular expression for the stack. E.g stack1, stack2				var pattern:RegExp = /stack\d/;				var stackPosition = e.target.dropTarget.parent;								// Check if the control is dropped on the coding area in a stack				// If it is, create new control				if (pattern.test(stackPosition.name))				{					AddControlToStack(e, stackPosition);				}else if (pattern.test(stackPosition.parent.name)){
					AddControlToStack(e, stackPosition.parent);
					stackPosition.parent.removeChild(stackPosition);				}else{
					MoveControlToControlArea();
				}			}		}
		
		function OnMouseDownFromStackArea(e:MouseEvent)
		{
			popupTimer = new Timer(1000, 1);
			
			popupTimer.start();
			popupTimer.addEventListener(TimerEvent.TIMER_COMPLETE, TimerCompleteDisplayPopup);
		}
		
		function OnMouseUpFromStackArea(e:MouseEvent)
		{
			popupTimer.stop();
		}		
		function AddOnMouseDownFromStackAreaEvent(e:Event)
		{
			this.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownFromStackArea);
		}
		
		//**********************//
		// TIMER EVENT HANDLERS //
		//**********************//
		function TimerCompleteDisplayPopup (e:TimerEvent) {
			this.removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownFromStackArea);
			
			var popup:PopUp = new PopUp(this);
			
			popup.x = mouseX;
			popup.y = mouseY;
			
			popup.addEventListener(Event.REMOVED_FROM_STAGE, this.AddOnMouseDownFromStackAreaEvent);
			
			this.addChild(popup);
		};
					//*******************//		// CREATE AND DELETE //		//*******************//		function CreateControl()		{			var MovementClass:Class = GetClass();			var newMovement = new MovementClass();
					newMovement.nX = nX;			newMovement.nY = nY;				newMovement.x = nX;			newMovement.y = nY;						newMovement.name = this.name;
					
			var game:ContentDisplay;
			var main:Main = this.stage.getChildAt(0) as Main;
			
			for (var i = 0; i < main.parent.numChildren; i++)
			{
				if (main.getChildAt(i).name == Game.SWF_GAME)
					game = main.getChildAt(i) as ContentDisplay;
			}
			
			var controls = game.rawContent.getChildByName(Game.SWF_CONTROLS);
			var controlsChild = controls.getChildAt(0);
			
			controlsChild.addChild(newMovement);		}				public function DeleteControl()		{
			var stack:Stack = this.parent as Stack;
			
			stack.removeChild(this);
			stack.controlInStack = "";		}				//**********//		// MOVEMENT //		//**********//		function MoveControlToControlArea()		{			this.x = nX;			this.y = nY;		}
		
		function AddControlToStack(e:MouseEvent, stackPosition:Stack)
		{
			e.target.removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownFromControlArea);
			e.target.removeEventListener(MouseEvent.MOUSE_UP, OnMouseUpFromControlArea);					
			e.target.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownFromStackArea);
			e.target.addEventListener(MouseEvent.MOUSE_UP, OnMouseUpFromStackArea);
			
			this.x = stackPosition.width / 2;
			this.y = stackPosition.height / 2;
		
			stackPosition.addChildAt(this, stackPosition.numChildren - 1);
			stackPosition.controlInStack = this.name;
		
			CreateControl();
		}				//*******************//		// CLASS INFORMATION //		//*******************//		function GetClass():Class {
			return getDefinitionByName(getQualifiedClassName(this)) as Class;		}	}}