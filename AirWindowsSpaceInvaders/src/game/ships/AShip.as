package game.ships {
	import com.greensock.TweenLite;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import game.colliders.ACollider;
	import game.gamerounds.AGameRound;
	import game.projectiles.AProjectile;
	import game.ProjectileList;
	import game.shields.AShield;
	import game.UpdatableList;
	/**
	 * ...
	 * @author Glantucan
	 */
	public class AShip extends ACollider
	{
		// Lista de proyectiles que me hace pupa
		protected var eProjectiles:ProjectileList;
		
		protected var shield:AShield;
		protected var weaponsArray:Array;
		
		protected var life:int;
		
		public var disposed:Boolean;
		//protected var weapons:WeaponsArray;
		
		
		public function AShip( 	theContainer:MovieClip, shipId:String, updatables:UpdatableList,
								friendProjectiles:ProjectileList, enemyProjectiles:ProjectileList) 
		{
			super(theContainer, shipId, updatables);
			eProjectiles = enemyProjectiles;
			fProjectiles = friendProjectiles;
		}
		
		
		//Abstract update function
		override protected final function onUpdate():void  
		{
			beforeCollision();
			eProjectiles.collisionCheck(this);
			afterCollision();
		}
		
		protected function beforeCollision():void {}
		protected function afterCollision():void {}
		
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
				
				if (life <= 0)
				{
					skin.animation_mc.gotoAndPlay("destroy");
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
		
		override protected function onDisposal():void
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
			fProjectiles = null;
			eProjectiles = null;
		}
		
	}

}