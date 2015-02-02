package com.game.scenes {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.game.factory.Game;
	import com.greensock.loading.LoaderMax;
	import flash.text.TextField;
	import com.game.elements.CompleteTick;
	import com.game.factory.PacmanSharedObjectHelper;
	import com.game.factory.PacmanWebService;
	import com.game.objects.StagesCompletion;
	
	public class LevelSelection extends MovieClip {
		
		var main:Main;
		var stageNumber:int = 0;
		var backButton:BackButton;
		var userLocalData:PacmanSharedObjectHelper;
		//var pacmanWebService:PacmanWebService;
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
				
				userLocalData = PacmanSharedObjectHelper.getInstance();
				//pacmanWebService = PacmanWebService.getInstance();
				
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
			
			stage1_mc.addEventListener(MouseEvent.MOUSE_OVER, OnMouseOver);
			stage2_mc.addEventListener(MouseEvent.MOUSE_OVER, OnMouseOver);
			stage3_mc.addEventListener(MouseEvent.MOUSE_OVER, OnMouseOver);
			
			stage1_mc.addEventListener(MouseEvent.MOUSE_OUT, OnMouseOut);
			stage2_mc.addEventListener(MouseEvent.MOUSE_OUT, OnMouseOut);
			stage3_mc.addEventListener(MouseEvent.MOUSE_OUT, OnMouseOut);
			
			backButton.AddMouseUpEventListener(OnClickBackButtonMenu);

			//pacmanWebService.GetStageCompletion(SetupTicks);
			
			if (this.userLocalData.GetStageCompletion(1) == true)
			{
				var completeTick1:CompleteTick = new CompleteTick(70, 50);
				
				stage1_mc.addChild(completeTick1);
			}
			
			if (this.userLocalData.GetStageCompletion(2) == true)
			{
				var completeTick2:CompleteTick = new CompleteTick(70, 50);
				
				stage2_mc.addChild(completeTick2);
			}
			
			if (this.userLocalData.GetStageCompletion(3) == true)
			{
				var completeTick3:CompleteTick = new CompleteTick(70, 50);
				
				stage3_mc.addChild(completeTick3);
			}
		}
		
		/*
		private function SetupTicks(stageComplete:StagesCompletion)
		{
			trace(stageComplete);
			
			
			if (stageComplete.Stage1 == true)
			{
				var completeTick1:CompleteTick = new CompleteTick(70, 50);
				
				stage1_mc.addChild(completeTick1);
			}
			
			if (stageComplete.Stage2 == true)
			{
				var completeTick2:CompleteTick = new CompleteTick(70, 50);
				
				stage2_mc.addChild(completeTick2);
			}
			
			if (stageComplete.Stage3 == true)
			{
				var completeTick3:CompleteTick = new CompleteTick(70, 50);
				
				stage3_mc.addChild(completeTick3);
			}
		}*/
		
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
				level.addEventListener(MouseEvent.MOUSE_OVER, OnMouseOver);
				level.addEventListener(MouseEvent.MOUSE_OUT, OnMouseOut);
				
				var completeTick:CompleteTick = new CompleteTick(70, 50);
				
				if (this.userLocalData.GetLevelData(this.stageNumber, i).completed == true)
				{
					level.addChild(completeTick);
				}
			}
		}
		
		private function GoToLevel(levelNumber:int)
		{
			return function (e:MouseEvent)
			{
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
		
		//**************//
		// MOUSE EVENTS //
		//**************//
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
