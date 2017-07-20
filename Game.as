package {
	
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import game.LevelData;
	import worlds.GameWorld;
	import net.flashpunk.graphics.Text;
	import worlds.MenuWorld;
	
	public class Game extends Engine {
		
		public function Game():void {
			super(640, 480, 60, false);
		}
		
		override public function init():void {
			super.init();
			Text.font = "Space Font";
			FP.world = new MenuWorld();
		}
	}
	
}