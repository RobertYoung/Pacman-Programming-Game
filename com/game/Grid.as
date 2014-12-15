package com.game {
	
	import com.game.objects.KeyObject;
	
	public class Grid {		
		
		//**************************************//
		//	CONSTANT VALUES FOR EACH GRID BLOCK //
		//**************************************//
		public static const BLANK:String = "BLANK";
		public static const BOX:String = "BOX";
		
		public static const HORIZONTAL:String = "HORIZONTAL";
		public static const VERTICAL:String = "VERTICAL";
		
		public static const END_UP:String = "END_UP";
		public static const END_DOWN:String = "END_DOWN";
		public static const END_RIGHT:String = "END_RIGHT";
		public static const END_LEFT:String = "END_LEFT";

		public static const LEFT_DOWN:String = "LEFT_DOWN";
		public static const LEFT_UP:String = "LEFT_UP";
		
		public static const RIGHT_DOWN:String = "RIGHT_DOWN";
		public static const RIGHT_UP:String = "RIGHT_UP";
		
		public static const T_HORIZONTAL_DOWN:String = "T_HORIZONTAL_DOWN";
		public static const T_HORIZONTAL_UP:String = "T_HORIZONTAL_UP";
		public static const T_VERTCIAL_LEFT:String = "T_VERTICAl_LEFT";
		public static const T_VERTICAL_RIGHT:String = "T_VERTICAL_RIGHT";
		
		public static const CROSSROADS:String = "CROSSROADS";
		
		//*************************************//
		// CONSTANT VALUES FOR REWARD ELEMENTS //
		//*************************************//
		public static const REWARD_APPLE:String = "REWARD_APPLE";
		public static const REWARD_CHERRY:String = "REWARD_CHERRY";
		public static const REWARD_STRAWBERRY:String = "REWARD_STRAWBERRY";
		
		//******************************//
		// CONSTANT VALUES FOR MONSTERS //
		//******************************//
		public static const MONSTER_BLINKY:String = "MONSTER_BLINKY";
		public static const MONSTER_CLYDE:String = "MONSTER_CLYDE";
		public static const MONSTER_INKY:String = "MONSTER_INKY";
		public static const MONSTER_PINKY:String = "MONSTER_PINKY";
		
		//************************************//
		// VARIABLES ASSOCIATED FOR EACH GRID //
		//************************************//
		public var row:int;
		public var col:int;
		public var gridBlock:String;
		public var pacmanStart:Boolean = false;
		public var apple:Boolean = false;
		public var cherry:Boolean = false;
		public var strawberry:Boolean = false;
		public var blinky:Boolean = false;
		public var clyde:Boolean = false;
		public var inky:Boolean = false;
		public var pinky:Boolean = false;
		public var door:Boolean = false;
		public var hole:Boolean = false;
		public var key:KeyObject = new KeyObject();
		
		//************************************************//
		// INITILIZING CONSTRUCTOR TO SETUP A GRID EASILY //
		//************************************************//
		public function Grid(newRow:int = 0, newCol:int = 0, newGridBlock:String = "") {
			gridBlock = newGridBlock;
			row = newRow;
			col = newCol;
		}

		//******************************************//
		// FUNCTIONS TO SET VARIABLES IN THIS CLASS //
		//******************************************//
		public function SetGridBlock(newGridBlock:String){
			gridBlock = newGridBlock;
		}
		
		public function SetPacmanStart(newPacmanStart:Boolean) {
			pacmanStart = newPacmanStart;
		}
		
		public function SetReward(newReward:String) {
			switch (newReward) {
				case REWARD_APPLE:
					apple = true;
				break;
				case REWARD_CHERRY:
					cherry = true;
				break;
				case REWARD_STRAWBERRY:
					strawberry = true;
				break;
			}
		}
		
		public function SetMonster(newMonster:String) {
			switch (newMonster) {
				case MONSTER_BLINKY:
					blinky = true;
				break;
				case MONSTER_CLYDE:
					clyde = true;
				break;
				case MONSTER_INKY:
					inky = true;
				break;
				case MONSTER_PINKY:
					pinky = true;
				break;
			}
		}
		
		public function SetDoor(newDoor:Boolean) {
			door = newDoor;
		}
		
		public function SetHole(newHole:Boolean) {
			hole = newHole;
		}
		
		public function SetKey(isKey:Boolean, numberOfKeys:int) {
			key.isKey = isKey;
			key.numberOfKeys = numberOfKeys;
		}
	}
}