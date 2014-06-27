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
	import game.weapons.AWeaponArray;
	/**
	 * ...
	 * @author Glantucan
	 */
	public class AShip extends ACollider
	{
		/**
		 * Lista de proyectiles que me hace pupa
		 */
		protected var eProjectiles:ProjectileList;
		
		/**
		 * Escudo si lo tiene
		 */
		protected var shield:AShield;
		
		/**
		 * Si nave tiene varias armas las manejaremos en una clase que extienda a AWeaponsArray
		 * (esta parte está incompleta) y no se está usando
		 */
		protected var weaponsArray:AWeaponArray;
		
		/**
		 * Vida que le queda a la nave.
		 */
		protected var life:int;
		
		
		
		/**
		 * Constructor. Cada nave necesita conocer la lista de updatables para poder añadirse a si misma 
		 * (lo hace el constructor deA ACollider) y también para añadirle proyectiles cuando dispara.
		 * También necesita conocer la lista de proyectiles de las naves amigas (para añadirle proyectiles 
		 * cuando dispara) y la lista de proyectiles de las naves enemigas para comprobar si alguno de sus 
		 * proyectiles choca con ella (ver onUpdate())
		 * @param	theContainer
		 * @param	shipId
		 * @param	updatables
		 * @param	friendProjectiles
		 * @param	enemyProjectiles
		 */
		public function AShip( 	theContainer:MovieClip, shipId:String, updatables:UpdatableList,
								friendProjectiles:ProjectileList, enemyProjectiles:ProjectileList) 
		{
			super(theContainer, shipId, updatables);
			eProjectiles = enemyProjectiles;
			fProjectiles = friendProjectiles;
		}
		
		
		/**
		 * Operaciones específicas de las naves que se realizan en cada actualización 
		 */
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
			if (shield) shield.destroy();
			shield = null;
			if (weaponsArray)
			{
				weaponsArray.dispose();
			}
			weaponsArray = null;
			fProjectiles = null;
			eProjectiles = null;
		}
		
	}

}