package com.game.scenes {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.game.factory.Game;
	import flash.events.Event;
	
	public class Header extends MovieClip {
		
		private var game:Game;
		
		public function Header() {
			this.addEventListener(Event.ADDED_TO_STAGE, AddedToStageEvent);
			
			play_mc.addEventListener(MouseEvent.MOUSE_UP, PlayMouseUp);			
		}
		
		function PlayMouseUp(e:MouseEvent)
		{
			game.Play();
		}
		
		function AddedToStageEvent(e:Event)
		{
			if (this.parent.root.hasOwnProperty("game"))
				game = this.parent.root["game"];
		}
	}
	
}
