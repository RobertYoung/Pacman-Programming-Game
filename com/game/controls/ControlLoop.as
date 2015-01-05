package com.game.controls {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.game.elements.Stack;
	import flash.text.TextField;
	import flash.events.Event;
	
	public class ControlLoop extends Control {
		
		public var loopTimes_txt:TextField;
		
		public function ControlLoop() {
			this.x = super.nX
			this.y = super.nY;
			
			this.controlName = "Loop";
			this.controlDescription = "";
		}
		
		override function AddControlToStack(e:MouseEvent, stackPosition:Stack)
		{
			super.AddControlToStack(e, stackPosition);
			
			this.gotoAndStop(2);
			
			this.loopTimes_txt.restrict = "0-9";
		}
		
		public function GetLoopTimes():Number
		{
			return parseInt(this.loopTimes_txt.text) as Number;
		}
	}
	
}
