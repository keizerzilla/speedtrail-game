package hud {
	
	import hud.ProceduralMessage;
	
	public class SuccessMessage extends ProceduralMessage {
		
		public function SuccessMessage():void {
			super(new Array("MAN", "DUDE", "CHAMP", "BEAUTY"),
			      new Array("ROCK", "DESERVE", "CONQUER", "DESTROY"),
				  new Array("LEVEL", "WORLD", "GALAXY", "BUTT"),
				  0x4682B4);
		}
		
	}

}