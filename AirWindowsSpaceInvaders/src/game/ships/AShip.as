package game.ships {
	import com.greensock.TweenLite;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import game.gamerounds.AGameRound;
	import game.projectiles.AProjectile;
	import game.shields.AShield;
	/**
	 * ...
	 * @author Glantucan
	 */
	public class AShip 
	{
		protected var gameRound:AGameRound;
		
		protected var container:MovieClip;
		protected var skin:MovieClip;
		protected var collider:Rectangle;
		
		protected var shield:AShield;
		protected var weaponsArray:Array;
		
		public var id:String;
		protected var life:int;
		
		public var destroyed:Boolean;
		public var disposed:Boolean;
		//protected var weapons:WeaponsArray;
		
		
		public function AShip(theContainer:MovieClip, theGameRound:AGameRound) 
		{
			gameRound = theGameRound;
			container = theContainer;
			collider = skin.getBounds(container.reference_mc);
		}
		
		
		public function place(x:Number, y:Number):void
		{
			skin.x = x;
			skin.y = y;
		}
		
		//Abstract update function
		public function update():void  
		{
			if (destroyed && skin.ship_mc.currentLabel == "dead")
			{
				dispose();
			}
		}
		
		public function getCollider():Rectangle
		{
			collider.x = skin.x - skin.width / 2;;
			collider.y = skin.y - skin.height / 2;;
			
			return collider;
		}
		
		public function getSkin():DisplayObject
		{
			return skin;
		}
		
		public function takeDamage(projectile:AProjectile):void
		{
			
			if (shield)
			{
				shield.takeDamage(projectile);
			}
			else
			{	
				life -= projectile.damage;
				trace(this.id + " taking damage. -> Life left: "+ life);
				TweenLite.to(this.skin.ship_mc, 0.01, { y:"-=10" } );
				TweenLite.to(this.skin.ship_mc, 0.5, { y:"+=10", delay:0.01 } );
				
				if (life <= 0)
				{
					skin.ship_mc.gotoAndPlay("die");
					destroyed = true;
				}
				else
				{
					showDamage(projectile);
				}
			}
		}
		
		// Abstract method
		protected function showDamage(projectile:AProjectile):void { }
		
		
		
		public function shieldDestroyed():void
		{
			shield = null;
		}
		
		public function dispose():void
		{
			disposed = true;
			if (shield) shield.destroy();
			shield = null;
			if (weaponsArray)
			{
				for (var i:int = 0; i < weaponsArray.length; i++) 
				{
					weaponsArray[i].destroy();
					weaponsArray.splice(0);
				}
			}
			weaponsArray = null;
			skin.parent.removeChild(skin);
			skin = null;
			gameRound = null;
		}
		
	}

}