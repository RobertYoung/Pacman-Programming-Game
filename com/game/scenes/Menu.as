package com.game.scenes {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class Menu extends MovieClip {
		
		
		public function Menu() {
			play_btn.mouseChildren = false;
			play_btn.addEventListener(MouseEvent.MOUSE_UP, GoToLevels);
			
			achievements_btn.mouseChildren = false;
			achievements_btn.addEventListener(MouseEvent.MOUSE_UP, GoToAchievements);
			
			help_btn.mouseChildren = false;
			help_btn.addEventListener(MouseEvent.MOUSE_UP, GoToHelp);
		}
		
		private function GoToLevels(e:MouseEvent)
		{
			trace("Play pressed");
		}
		
		private function GoToAchievements(e:MouseEvent)
		{
			trace("Achievements pressed");
		}
		
		private function GoToHelp(e:MouseEvent)
		{
			trace("Help Pressed");
		}
	}
	
}
