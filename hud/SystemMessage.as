package hud {
	
	import net.flashpunk.FP;
	import game.Constants;
	
	public class SystemMessage extends AnimatedMessage {
		
		public function SystemMessage(string:String = "") {
			super(FP.halfWidth, 50, string, 32, 0xFFFFFF, 0x000000, Constants.NONE_ANIMATION);
		}
		
	}

}