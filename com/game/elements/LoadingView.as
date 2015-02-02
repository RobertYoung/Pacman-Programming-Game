package com.game.elements {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class LoadingView extends MovieClip {
		
		
		public function LoadingView() {
			this.addEventListener(Event.ADDED_TO_STAGE, AddedToStage);
		}
		
		private function AddedToStage(e:Event)
		{
			// Center alertview
			this.y = this.stage.stageHeight / 2;
			this.x = this.stage.stageWidth / 2;
		}
	}
	
}
