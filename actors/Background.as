package actors {
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Backdrop;
	import game.Assets;
	
	public class Background extends Entity {
		
		public function Background():void {
			graphic = new Backdrop(Assets.BACKDROP_GRAPHICS);
			graphic.scrollX = 0.5;
			graphic.scrollY = 0.5;
			layer = 100;
		}
		
		override public function update():void {
			super.update();
			x -= FP.elapsed * 10;
			y -= FP.elapsed * 10;
		}
		
	}

}