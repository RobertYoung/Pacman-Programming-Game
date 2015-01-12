package com.game.elements {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.game.scenes.Main;
	
	
	public class LevelCompleteAlertView extends MovieClip {
		
		//private var nextFunction:Function;
		private var currentStage:int;
		private var currentLevel:int;
		private var main:Main;
		
		public var next_mc:MovieClip;
		
		public function LevelCompleteAlertView(setCurrentStage:int, setCurrentLevel:int) {
			this.currentStage = setCurrentStage;
			this.currentLevel = setCurrentLevel;
			
			this.addEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
		public function Init(e:Event)
		{
			// Center alertview
			this.y = this.stage.stageHeight / 2;
			this.x = this.stage.stageWidth / 2;
			
			next_mc.mouseChildren = false;
			next_mc.addEventListener(MouseEvent.MOUSE_UP, NextLevel);
			
			this.main = this.stage.getChildAt(0) as Main;
		}
		
		private function NextLevel(e:MouseEvent)
		{
			this.main.GoToLevel(currentStage, currentLevel);
		}
	}
}
