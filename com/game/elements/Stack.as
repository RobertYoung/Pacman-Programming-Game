package  com.game.elements {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class Stack extends MovieClip {
		
		public var controlInStack:String;
		
		public function Stack() {
			this.addEventListener(Event.ADDED_TO_STAGE, SetName);
		}
		
		function SetName(e:Event)
		{
			// Extract the digits from the instance name and set the position label
			var pattern:RegExp = /\d+/;

			position_txt.text = pattern.exec(this.name);
		}
	}
	
}
