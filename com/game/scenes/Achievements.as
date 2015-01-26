package com.game.scenes {
	
	import flash.display.MovieClip;
	import com.greensock.loading.LoaderMax;
	import com.game.factory.Game;
	import com.greensock.TweenMax;
	import flash.events.MouseEvent;
	import com.game.factory.PacmanSharedObjectHelper;
	import com.game.factory.LevelData;
	
	public class Achievements extends MovieClip {
	
		private var backButton:BackButton;
		private var main:Main;
		private var pacmanSharedObjectHelper:PacmanSharedObjectHelper;
		
		// Elements
		public var achievement_6min_mc:MovieClip;
		public var achievement_5min_mc:MovieClip;
		public var achievement_4min_mc:MovieClip;
		public var achievement_3min_mc:MovieClip;
		public var achievement_2min_mc:MovieClip;
		public var achievement_1min_mc:MovieClip;
		public var cherry1_mc:MovieClip;
		public var cherry2_mc:MovieClip;
		public var cherry3_mc:MovieClip;
		public var cherry4_mc:MovieClip;
		public var cherry5_mc:MovieClip;
		public var cherry6_mc:MovieClip;
		public var apple1_mc:MovieClip;
		public var apple2_mc:MovieClip;
		public var apple3_mc:MovieClip;
		public var apple4_mc:MovieClip;
		public var apple5_mc:MovieClip;
		public var apple6_mc:MovieClip;
		public var strawberry1_mc:MovieClip;
		public var strawberry2_mc:MovieClip;
		public var strawberry3_mc:MovieClip;
		public var strawberry4_mc:MovieClip;
		public var strawberry5_mc:MovieClip;
		public var strawberry6_mc:MovieClip;
		
		public function Achievements() {
			
		}
		
		public function Init()
		{
			main = this.stage.getChildAt(0) as Main;
			backButton = LoaderMax.getContent(Game.SWF_BACK_BUTTON).rawContent as BackButton;
			backButton.AddMouseUpEventListener(BackButtonMouseUp);
			pacmanSharedObjectHelper = PacmanSharedObjectHelper.getInstance();
			
			// Setup time achievements
			for (var i = 1; i <= 6; i++)
			{
				var timeAchievement:MovieClip = this["achievement_" + i + "min_mc"] as MovieClip;
				
				timeAchievement.mouseChildren = false;
				timeAchievement.time_txt.text = i;
				
				TweenMax.to(timeAchievement, 0, { colorMatrixFilter: { saturation: 0 }});
				
				if (this.pacmanSharedObjectHelper.GetTimeAchievement(i) == true)
					TweenMax.to(timeAchievement, 2, { colorMatrixFilter: { saturation: 1 }});
			}
			
			// Setup cherrys
			for (var cherryNum = 1; cherryNum <= 6; cherryNum++)
			{
				var cherry:MovieClip = this["cherry" + cherryNum + "_mc"] as MovieClip;
				
				cherry.mouseChildren = false;
				cherry.level_txt.text = cherryNum;
				
				var stage1LevelData:LevelData = this.pacmanSharedObjectHelper.GetLevelData(1, cherryNum);
				
				TweenMax.to(cherry, 0, { colorMatrixFilter: { saturation: 0 }});
				
				if (stage1LevelData.completed)
					TweenMax.to(cherry, 2, { colorMatrixFilter: { saturation: 1 }});
			}
			
			// Setup apples
			for (var appleNum = 1; appleNum <= 6; appleNum++)
			{
				var apple:MovieClip = this["apple" + appleNum + "_mc"] as MovieClip;
				
				apple.mouseChildren = false;
				apple.level_txt.text = appleNum;
				
				var stage2LevelData:LevelData = this.pacmanSharedObjectHelper.GetLevelData(2, appleNum);
				
				TweenMax.to(apple, 0, { colorMatrixFilter: { saturation: 0 }});
				
				if (stage2LevelData.completed)
					TweenMax.to(apple, 2, { colorMatrixFilter: { saturation: 1 }});
			}
			
			// Setup strawberries
			for (var strawberryNum = 1; strawberryNum <= 6; strawberryNum++)
			{
				var strawberry:MovieClip = this["strawberry" + strawberryNum + "_mc"] as MovieClip;
				
				strawberry.mouseChildren = false;
				strawberry.level_txt.text = strawberryNum;
				
				var stage3LevelData:LevelData = this.pacmanSharedObjectHelper.GetLevelData(3, strawberryNum);
				
				TweenMax.to(strawberry, 0, { colorMatrixFilter: { saturation: 0 }});
				
				if (stage3LevelData.completed)
					TweenMax.to(strawberry, 2, { colorMatrixFilter: { saturation: 1 }});
			}
		}
		
		private function BackButtonMouseUp(e:MouseEvent)
		{
			main.GoToMenu();
		}
	}
	
}
