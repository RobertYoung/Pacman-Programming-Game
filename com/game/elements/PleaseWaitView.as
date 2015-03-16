package com.game.elements {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import com.greensock.TweenMax;	
	import com.greensock.*;
	import com.greensock.easing.*;
	
	public class PleaseWaitView extends MovieClip {

		// Elements on SWF
		public var pleaseWait_txt:TextField;
		public var pacman_mc:MovieClip;
		
		// Tweens
		public var pleaseWaitTween:TweenMax;
		public var pacmanTween:TweenMax;
		
		public function PleaseWaitView() {
			this.addEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
		//******//
		// INIT //
		//******//
		private function Init(e:Event)
		{
			this.x = this.stage.stageWidth / 2;
			this.y = this.stage.stageHeight / 2;
			
			this.pleaseWaitTween = new TweenMax(this.pleaseWait_txt, 3, { });
			this.pleaseWaitTween.yoyo(true);
			this.pleaseWaitTween.repeat(-1);
			this.pleaseWaitTween.play();
			
			this.pacmanTween = new TweenMax(this.pacman_mc, 1, { rotation: 360, ease:Linear.easeNone });
			this.pacmanTween.repeat(-1);
			this.pacmanTween.play();
		}
	}
	
}
