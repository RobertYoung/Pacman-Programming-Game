package com.game.elements {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.game.scenes.Controls;
	import flash.text.TextField;
	import flash.events.Event;
	
	public class ControlDropDown extends MovieClip {
		
		public static const CONTROL_MOVEMENT:String = "MOVEMENT";
		public static const CONTROL_IF_CLEAR:String = "IF CLEAR";
		public static const CONTROL_LOOP:String = "LOOP";
		public static const CONTROL_ACTIONS:String = "ACTIONS";
		
		private static const CONTROL_MOVEMENT_MC:String = "movementSelect_mc";
		private static const CONTROL_IF_CLEAR_MC:String = "ifSelect_mc";
		private static const CONTROL_LOOP_MC:String = "loopSelect_mc";
		private static const CONTROL_ACTIONS_MC:String = "actionsSelect_mc";
		
		public var controls:Controls;
		public var controlSelect_mc:MovieClip;
		public var movementSelect_mc:MovieClip;
		public var actionsSelect_mc:MovieClip;
		public var controlDropDown_mc:ControlDropDown;
		public var controlDropDown_txt:TextField;
		public var loopSelect_mc:MovieClip;
		public var ifSelect_mc:MovieClip;
		
		public function ControlDropDown() {
			trace(stage);
			
			if(stage) init(null);
            else addEventListener(Event.ADDED_TO_STAGE, init)
		}
		
		//******//
		// INIT //
		//******//
		private function init(e:Event):void {
            removeEventListener(Event.ADDED_TO_STAGE, init);
			
			this.gotoAndStop(1);
			this.addEventListener(MouseEvent.MOUSE_UP, MouseUpDisplayDropDown);

			controls = this.parent as Controls;			
        }
		
		//****************//
		// EVENT HANDLERS //
		//****************//
		private function MouseUpHideDropDown(e:MouseEvent)
		{
			if (e.target.parent == null || e.target.parent.name != "controlDropDown_mc"){
				this.HideDropDown();
			}
		}
		
		private function MouseUpDisplayDropDown(e:MouseEvent)
		{
			// End event phase - The HideDropDown event was being fired as soon as it was 
			// added to the stage
			e.stopPropagation();
			
			this.DisplayDropDown();
		}
		
		//***********************//
		// HIDE & SHOW DROP DOWN //
		//***********************//
		private function DisplayDropDown()
		{
			this.gotoAndStop(2);
			this.SetControlSelectionTextFields();
			
			this.controls.stage.addEventListener(MouseEvent.MOUSE_UP, MouseUpHideDropDown);
			this.removeEventListener(MouseEvent.MOUSE_UP, MouseUpDisplayDropDown);
		}
		
		private function HideDropDown()
		{
			trace("hide");
			this.gotoAndStop(1);
			this.controls.stage.removeEventListener(MouseEvent.MOUSE_UP, MouseUpHideDropDown);
			this.addEventListener(MouseEvent.MOUSE_UP, MouseUpDisplayDropDown);
		}
		
		//***************//
		// SETUP METHODS //
		//***************//
		private function SetControlSelectionTextFields()
		{
			// Set text property for each selection
			this[ControlDropDown.CONTROL_MOVEMENT_MC].controlSelect_txt.text = ControlDropDown.CONTROL_MOVEMENT;
			this[ControlDropDown.CONTROL_IF_CLEAR_MC].controlSelect_txt.text = ControlDropDown.CONTROL_IF_CLEAR;
			this[ControlDropDown.CONTROL_LOOP_MC].controlSelect_txt.text = ControlDropDown.CONTROL_LOOP;
			this[ControlDropDown.CONTROL_ACTIONS_MC].controlSelect_txt.text = ControlDropDown.CONTROL_ACTIONS;
			
			this[ControlDropDown.CONTROL_MOVEMENT_MC].addEventListener(MouseEvent.MOUSE_UP, SwitchControls);
			this[ControlDropDown.CONTROL_IF_CLEAR_MC].addEventListener(MouseEvent.MOUSE_UP, SwitchControls);
			this[ControlDropDown.CONTROL_LOOP_MC].addEventListener(MouseEvent.MOUSE_UP, SwitchControls);
			this[ControlDropDown.CONTROL_ACTIONS_MC].addEventListener(MouseEvent.MOUSE_UP, SwitchControls);
		}
		
		private function SwitchControls(e:MouseEvent)
		{
			switch(e.target.name)
			{
				case ControlDropDown.CONTROL_MOVEMENT_MC:
					this.SetControlDropDownText(ControlDropDown.CONTROL_MOVEMENT);
					controls.SwitchToMovement();
				break;
				case ControlDropDown.CONTROL_IF_CLEAR_MC:
					this.SetControlDropDownText(ControlDropDown.CONTROL_IF_CLEAR);
					controls.SwitchToIfClear();
				break;
				case ControlDropDown.CONTROL_LOOP_MC:
					this.SetControlDropDownText(ControlDropDown.CONTROL_LOOP);
					controls.SwitchToLoop();
				break;
				case ControlDropDown.CONTROL_ACTIONS_MC:
					this.SetControlDropDownText(ControlDropDown.CONTROL_ACTIONS);
					controls.SwitchToActions();
				break;
			}
			
			this.HideDropDown();
		}
		
		private function SetControlDropDownText(text:String)
		{
			this.controlDropDown_txt.text = text.toLowerCase();
		}
	}
}
