package com.game.scenes {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.game.elements.AlertView;
	import flash.text.TextField;
	import com.game.factory.PacmanWebService;
	import com.game.factory.PacmanSharedObjectHelper;
	import flash.events.KeyboardEvent;
	import com.game.elements.PleaseWaitView;
	import com.game.elements.RegistrationForm;
	
	public class Login extends MovieClip {
		
		public var login_mc:MovieClip;
		public var signup_mc:MovieClip;
		public var username_txt:TextField;
		public var password_txt:TextField;
		private var main:Main;
		private var username:String;
		private var password:String;
		private var pleaseWaitView:PleaseWaitView;

		public function Login() {
			
		}
		
		public function Init()
		{
			login_mc.mouseChildren = false;
			login_mc.addEventListener(MouseEvent.MOUSE_OVER, OnMouseOver);
			login_mc.addEventListener(MouseEvent.MOUSE_OUT, OnMouseOut);
			login_mc.addEventListener(MouseEvent.MOUSE_UP, OnMouseUp);
			
			signup_mc.mouseChildren = false;
			signup_mc.addEventListener(MouseEvent.MOUSE_OVER, OnMouseOver);
			signup_mc.addEventListener(MouseEvent.MOUSE_OUT, OnMouseOut);
			signup_mc.addEventListener(MouseEvent.MOUSE_UP, OnMouseUpSignUp);
			
			this.AddKeyEventListener();
			
			this.password_txt.displayAsPassword = true;
			
			main = this.stage.getChildAt(0) as Main;
		}
		
		function OnKeyUp(e:KeyboardEvent)
		{
			if (e.keyCode == 13)
			{
				this.AttemptLogin();
				this.removeEventListener(KeyboardEvent.KEY_UP, OnKeyUp);
			}
		}
		
		function AddKeyEventListener()
		{
			this.addEventListener(KeyboardEvent.KEY_UP, OnKeyUp);
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
			this.AttemptLogin();
		}

		function ValidateFields():Boolean
		{
			var title:String = "";
			var description:String = "";
			
			this.username = this.username_txt.text.toLowerCase();
			this.password = this.password_txt.text.toLowerCase();
			
			if (username == "")
			{
				title = "Error";
				description = "Please enter your username";
			}else if (password == "")
			{
				title = "Error";
				description = "Please enter your password"
			}
			
			if (title != "") {
				var alertview:AlertView = new AlertView(title, description, "", AddKeyEventListener);
			
				stage.addChild(alertview);
				
				return false;
			}
			
			return true;
		}
		
		private function AttemptLogin()
		{
			if (!ValidateFields())
				return;
			
			var pacmanWebService:PacmanWebService = new PacmanWebService();
			
			pacmanWebService.UserLogin(username, password, LoginCallback);
			this.login_mc.enabled = false;
			
			pleaseWaitView = new PleaseWaitView();
			
			this.main.addChild(pleaseWaitView);
		}
		
		private function LoginCallback(response:String)
		{
			this.main.removeChild(pleaseWaitView);
			
			if (response == "" || response == "1" || response == "2" || response == "3")
			{
				PacmanSharedObjectHelper.getInstance().SetUserControls(int(response));
				PacmanSharedObjectHelper.getInstance().SetUsername(this.username);
				this.main.usernameStored = this.username;
				this.LoginSuccessfull();
				return;
			}else if (response == "false"){
				this.LoginFailure();
			}else{
				this.LoginError(response);
			}
			
			this.AddKeyEventListener();
		}
		
		private function LoginSuccessfull()
		{
			var username:String = this.username_txt.text;
			PacmanSharedObjectHelper.getInstance().SetUsername(username);
			main.GoToMenu();
		}
		
		private function LoginFailure()
		{
			var alertview:AlertView = new AlertView("Uknown User", "The user details you have entered appear to be incorrect, please try again");
			
			stage.addChild(alertview);
		}
		
		private function LoginError(error:String)
		{
			var alertview:AlertView = new AlertView("Error", "There appears to be an error with the server, please try again later", error);
			
			stage.addChild(alertview);
		}
		
		private function OnMouseUpSignUp(e:MouseEvent)
		{
			this.DisplayRegistrationForm();
		}
		
		private function DisplayRegistrationForm()
		{
			var registrationForm:RegistrationForm = new RegistrationForm();
			
			this.main.addChild(registrationForm);
		}
	}
}
