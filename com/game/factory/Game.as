package com.game.factory {
	import com.game.scenes.Main;
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	
	public class Game {

		public static const SWF_MAIN:String = "main";
		public static const SWF_HEADER:String = "header";
		public static const SWF_PACMAN_STAGE:String = "pacman_stage";
		public static const SWF_PACMAN_CODING_AREA:String = "pacman_code";
		public static const SWF_CONTROLS:String = "controls";
		
		private var main:Main;
		private var pacmanSequence:Array = new Array();;
		
		public function Game(mc:Main) {
			main = mc;
		}

		public function Play() {
			AddControlsToArray();
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
