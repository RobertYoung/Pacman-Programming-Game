package com.game.elements {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.game.scenes.Controls;
	import flash.text.TextField;
	import flash.events.Event;
	
	public class ControlDropDown extends MovieClip {
		
		public static const CONTROL_MOVEMENT:String = "MOVEMENT";
		public static const CONTROL_CONTROLS:String = "CONTROLS";
		public static const CONTROL_ACTIONS:String = "ACTIONS";
		
		private static const CONTROL_MOVEMENT_MC:String = "movementSelect_mc";
		private static const CONTROL_CONTROLS_MC:String = "controlSelect_mc";
		private static const CONTROL_ACTIONS_MC:String = "actionsSelect_mc";
		
		public var controls:Controls;
		public var controlSelect_mc:MovieClip;
		public var movementSelect_mc:MovieClip;
		public var actionsSelect_mc:MovieClip;
		public var controlDropDown_mc:ControlDropDown;
		public var controlDropDown_txt:TextField;
		
		public function ControlDropDown() {
			trace("constuctor");
			trace(stage);
			if(stage) init(null);
            else addEventListener(Event.ADDED_TO_STAGE, init)
		}
		
		//******//
		// INIT //
		//******//
		private function init(e:Event):void {
			trace("init");
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
			this.movementSelect_mc.controlSelect_txt.text = ControlDropDown.CONTROL_MOVEMENT;
			this.controlSelect_mc.controlSelect_txt.text = ControlDropDown.CONTROL_CONTROLS;
			this.actionsSelect_mc.controlSelect_txt.text = ControlDropDown.CONTROL_ACTIONS;
			
			this.movementSelect_mc.addEventListener(MouseEvent.MOUSE_UP, SwitchControls);
			this.controlSelect_mc.addEventListener(MouseEvent.MOUSE_UP, SwitchControls);
			this.actionsSelect_mc.addEventListener(MouseEvent.MOUSE_UP, SwitchControls);
		}
		
		private function SwitchControls(e:MouseEvent)
		{
			switch(e.target.name)
			{
				case ControlDropDown.CONTROL_MOVEMENT_MC:
					this.SetControlDropDownText(ControlDropDown.CONTROL_MOVEMENT);
					controls.SwitchToMovement();
				break;
				case ControlDropDown.CONTROL_CONTROLS_MC:
					this.SetControlDropDownText(ControlDropDown.CONTROL_CONTROLS);
					controls.SwitchToControls();
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
