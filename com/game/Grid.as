package com.game {
	
	public class Grid {

		//**************************************//
		//	CONSTANT VALUES FOR EACH GRID BLOCK //
		//**************************************//
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
		
		//************************************//
		// VARIABLES ASSOCIATED FOR EACH GRID //
		//************************************//
		public var row:int;
		public var col:int;
		public var gridBlock:String;
		public var gridElements:Array;
		
		//************************************************//
		// INITILIZING CONSTRUCTOR TO SETUP A GRID EASILY //
		//************************************************//
		public function Grid(setRow:int = 0, setCol:int = 0, setGridBlock:String = "", setGridElements:Array = null) {
			gridBlock = setGridBlock;
			gridElements = setGridElements;
			row = setRow;
			col = setCol;
		}

	}
	
}
