package com.game.scenes {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.game.factory.Game;
	import flash.events.Event;
	import flash.text.TextField;
	import com.greensock.loading.LoaderMax;
	
	public class Header extends MovieClip {
		
		private var game:Game;
		var main:Main;
		var controls:Controls;
		
		public var play_mc:MovieClip;
		public var reset_mc:MovieClip;
		public var stage_txt:TextField;
		public var level_txt:TextField;
		public var highScore_txt:TextField;
		public var score_txt:TextField;
		public var totalScore_txt:TextField;
		public var controlsRadioButtonTextual_mc:MovieClip;
		public var controlsRadioButtonGraphical_mc:MovieClip;
		public var controlsRadioButtonTextualGraphical_mc:MovieClip;
		
		public function Header() {
			play_mc.addEventListener(MouseEvent.MOUSE_DOWN, PlayMouseDown);		
			reset_mc.addEventListener(MouseEvent.MOUSE_UP, ResetMouseUp);
			controlsRadioButtonTextual_mc.addEventListener(MouseEvent.MOUSE_UP, SwitchToTextualControls);
			controlsRadioButtonGraphical_mc.addEventListener(MouseEvent.MOUSE_UP, SwitchToGraphicalControls);
			controlsRadioButtonTextualGraphical_mc.addEventListener(MouseEvent.MOUSE_UP, SwitchToTextualGraphicalControls);
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
		
		public function Init()
		{
			main = this.stage.getChildAt(0) as Main;
			
			if (main != null) {
				game = main.getChildByName(Game.SWF_GAME) as Game;
				controls = LoaderMax.getContent(Game.SWF_CONTROLS).rawContent as Controls;
				this.SetLevelDetails();
				trace(controls);
			}
		}
		
		function SwitchToTextualControls(e:MouseEvent)
		{
			controls.SwitchToTextual();
		}
		
		function SwitchToGraphicalControls(e:MouseEvent)
		{
			controls.SwitchToGraphical();
		}
		
		function SwitchToTextualGraphicalControls(e:MouseEvent)
		{
			controls.SwitchToTextualGraphical();
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
		
		public function SetTotalHighScoreText(totalHighScore:int)
		{
			totalScore_txt.text = totalHighScore.toString();
		}
	}
	
}
