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
			reset_mc.addEventListener(MouseEvent.MOUSE_UP, ResetMouseUp);
		}
		
		//*****************//
		// EVENT LISTENERS //
		//*****************//
		function PlayMouseUp(e:MouseEvent)
		{
			game.Play();
		}

		function ResetMouseUp(e:MouseEvent)
		{
			game.Reset();
		}
		
		function AddedToStageEvent(e:Event)
		{
			if (this.parent.root.hasOwnProperty("game"))
				game = this.parent.root["game"];
		}
	}
	
}
