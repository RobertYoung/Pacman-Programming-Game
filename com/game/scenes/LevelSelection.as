package com.game.scenes {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.game.factory.Game;
	import com.greensock.loading.LoaderMax;
	import flash.text.TextField;
	import com.game.elements.CompleteTick;
	import com.game.factory.UserData;
	
	public class LevelSelection extends MovieClip {
		
		var main:Main;
		var stageNumber:int = 0;
		var backButton:BackButton;
		var userLocalData:UserData;
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
			trace("init");
			this.gotoAndStop(1);
			
			main = this.stage.getChildAt(0) as Main;
			
			if (main) {
				backButton = LoaderMax.getContent(Game.SWF_BACK_BUTTON).rawContent as BackButton;
				
				userLocalData = UserData.getInstance();
				
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

			var userStage:int = userLocalData.GetStage();
			
			if (userStage > 1){
				var completeTick1:CompleteTick = new CompleteTick(70, 50);
				
				stage1_mc.addChild(completeTick1);
			}if (userStage > 2){
				var completeTick2:CompleteTick = new CompleteTick(70, 50);
				
				stage2_mc.addChild(completeTick2);
			}if (userStage > 3){
				var completeTick3:CompleteTick = new CompleteTick(70, 50);
				
				stage3_mc.addChild(completeTick3);
			}
		}
		
		private function OnClickLevel(setStageNumber:int) {
			return function (e:MouseEvent) {
				GoToLevelSelection(setStageNumber);
			}
		}
		
		public function GoToLevelSelection(setStageNumber:int) 
		{
			gotoAndStop(2);
			
			stageNumber = setStageNumber;
			
			stage_txt.text = stageNumber.toString();
			
			backButton.RemoveMouseUpEventListener(OnClickBackButtonMenu);
			backButton.AddMouseUpEventListener(OnClickBackButtonStageSelection);
			
			SetupLevelSelection();
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
				
				var completeTick:CompleteTick = new CompleteTick(70, 50);
				
				if (this.stageNumber < this.userLocalData.GetStage())
				{
					level.addChild(completeTick);
				}else if (this.stageNumber == this.userLocalData.GetStage() && i < this.userLocalData..GetLevel()) 
				{
					level.addChild(completeTick);
				}
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
