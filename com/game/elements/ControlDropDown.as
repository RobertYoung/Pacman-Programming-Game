package com.game.elements {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.game.scenes.Controls;
	
	public class ControlDropDown extends MovieClip {
		
		public static const CONTROL_MOVEMENT:String = "MOVEMENT";
		public static const CONTROL_CONTROLS:String = "CONTROLS";
		public static const CONTROL_ACTIONS:String = "ACTIONS";
		
		private static const CONTROL_MOVEMENT_MC:String = "movementSelect_mc";
		private static const CONTROL_CONTROLS_MC:String = "controlSelect_mc";
		private static const CONTROL_ACTIONS_MC:String = "actionsSelect_mc";
		
		private var controls:Controls;
		
		public var movementSelect_mc:MovieClip;
		
		public function ControlDropDown() {
			this.gotoAndStop(1);
			
			this.addEventListener(MouseEvent.MOUSE_UP, DisplayDropDown);
			
			controls = this.parent as Controls;
		}
		
		private function DisplayDropDown(e:MouseEvent)
		{
			this.gotoAndStop(2);
			this.removeEventListener(MouseEvent.MOUSE_UP, DisplayDropDown);
			this.SetControlSelectionTextFields();
		}
		
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
			switch(e.target.parent.name)
			{
				case ControlDropDown.CONTROL_MOVEMENT_MC:
					controls.SwitchToMovement();
				break;
				case ControlDropDown.CONTROL_CONTROLS_MC:
					controls.SwitchToControls();
				break;
				case ControlDropDown.CONTROL_ACTIONS_MC:
					controls.SwitchToActions();
				break;
				default:
					return;
			}
		}
	}
}
