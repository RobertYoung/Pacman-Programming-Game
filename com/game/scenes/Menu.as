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
			play_btn.addEventListener(MouseEvent.MOUSE_OVER, OnMouseOver);
			play_btn.addEventListener(MouseEvent.MOUSE_OUT, OnMouseOut);
			
			achievements_btn.mouseChildren = false;
			achievements_btn.addEventListener(MouseEvent.MOUSE_UP, GoToAchievements);
			achievements_btn.addEventListener(MouseEvent.MOUSE_OVER, OnMouseOver);
			achievements_btn.addEventListener(MouseEvent.MOUSE_OUT, OnMouseOut);
			
			help_btn.mouseChildren = false;
			help_btn.addEventListener(MouseEvent.MOUSE_UP, GoToHelp);
			help_btn.addEventListener(MouseEvent.MOUSE_OVER, OnMouseOver);
			help_btn.addEventListener(MouseEvent.MOUSE_OUT, OnMouseOut);
			
			this.addEventListener(Event.ADDED_TO_STAGE, GetElements);
		}
		
		private function GetElements(e:Event)
		{
			this.main = this.stage.getChildAt(0) as Main;
		}
		
		private function GoToLevels(e:MouseEvent)
		{
			this.main.GoToLevelSelection();
		}
		
		private function GoToAchievements(e:MouseEvent)
		{
			this.main.GoToAchievements();
		}
		
		private function GoToHelp(e:MouseEvent)
		{
			trace("Help Pressed");
		}
		
		function OnMouseOver(e:MouseEvent)
		{
			e.target.alpha = 0.8;
		}
		
		function OnMouseOut(e:MouseEvent)
		{
			e.target.alpha = 1;
		}
	}
	
}
