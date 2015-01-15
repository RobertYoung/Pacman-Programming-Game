package com.game.scenes {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.game.factory.Game;
	import flash.events.Event;
	import flash.text.TextField;
	import com.greensock.loading.LoaderMax;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
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
		
		private var controlTimer:Timer;
		
		public function Header() {
			play_mc.addEventListener(MouseEvent.MOUSE_DOWN, PlayMouseDown);		
			reset_mc.addEventListener(MouseEvent.MOUSE_UP, ResetMouseUp);
			
			/*
			controlsRadioButtonTextual_mc.addEventListener(MouseEvent.MOUSE_UP, SwitchToTextualControls);
			controlsRadioButtonGraphical_mc.addEventListener(MouseEvent.MOUSE_UP, SwitchToGraphicalControls);
			controlsRadioButtonTextualGraphical_mc.addEventListener(MouseEvent.MOUSE_UP, SwitchToTextualGraphicalControls);
			*/
			
			controlsRadioButtonTextual_mc.addEventListener(MouseEvent.MOUSE_DOWN, MouseDownControlTextual);
			controlsRadioButtonTextual_mc.addEventListener(MouseEvent.MOUSE_UP, StopControlTimer);
			controlsRadioButtonGraphical_mc.addEventListener(MouseEvent.MOUSE_DOWN, MouseDownControlGraphical);
			controlsRadioButtonGraphical_mc.addEventListener(MouseEvent.MOUSE_UP, StopControlTimer);
			controlsRadioButtonTextualGraphical_mc.addEventListener(MouseEvent.MOUSE_DOWN, MouseDownControlTextualGraphical);
			controlsRadioButtonTextualGraphical_mc.addEventListener(MouseEvent.MOUSE_UP, StopControlTimer);
		}
		
		//*****************//
		// EVENT LISTENERS //
		//*****************//
		function MouseDownControlTextual(e:MouseEvent)
		{
			controlTimer = new Timer(1000, 1);
			
			controlTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.SwitchToTextualControls);
			controlTimer.start();
		}
		
		function StopControlTimer(e:MouseEvent)
		{
			controlTimer.stop();
		}
		
		function MouseDownControlGraphical(e:MouseEvent)
		{
			controlTimer = new Timer(1000, 1);
			
			controlTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.SwitchToGraphicalControls);
			controlTimer.start();
		}
		
		function MouseDownControlTextualGraphical(e:MouseEvent)
		{
			controlTimer = new Timer(1000, 1);
			
			controlTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.SwitchToTextualGraphicalControls);
			controlTimer.start();
		}
		
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
		
		function SwitchToTextualControls(e:TimerEvent)
		{
			controls.SwitchToTextual();
		}
		
		function SwitchToGraphicalControls(e:TimerEvent)
		{
			controls.SwitchToGraphical();
		}
		
		function SwitchToTextualGraphicalControls(e:TimerEvent)
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
