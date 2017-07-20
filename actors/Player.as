package actors {
	
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.AngleTween;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.utils.Ease;
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	import game.Assets;
	import game.Constants;
	
	public class Player extends Entity {
		
		private const SPEED:Number = 6;
		private const EXPLOSION_SIZE:uint = 60;
		private const RUN_SIZE:uint = 2;
		
		public var sprite:Image;
		public var vx:Number;
		public var emitter:Emitter;
		public var vy:Number;
		public var angle:uint;
		public var animationTween:NumTween;
		public var angleTween:AngleTween;
		
		public function Player(xpos:Number, ypos:Number):void {
			super(xpos, ypos);
			type = "player";
			
			sprite = new Image(Assets.PLAYER);
			sprite.centerOrigin();
			setHitbox(sprite.width, sprite.height);
			centerOrigin();
			
			vx = 0;
			vy = 0;
			
			emitter = new Emitter(new BitmapData(4, 4), 4, 4);
			
			emitter.newType(Constants.EXPLODE, [0]);
			emitter.setAlpha(Constants.EXPLODE, 1, 0);
			emitter.setMotion(Constants.EXPLODE, 0, 50, 2, 360, -40, -0.5, Ease.quadOut);
			
			emitter.newType(Constants.RUN, [0]);
			emitter.setAlpha(Constants.RUN, 1, 0);
			emitter.setMotion(Constants.RUN, 0, 50, 0.5, 360);
			
			emitter.relative = false;
			
			animationTween = new NumTween();
			animationTween.tween(1, 0, 1);
			animationTween.active = false;
			addTween(animationTween);
			
			angleTween = new AngleTween();
			angle = sprite.angle;
			angleTween.angle = angle;
			addTween(angleTween, false);
			
			graphic = new Graphiclist(emitter, sprite);
		}
		
		public function move():void {
			if (Input.pressed(Key.UP)) {
				angle = 0;
				vy = -SPEED;
				vx = 0;
			} else if (Input.pressed(Key.DOWN)) {
				angle = 180;
				vy = SPEED;
				vx = 0;
			} else if (Input.pressed(Key.LEFT)) {
				angle = 90;
				vy = 0;
				vx = -SPEED;
			} else if (Input.pressed(Key.RIGHT)) {
				angle = 270;
				vy = 0;
				vx = SPEED;
			}
			
			angleTween.tween(sprite.angle, angle, 0.5, Ease.quintOut);
			angleTween.start();
			
			moveBy(vx, vy);
			
			if (vx != 0 || vy != 0) {
				for (var i:uint = 0; i < RUN_SIZE; i++) {
					emitter.emit(Constants.RUN, centerX, centerY);
				}
			}
		}
		
		override public function update():void {
			super.update();
			sprite.angle = angleTween.angle;
			
			if (animationTween.active) {
				sprite.alpha = animationTween.value;
				sprite.scale += animationTween.value * 0.01;
			}
		}
		
		public function teleport():void {
			collidable = false;
			animationTween.start();
		}
		
		public function kill():void {
			collidable = false;
			sprite.visible = false;
			
			for (var i:uint = 0; i < EXPLOSION_SIZE; i++) {
				emitter.emit(Constants.EXPLODE, centerX, centerY);
			}
		}
		
	}

}