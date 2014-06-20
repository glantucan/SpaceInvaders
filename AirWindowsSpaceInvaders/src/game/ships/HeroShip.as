package game.ships {
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import game.gamerounds.AGameRound;
	import game.projectiles.HeroBullet;
	import game.AUpdater;
	
	
	public class HeroShip extends AShip 
	{
		private var moveLeft:Boolean;
		private var moveRight:Boolean;
		private var spacePressed:Boolean;
		private var pressedKeys:Object;
		
		private var v:Number;
		private var a:Number;
		private var vMax:Number;
		private var aMax:Number;
		private var bulletCounter:int;
		
		public function HeroShip(container:MovieClip, gameRound:AGameRound) 
		{
			skin = container.addChild( new HeroSkin() ) as MovieClip;
			
			super(container, gameRound);
			
			a = 0;
			v = 0;
			aMax = .5;
			vMax = 5;
			
			// This (and the related checks hereafter) is only necessary if you want the ship to continue
			// moving left, if you hold left when pressing right and then release right.
			pressedKeys = { };
			
			container.stage.addEventListener(KeyboardEvent.KEY_DOWN, alPulsarTecla);
			container.stage.addEventListener(KeyboardEvent.KEY_UP, alSoltarTecla);
		}
		
		private function alPulsarTecla(e:KeyboardEvent):void
		{
			//pressedKeys[e.keyCode] = true;
			switch(e.keyCode) 
			{
				case Keyboard.LEFT:
					if (!pressedKeys[e.keyCode] )
					{
						moveLeft = true;
					}
					if (moveRight)
					{
						moveRight = false;
					}
					break;
					
				case Keyboard.RIGHT:
					if (!pressedKeys[e.keyCode])
					{
						moveRight = true;	
					}
					if (moveLeft)
					{
						moveLeft = false;
					}
					break;
					
				case Keyboard.SPACE:
					spacePressed = true;
					break;
				
				default:
					break;
			}
			pressedKeys[e.keyCode] = true
		}
		
		private function alSoltarTecla (e:KeyboardEvent):void
		{
			
			switch(e.keyCode) 
			{
				case Keyboard.LEFT:
					moveLeft = false;
					if (pressedKeys[Keyboard.RIGHT])
					{
						moveRight = true;
					}
					break;
				case Keyboard.RIGHT:
					moveRight = false;
					if (pressedKeys[Keyboard.LEFT])
					{
						moveLeft = true;
					}
					break;
				case Keyboard.SPACE:
					spacePressed = false;
					break;
				default:
					break;
			}	
			pressedKeys[e.keyCode] = false;
		}
		
		// Debería ser heredada de Ship.
		override public function update():void 
		{
			if (skin.x > container.stage.stageWidth - skin.width / 2 ||
				skin.x < skin.width / 2 )
			{
				if (skin.x > container.stage.stageWidth - skin.width / 2)
				{
					skin.x = container.stage.stageWidth - skin.width / 2 ;
				}
				else if (skin.x < container.stage.stageWidth - skin.width / 2)
				{
					skin.x = skin.width / 2 + 1;
				}
				a = 0;
				v = 0;
			}
			else
			{
				if (moveLeft )
				{
					a = -aMax;
					//trace("left", a, v);
				}
				else if (moveRight)
				{
					a = aMax;
					//trace("right", a, v);					
				}
				else
				{
					a = 0;
					v = 0;
				}
				// Tricky way to tell if a and v have different sign (a*v < 0)
				if (Math.abs(v) < vMax || a*v < 0)
				{
					v += a;
					skin.x += v;
				} 
				else
				{
					skin.x += v;
				}
			}
			
			if (spacePressed)
			{
				createBullet();
				spacePressed = false;
			}
		}
		
		private function createBullet():void 
		{
			var bullet:HeroBullet = new HeroBullet(container, gameRound, "bullet_" + bulletCounter.toString());
			bullet.place(skin.x, skin.y - skin.height / 2);
			gameRound.addHeroProjectile(bullet);
			bulletCounter++;
			trace("shoting " + bullet.id);
		}
		
		override public function dispose():void
		{
			super.dispose();
		}
	}
	
}
