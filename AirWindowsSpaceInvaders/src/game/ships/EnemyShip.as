
package game.ships 
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import game.gamerounds.AGameRound;
	import game.projectiles.AProjectile;
	/**
	 * ...
	 * @author Glantucan
	 */
	public class EnemyShip extends AShip
	{
		
		protected var firingRate:Number;
		protected var firingMode:String;
		
		public function EnemyShip(theContainer:MovieClip, gameRound:AGameRound) 
		{
			super(theContainer, gameRound);
			
		}
		
	
		override protected function showDamage(projectile:AProjectile):void 
		{
			var damage_mc:MovieClip = projectile.getDamageMC();
			damage_mc.x = projectile.skin.x - skin.x;
			damage_mc.visible = true;
			skin.addChild(damage_mc);
		}
		
		
		
		
		
	}

}