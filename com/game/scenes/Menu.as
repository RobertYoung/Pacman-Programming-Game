package com.game.scenes {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.game.factory.Game;
	
	public class Menu extends MovieClip {
		
		var main:Main;
		
		public function Menu() {
			play_btn.mouseChildren = false;
			play_btn.addEventListener(MouseEvent.MOUSE_UP, GoToLevels);
			
			achievements_btn.mouseChildren = false;
			achievements_btn.addEventListener(MouseEvent.MOUSE_UP, GoToAchievements);
			
			help_btn.mouseChildren = false;
			help_btn.addEventListener(MouseEvent.MOUSE_UP, GoToHelp);
			
			this.addEventListener(Event.ADDED_TO_STAGE, GetElements);
		}
		
		private function GetElements(e:Event)
		{
			this.main = this.stage.getChildAt(0) as Main;
			trace("main: " + main);
		}
		
		private function GoToLevels(e:MouseEvent)
		{
			trace("Play pressed");
			this.main.GoToLevelSelection();
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
