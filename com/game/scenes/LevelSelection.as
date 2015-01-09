package com.game.scenes {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	
	public class LevelSelection extends MovieClip {
		
		var main:Main;
		var stageNumber:int = 0;
		
		public function LevelSelection() {
			this.SetupStageSelection();
			
			this.addEventListener(Event.ADDED_TO_STAGE, GetElements);
		}

		private function GetElements(e:Event)
		{
			main = this.stage.getChildAt(0) as Main;
		}

		//*****************//
		// Stage Selection //
		//*****************//
		private function SetupStageSelection()
		{
			stage1_mc.mouseChildren = false;
			stage2_mc.mouseChildren = false;
			stage3_mc.mouseChildren = false;
			back_mc.mouseChildren = false;
			
			stage1_mc.addEventListener(MouseEvent.MOUSE_UP, OnClickLevel(1));
			stage2_mc.addEventListener(MouseEvent.MOUSE_UP, OnClickLevel(2));
			stage3_mc.addEventListener(MouseEvent.MOUSE_UP, OnClickLevel(3));
			back_mc.addEventListener(MouseEvent.MOUSE_UP, OnClickBackButtonMenu);
		}
		
		private function OnClickLevel(setStageNumber:int) {
			return function (e:MouseEvent) {
				trace("go to level " + setStageNumber);
				
				gotoAndStop(2);
				
				stageNumber = setStageNumber;
				
				stage_txt.text = stageNumber.toString();
				
				back_mc.removeEventListener(MouseEvent.MOUSE_UP, OnClickBackButtonMenu);
				back_mc.addEventListener(MouseEvent.MOUSE_UP, OnClickBackButtonStageSelection);
				
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
			main.GoToMenu();
		}
		
		private function OnClickBackButtonStageSelection(e:MouseEvent)
		{
			gotoAndStop(1);
			this.SetupStageSelection();
		}
	}
	
}
