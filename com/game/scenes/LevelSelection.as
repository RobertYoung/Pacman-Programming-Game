package com.game.scenes {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.game.factory.Game;
	import com.greensock.loading.LoaderMax;
	import flash.text.TextField;
	
	public class LevelSelection extends MovieClip {
		
		var main:Main;
		var stageNumber:int = 0;
		var backButton:BackButton;
		public var stage1_mc:MovieClip;
		public var stage2_mc:MovieClip;
		public var stage3_mc:MovieClip;
		public var stage_txt:TextField;
		public var level1_mc:MovieClip;
		public var level2_mc:MovieClip;
		public var level3_mc:MovieClip;
		public var level4_mc:MovieClip;
		public var level5_mc:MovieClip;
		public var level6_mc:MovieClip;
		
		public function LevelSelection() {
			
		}

		public function Init()
		{
			this.gotoAndStop(1);
			
			main = this.stage.getChildAt(0) as Main;
			
			if (main) {
				backButton = LoaderMax.getContent(Game.SWF_BACK_BUTTON).rawContent as BackButton;
				
				SetupStageSelection();
			}
		}

		//*****************//
		// Stage Selection //
		//*****************//
		private function SetupStageSelection()
		{
			stage1_mc.mouseChildren = false;
			stage2_mc.mouseChildren = false;
			stage3_mc.mouseChildren = false;
			
			stage1_mc.addEventListener(MouseEvent.MOUSE_UP, OnClickLevel(1));
			stage2_mc.addEventListener(MouseEvent.MOUSE_UP, OnClickLevel(2));
			stage3_mc.addEventListener(MouseEvent.MOUSE_UP, OnClickLevel(3));
			
			backButton.AddMouseUpEventListener(OnClickBackButtonMenu);
		}
		
		private function OnClickLevel(setStageNumber:int) {
			return function (e:MouseEvent) {
				trace("go to level " + setStageNumber);
				
				gotoAndStop(2);
				
				stageNumber = setStageNumber;
				
				stage_txt.text = stageNumber.toString();
				
				backButton.RemoveMouseUpEventListener(OnClickBackButtonMenu);
				backButton.AddMouseUpEventListener(OnClickBackButtonStageSelection);
				
				SetupLevelSelection();
			}
		}
		
		//*****************//
		// Level Selection //
		//*****************//
		private function SetupLevelSelection()
		{
			for (var i = 1; i <= 6; i++)
			{
				var level:MovieClip = this["level" + i + "_mc"];
				
				level.mouseChildren = false;
				level.addEventListener(MouseEvent.MOUSE_UP, GoToLevel(i));
				
			}
		}
		
		private function GoToLevel(levelNumber:int)
		{
			return function (e:MouseEvent)
			{
				trace("Go to Stage (" + stageNumber + "), Level (" + levelNumber + ")");	
				main.GoToLevel(stageNumber, levelNumber);
			}
		}
		
		//********************//
		// Back Button Events //
		//********************//
		private function OnClickBackButtonMenu(e:MouseEvent)
		{
			trace("main: " + main);
			main.GoToMenu();
		}
		
		private function OnClickBackButtonStageSelection(e:MouseEvent)
		{
			gotoAndStop(1);
			this.SetupStageSelection();
		}
	}
	
}
