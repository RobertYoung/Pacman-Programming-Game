package com.game.elements {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class LevelCompleteAlertView extends MovieClip {
		
		
		public function LevelCompleteAlertView() {
			this.addEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
		public function Init(e:Event)
		{
			// Center alertview
			this.y = this.stage.stageHeight / 2;
			this.x = this.stage.stageWidth / 2;
			
			exit_mc.mouseChildren = false;
			next_mc.mouseChildren = false;
			this.mouseChildren = false;
		}
	}
	
}
