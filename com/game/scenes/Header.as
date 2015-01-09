package com.game.scenes {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.game.factory.Game;
	import flash.events.Event;
	
	public class Header extends MovieClip {
		
		private var game:Game;
		var main:Main;
		
		public function Header() {
			this.addEventListener(Event.ADDED_TO_STAGE, AddedToStageEvent);
			
			play_mc.addEventListener(MouseEvent.MOUSE_DOWN, PlayMouseDown);		
			reset_mc.addEventListener(MouseEvent.MOUSE_UP, ResetMouseUp);
		}
		
		//*****************//
		// EVENT LISTENERS //
		//*****************//
		function PlayMouseDown(e:MouseEvent)
		{
			play_mc.addEventListener(MouseEvent.MOUSE_UP, PlayMouseUp);	
		}
		
		function PlayMouseUp(e:MouseEvent)
		{
			game.Play();
			play_mc.removeEventListener(MouseEvent.MOUSE_UP, PlayMouseUp);	
		}

		function ResetMouseUp(e:MouseEvent)
		{
			game.ReloadLevel();
		}
		
		function AddedToStageEvent(e:Event)
		{
			main = this.stage.getChildAt(0) as Main;
			
			if (main != null)
				game = main.getChildByName(Game.SWF_GAME) as Game;
		}
	}
	
}
