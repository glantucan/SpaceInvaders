package game.ships 
{
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import game.projectiles.AProjectile;
	import game.ProjectileList;
	import game.UpdatableList;
	/**
	 * ...
	 * @author Glantucan
	 */
	public class EnemyShip extends AShip
	{
		
		protected var firingRate:Number;
		protected var firingMode:String;
		
		public function EnemyShip(	theContainer:MovieClip, shipId:String, updatables:UpdatableList, 
									friendProjectiles:ProjectileList, enemyProjectiles:ProjectileList) 
		{
			super(theContainer, shipId, updatables, friendProjectiles, enemyProjectiles);
			
		} 
		
		override protected function showDamage(projectile:AProjectile):void 
		{
			var damage_mc:MovieClip = projectile.getDamageMC();
			damage_mc.x = projectile.x - x;
			damage_mc.visible = true;
			skin.animation_mc.addChild(damage_mc);
			// Para simular el retroceso producido por el impacto
			TweenLite.to(this.skin.animation_mc, 0.01, { y:"-=10" } );
			TweenLite.to(this.skin.animation_mc, 0.5, { y:"+=10", delay:0.01 } );
		}
		
		
		override protected function onDisposal():void 
		{
			super.onDisposal();
		}
	}

}