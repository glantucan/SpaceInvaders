package game.projectiles 
{
	import flash.display.MovieClip;
	import game.colliders.ACollider;
	import game.UpdatableList;
	/**
	 * ...
	 * @author Glantucan
	 */
	public class AProjectile extends ACollider
	{
		protected var projectiles:ProjectileList;
		protected var damage_mc:MovieClip;
		
		protected var vX:Number;
		protected var vY:Number;
		protected var aX:Number;
		protected var aY:Number;
		protected var vMax:Number;
		
		public var damage:int;
		
		
		public function AProjectile(	theContainer:MovieClip, projId:String, 
										updatables:UpdatableList, projectiles:ProjectileList) 
		{
			super(theContainer, projId, updatables);
			this.projectiles = projectiles;
			vX = 0;
			vY = 0;
			aX = 0;
			aY = 0;
			vMax = 0;
		}
		
		//Template
		public function hit():void
		{
			//trace("Projectile " + id +" hit, removing from projectile list");
			onHit();
			destroyed = true;
			_collider = null;
			skin.animation_mc.gotoAndPlay("destroy");
			projectiles.remove(this);
		}
		
		//Abstract
		protected function onHit():void
		{
			
		}
		
		override protected function onUpdate():void 
		{
			
			if (aX != 0 || aY != 0)
			{
				if (vX * vX + vY * vY < vMax * vMax)
				{
					vX += aX;
					vY += aY;
					skin.x += vX;
					skin.y += vY;
				} 
				else
				{
					aX = 0;
					aY = 0;
				}
			}
			else
			{
				skin.x += vX;
				skin.y += vY;
			}
			
			
			if (isOutOfScreen())
			{
				//trace("Projectile "+ id +" is out of screen, removing from lists")
				projectiles.remove(this);
				projectiles.clean();
 				updatableList.remove(this);
			}
			
		}
		
		public function isOutOfScreen():Boolean 
		{
			if (!destroyed)
			{
				if (_collider.intersects( reference.getBounds(reference) ) )
				{
					return false;
				} 
				else
				{
					return true;
				}
			}
			else
			{
				return false;
			}
		}
		
		
		
		public function getDamageMC():MovieClip 
		{
			return damage_mc;
		}
		
		
		override protected function onDisposal():void
		{
			destroyed = true;
			//trace("Projectile " + id +" is disposed now");
			projectiles = null;
		}
	}

}





