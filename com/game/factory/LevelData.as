package com.game.factory {
	import flash.utils.Timer;
	
	public class LevelData {
	
		// Level details
		public var stageNumber:int;
		public var levelNumber:int;
		public var pacmanSequence:Array;
		public var timeCompleted:int;
		public var completed:Boolean = false;
		public var control:int;
		
		// Scores
		public var levelScore:int = 0;
		public var highScore:int = 0;
		public var bonusScore:int = 0;
		public var pacDotScore:int = 0;
		public var cherryScore:int = 0;
		public var appleScore:int = 0;
		public var strawberryScore:int = 0;
		public var ifScore:int = 0;
		public var ifElseScore:int = 0;
		public var loopScore:int = 0;
		
		public function LevelData(forStageNumber:int, forLevelNumber:int) {
			this.stageNumber = forStageNumber;
			this.levelNumber = forLevelNumber;
		}
	}
}

