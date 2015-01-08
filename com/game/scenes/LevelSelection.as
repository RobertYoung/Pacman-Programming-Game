package com.game.scenes {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class LevelSelection extends MovieClip {
		
		
		public function LevelSelection() {
			level1_btn.mouseChildren = false;
			level2_btn.mouseChildren = false;
			level3_btn.mouseChildren = false;
			
			level1_btn.addEventListener(MouseEvent.MOUSE_UP, OnClickLevel(1));
			level2_btn.addEventListener(MouseEvent.MOUSE_UP, OnClickLevel(2));
			level3_btn.addEventListener(MouseEvent.MOUSE_UP, OnClickLevel(3));
		}
		
		private function OnClickLevel(level:int) {
			return function (e:MouseEvent) {
				trace("go to level " + level);
			}
		}
	}
	
}
