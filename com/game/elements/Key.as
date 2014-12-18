package com.game.elements {
	
	import flash.display.MovieClip;
	import com.game.*;
	import com.game.objects.KeyObject;
	
	public class Key extends MovieClip {
		
		public var key:KeyObject;
		
		public function Key(setKey:KeyObject) {
			key = setKey;
			
			UpdateKey();
		}
		
		public function UpdateKey() 
		{
			this.numberOfKeys_txt.text = key.numberOfKeys.toString();
		}
	}
	
}
