﻿package com.game.controls {
	import flash.events.TimerEvent;
	
		
		var movementForward:MovementForward;
		var movementLeft:MovementLeft;
		var movementRight:MovementRight;
		
		var popupTimer:Timer;
			
			this.gotoAndStop(1);
					e.target.addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDownFromStackArea);
					e.target.addEventListener(MouseEvent.MOUSE_UP, OnMouseUpFromStackArea);
					
					
		
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
			
		
			return getDefinitionByName(getQualifiedClassName(this)) as Class;