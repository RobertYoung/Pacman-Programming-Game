package com.game.scenes {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.game.factory.Game;
	import flash.events.Event;
	import flash.text.TextField;
	import com.greensock.loading.LoaderMax;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	import com.game.factory.PacmanSharedObjectHelper;
	
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
		public var serverIcon_mc:MovieClip;
		
		private var controlTimer:Timer;
		private var serverIconTimeline:TimelineMax;
		
		public function Header() {
			play_mc.addEventListener(MouseEvent.MOUSE_DOWN, PlayMouseDown);		
			reset_mc.addEventListener(MouseEvent.MOUSE_UP, ResetMouseUp);
			play_mc.gotoAndStop(1);
			
			this.serverIconTimeline = new TimelineMax();
			
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
			play_mc.gotoAndStop(2);
			play_mc.addEventListener(MouseEvent.MOUSE_DOWN, StopMouseDown);
		}
		
		function StopMouseDown(e:MouseEvent)
		{
			play_mc.addEventListener(MouseEvent.MOUSE_UP, StopMouseUp);
		}
		
		function StopMouseUp(e:MouseEvent)
		{
			game.Stop();
			play_mc.removeEventListener(MouseEvent.MOUSE_DOWN, StopMouseDown);
			play_mc.removeEventListener(MouseEvent.MOUSE_UP, StopMouseUp);
			play_mc.addEventListener(MouseEvent.MOUSE_DOWN, PlayMouseDown);	
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
				
				if (PacmanSharedObjectHelper.getInstance().GetWebServiceConnect())
				{
					this.SetWebServiceConnected();
				}else{
					this.SetWebServiceDisconnected();
				}
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
		
		//*************//
		// SERVER ICON //
		//*************//
		public function SetWebServiceConnected()
		{
			this.CreateWebServiceAnimation(true);
		}
		
		public function SetWebServiceDisconnected()
		{
			this.CreateWebServiceAnimation(false);
		}
		
		private function CreateWebServiceAnimation(connected:Boolean)
		{
			var colour:Number = 0x33ff00;
			
			if (!connected)
				colour = 0xff0000;
			
			this.serverIconTimeline = new TimelineMax();
			this.serverIconTimeline.append(new TweenMax(this.serverIcon_mc, 1, {glowFilter:{color:colour, alpha:1, blurX:30, blurY:30, strength:3}}));
			this.serverIconTimeline.append(new TweenMax(this.serverIcon_mc, 1, {glowFilter:{color:colour, alpha:0, blurX:30, blurY:30, strength:3}}));
			this.serverIconTimeline.repeat(-1);
			this.serverIconTimeline.play();
		}
	}
	
}
