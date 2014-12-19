package com.game.factory {
	import com.game.scenes.Main;
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import com.game.controls.Movement
	import com.greensock.TimelineMax;
	import com.greensock.TweenLite;
	import com.game.elements.Grid;
	
	public class Game {

		public static const SWF_MAIN:String = "main";
		public static const SWF_HEADER:String = "header";
		public static const SWF_PACMAN_STAGE:String = "pacman_stage";
		public static const SWF_PACMAN_CODING_AREA:String = "pacman_code";
		public static const SWF_CONTROLS:String = "controls";
		
		private var main:Main;
		private var pacmanSequence:Array = new Array();
		private var pacmanTimeline:TimelineMax = new TimelineMax();
		//private var pacmanMC:DisplayObject;
		
		public function Game(mc:Main) {
			main = mc;
		}

		public function Play() {
			AddControlsToArray();
			
			var pacmanMC = main.getChildByName(Game.SWF_PACMAN_STAGE)["rawContent"].getChildByName(Game.SWF_PACMAN_STAGE)
								.getChildByName(Grid.PACMAN);
			
			trace(pacmanMC);
			
			for (var stack in pacmanSequence)
			{
				switch(pacmanSequence[stack])
				{
					case Movement.MOVEMENT_FORWARD:
						//pacmanTimeline.append(new TweenLite(
						
					break;
				}
			}
		}
		
		private function AddControlsToArray()
		{
			// Get list of all the sequences on the stack
			var stackContainer:DisplayObject = main.getChildByName(Game.SWF_PACMAN_CODING_AREA)["rawContent"]["pacmanCodingArea_mc"]["scrollArea_mc"]["scrollArea_mc"];
			var stackLength = 1;
			
			while (stackContainer["stack" + stackLength] != null)
			{
				pacmanSequence.push(stackContainer["stack" + stackLength].controlInStack);
				stackLength++;
				trace(pacmanSequence);
			}
		}
	}
	
}
