package hud {
	
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import game.Constants;
	
	public class AnimatedMessage extends Entity {
		
		protected var counter:Number;
		protected var text:Text;
		protected var backText:Text;
		protected var animation:Function;
		
		public function AnimatedMessage(xpos:Number, ypos:Number, title:String, size:uint, color:uint, backColor:uint, animationType:uint):void {
			text = new Text(title);
			text.size = size;
			text.color = color;
			text.centerOrigin();
			text.scrollX = 0;
			text.scrollY = 0;
			
			text.x = xpos;
			text.y = ypos;
			
			backText = new Text(title);
			backText.size = size;
			backText.color = backColor;
			backText.centerOrigin();
			backText.scrollX = 0;
			backText.scrollY = 0;
			
			backText.x = xpos - 3;
			backText.y = ypos + 3;
			
			graphic = new Graphiclist(backText, text);
			
			counter = 0;
			
			switch(animationType) {
				case Constants.NONE_ANIMATION:
					animation = noneAnimation;
					break;
				case Constants.SEESAW_ANIMATION:
					animation = seesawAnimation;
					break;
				case Constants.UP_DOWN_ANIMATION:
					animation = upAndDownAnimation;
					break;
				default:
					animation = seesawAnimation;
			}
		}
		
		override public function update():void {
			animation();
		}
		
		public function noneAnimation():void {
			// 
		}
		
		public function seesawAnimation():void {
			counter += 2;
			counter %= 360;
			text.angle = Math.cos(counter * Math.PI / 180) * 35;
			backText.angle = Math.cos(counter * Math.PI / 180) * 35;
		}
		
		public function upAndDownAnimation():void {
			counter += 2;
			counter %= 360;
			y += Math.sin(FP.RAD * counter) * 0.2;
		}
		
		public function disappeared():void {
			FP.world.recycle(this);
		}
		
	}

}