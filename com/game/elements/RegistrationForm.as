package com.game.elements {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import fl.controls.ComboBox;
	import flash.events.MouseEvent;
	import com.game.factory.PacmanWebService;
	
	public class RegistrationForm extends MovieClip {
		
		// Elements on movieclip
		public var username_txt:TextField;
		public var password_txt:TextField;
		public var gender_combobox:ComboBox;
		public var done_mc:MovieClip;
		public var cancel_mc:MovieClip;
		
		private var username:String;
		private var password:String;
		
		private var pleaseWaitView:PleaseWaitView;

		public var iii:ComboBox;
		
		public function RegistrationForm() {
			this.addEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
		public function Init(e:Event)
		{
			// Center alertview
			this.y = this.stage.stageHeight / 2;
			this.x = this.stage.stageWidth / 2;
			
			done_mc.mouseChildren = false;
			done_mc.addEventListener(MouseEvent.MOUSE_OVER, OnMouseOver);
			done_mc.addEventListener(MouseEvent.MOUSE_OUT, OnMouseOut);
			done_mc.addEventListener(MouseEvent.MOUSE_UP, AttemptSignup);
			
			cancel_mc.mouseChildren = false;
			cancel_mc.addEventListener(MouseEvent.MOUSE_OVER, OnMouseOver);
			cancel_mc.addEventListener(MouseEvent.MOUSE_OUT, OnMouseOut);
			cancel_mc.addEventListener(MouseEvent.MOUSE_UP, this.Close);
			
			this.gender_combobox.addItem({label:"Male", data:"M"}); 
			this.gender_combobox.addItem({label:"Female", data: "F"}); 
		}
		
		function OnMouseOver(e:MouseEvent)
		{
			e.target.alpha = 0.8;
		}
		
		function OnMouseOut(e:MouseEvent)
		{
			e.target.alpha = 1;
		}
		
		function Close(e:MouseEvent = null)
		{
			this.parent.removeChild(this);
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
				description = "Please enter a username";
			}else if (password == "")
			{
				title = "Error";
				description = "Please enter a password"
			}
			
			if (title != "") {
				var alertview:AlertView = new AlertView(title, description, "");
			
				stage.addChild(alertview);
				
				return false;
			}
			
			return true;
		}
		
		private function AttemptSignup(e:MouseEvent = null)
		{
			if (!ValidateFields())
				return;
			
			var pacmanWebService:PacmanWebService = new PacmanWebService();

			pacmanWebService.UserSignup(username, password, gender_combobox.selectedItem.data, SignupCallback);
	
			pleaseWaitView = new PleaseWaitView();
			
			this.stage.addChild(pleaseWaitView);
		}
		
		var successAlertview:AlertView;
		
		private function SignupCallback(response:String)
		{
			this.stage.removeChild(pleaseWaitView);
			
			if (response == "")
			{
				successAlertview = new AlertView("Success", "You have successfully created an account, please log in", "", this.AccountCreated);
			
				stage.addChild(successAlertview);
			}else{
				var alertview:AlertView = new AlertView("Signup Failed", response);
			
				stage.addChild(alertview);
			}
		}
		
		private function AccountCreated(e:MouseEvent = null)
		{
			this.Close();
		}
	}
}
