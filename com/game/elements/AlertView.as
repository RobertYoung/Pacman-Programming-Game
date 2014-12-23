package com.game.elements {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	
	
	public class AlertView extends MovieClip {

		public var title_txt:TextField;
		public var description_txt:TextField;
		public var hint_txt:TextField;
		public var ok_mc:MovieClip;
		
		public function AlertView(title:String, description:String, hint:String = "") {
			this.addEventListener(Event.ADDED_TO_STAGE, AddedToStageListener);
			
			this.SetTitle(title);
			this.SetDescription(description);
			this.SetHint(hint);
			
			ok_mc.addEventListener(MouseEvent.MOUSE_UP, CloseAlertView);
		}
		
		private function AddedToStageListener(e:Event)
		{
			// Center alertview
			this.y = this.stage.stageHeight / 2;
			this.x = this.stage.stageWidth / 2;
		}
		
		//*************//
		// SET METHODS //
		//*************//
		public function SetTitle(title:String)
		{
			title_txt.text = title.toLowerCase();
		}
		
		public function SetDescription(description:String)
		{
			description_txt.text = description;
		}
		
		public function SetHint(hint:String)
		{
			hint_txt.text = "Hint: " + hint;
		}
		
		//*****************//
		// EVENT LISTENERS //
		//*****************//
		public function CloseAlertView(e:MouseEvent)
		{
			this.parent.removeChild(this);
		}
	}
	
}
