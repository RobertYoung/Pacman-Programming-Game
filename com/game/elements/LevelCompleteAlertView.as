﻿package com.game.elements {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.game.scenes.Main;
	import flash.text.TextField;
	
	
	public class LevelCompleteAlertView extends MovieClip {
		
		//private var nextFunction:Function;
		private var currentStage:int;
		private var currentLevel:int;
		private var score:int;
		private var highScore:int;
		private var main:Main;
		
		// Stage elements
		public var score_txt:TextField;
		public var highScore_txt:TextField;
		
		public var next_mc:MovieClip;
		
		public function LevelCompleteAlertView(setCurrentStage:int, setCurrentLevel:int, setScore:int, setHighScore:int) {
			this.currentStage = setCurrentStage;
			this.currentLevel = setCurrentLevel;
			this.score = setScore;
			this.highScore = setHighScore;
			
			this.addEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
		public function Init(e:Event)
		{
			// Center alertview
			this.y = this.stage.stageHeight / 2;
			this.x = this.stage.stageWidth / 2;
			
			next_mc.mouseChildren = false;
			next_mc.addEventListener(MouseEvent.MOUSE_UP, NextLevel);
			
			score_txt.text = this.score.toString();
			highScore_txt.text = this.highScore.toString();
			
			this.main = this.stage.getChildAt(0) as Main;
		}
		
		private function NextLevel(e:MouseEvent)
		{
			if (this.currentLevel == 1)
			{
				this.main.GoToLevelSelection(e, (this.currentStage - 1));
			}else{
				this.main.GoToLevel(currentStage, currentLevel);
			}
		}
	}
}
