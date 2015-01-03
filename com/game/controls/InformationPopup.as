package com.game.controls {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class InformationPopup extends MovieClip {
		
		//****************//
		// FLASH ELEMENTS //
		//****************//
		public var controlName_txt:TextField;
		public var controlDescription_txt:TextField;
		public var animationPlaceholder_mc:MovieClip;
		public var ok_mc:MovieClip;
		
		public function InformationPopup(controlName:String, controlDescription:String) {
			this.addEventListener(Event.ADDED_TO_STAGE, this.AddedToStageListener);
			
			this.controlName_txt.text = controlName.toUpperCase();
			this.controlDescription_txt.text = controlDescription;
			
			this.ok_mc.addEventListener(MouseEvent.MOUSE_UP, CloseInformationPopup);
		}
		
		private function AddedToStageListener(e:Event)
		{
			// Center alertview
			this.y = this.stage.stageHeight / 2;
			this.x = this.stage.stageWidth / 2;
		}
		
		private function CloseInformationPopup(e:MouseEvent)
		{
			this.parent.removeChild(this);
		}
	}
	
}
