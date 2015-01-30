package com.game.scenes {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.game.elements.AlertView;
	import flash.text.TextField;
	import com.game.factory.PacmanWebService;
	
	public class Login extends MovieClip {
		
		public var login_mc:MovieClip;
		public var username_txt:TextField;
		public var password_txt:TextField;
		private var main:Main;
		
		public function Login() {
			
		}
		
		public function Init()
		{
			login_mc.mouseChildren = false;
			login_mc.addEventListener(MouseEvent.MOUSE_OVER, OnMouseOver);
			login_mc.addEventListener(MouseEvent.MOUSE_OUT, OnMouseOut);
			login_mc.addEventListener(MouseEvent.MOUSE_UP, OnMouseUp);
			
			this.password_txt.displayAsPassword = true;
			
			main = this.stage.getChildAt(0) as Main;
		}
		
		function OnMouseOver(e:MouseEvent)
		{
			e.target.alpha = 0.8;
		}
		
		function OnMouseOut(e:MouseEvent)
		{
			e.target.alpha = 1;
		}
		
		function OnMouseUp(e:MouseEvent)
		{
			var title:String = "";
			var description:String = "";
			
			if (this.username_txt.text == "")
			{
				title = "Error";
				description = "Please enter your username";
			}else if (this.password_txt.text == "")
			{
				title = "Error";
				description = "Please enter your password"
			}
			
			if (title != "") {
				var alertview:AlertView = new AlertView(title, description);
			
				stage.addChild(alertview);
				
				return;
			}
			
			PacmanWebService.getInstance().UserLogin(this.username_txt.text, this.password_txt.text);
		}
		
		public function LoginSuccessfull()
		{
			main.GoToMenu();
		}
		
		public function LoginFailure()
		{
			var alertview:AlertView = new AlertView("Uknown User", "The user details you have entered appear to be incorrect, please try again");
			
			stage.addChild(alertview);
		}
	}
	
}
