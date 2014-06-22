package game.ships {
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import game.projectiles.HeroBullet;
	import game.projectiles.ProjectileList;
	import game.UpdatableList;
	
	
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
		
		public function HeroShip(	container:MovieClip,  shipId:String, updatables:UpdatableList, 
									friendProjectiles:ProjectileList, enemyProjectiles:ProjectileList) 
		{
			super(container, shipId, updatables, friendProjectiles, enemyProjectiles);
			skin = new HeroSkin();
			container.addChild(skin);
			
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
					if (!pressedKeys[e.keyCode])
					{
						spacePressed = true;
					}
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
		override protected function beforeCollision():void 
		{
			// Primero actualizamos la posición
			if (moveLeft )
			{
				a = -aMax;
			}
			else if (moveRight)
			{
				a = aMax;			
			}
			else
			{
				a = 0;
				v = 0;
			}
			
			// Acelerar hasta la velocidad máxima. Si acabamos de cambiar de dirección Primero frenamos
			// Si nos movemos de dirección (a*v < 0) hay que frenar (aplicando la acelaracion aunque 
			// el valor absoluto de la velocidad haya llegado al máximo).
			if (Math.abs(v) < vMax || a*v < 0)
			{
				v += a;
				skin.x += v;
			} 
			else
			{
				skin.x += v;
			}
			
			// Si nos pasamos de los límites parar la nave en el límite.
			if (skin.x > reference.stage.stageWidth - skin.width / 2 ||
				skin.x < skin.width / 2 )
			{
				if (skin.x > reference.width - skin.width / 2)
				{
					skin.x = reference.width - skin.width / 2 ;
				}
				else if (skin.x < reference.width - skin.width / 2)
				{
					skin.x = skin.width / 2 + 1;
				}
				a = 0;
				v = 0;
			}
			
			if (spacePressed)
			{
				createBullet();
				spacePressed = false;
			}
		}
		
		
		private function createBullet():void 
		{
			var bullet:HeroBullet = new HeroBullet(	container, "bullet_" + bulletCounter.toString(), 
													updatableList, fProjectiles);
			bullet.place(skin.x, skin.y - skin.height / 2);
			fProjectiles.add(bullet);
			bulletCounter++;
		}
		
		
		override protected function onDisposal():void
		{
			super.onDisposal();
		}
	}
	
}
