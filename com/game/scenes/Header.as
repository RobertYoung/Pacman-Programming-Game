package com.game.scenes {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.game.factory.Game;
	import flash.events.Event;
	import flash.text.TextField;
	
	public class Header extends MovieClip {
		
		private var game:Game;
		var main:Main;
		
		public var play_mc:MovieClip;
		public var reset_mc:MovieClip;
		public var stage_txt:TextField;
		public var level_txt:TextField;
		public var highScore_txt:TextField;
		public var score_txt:TextField;
		
		public function Header() {
			this.addEventListener(Event.ADDED_TO_STAGE, AddedToStageEvent);
			
			play_mc.addEventListener(MouseEvent.MOUSE_DOWN, PlayMouseDown);		
			reset_mc.addEventListener(MouseEvent.MOUSE_UP, ResetMouseUp);
		}
		
		//*****************//
		// EVENT LISTENERS //
		//*****************//
		function PlayMouseDown(e:MouseEvent)
		{
			play_mc.addEventListener(MouseEvent.MOUSE_UP, PlayMouseUp);	
		}
		
		function PlayMouseUp(e:MouseEvent)
		{
			game.Play();
			play_mc.removeEventListener(MouseEvent.MOUSE_UP, PlayMouseUp);	
		}

		function ResetMouseUp(e:MouseEvent)
		{
			game.ReloadLevel();
		}
		
		function AddedToStageEvent(e:Event)
		{
			main = this.stage.getChildAt(0) as Main;
			
			if (main != null) {
				game = main.getChildByName(Game.SWF_GAME) as Game;
				this.SetLevelDetails();
			}
		}
		
		//***************************//
		// Set Level / Score Details //
		//***************************//
		public function SetLevelDetails()
		{
			stage_txt.text = game.GetLevelDetails().stageNumber.toString();
			level_txt.text = game.GetLevelDetails().levelNumber.toString();
		}
		
		public function SetScoreText(score:int)
		{
			score_txt.text = score.toString();
		}
		
		public function SetHighScoreText(highScore:int)
		{
			highScore_txt.text = highScore.toString();
		}
	}
	
}
