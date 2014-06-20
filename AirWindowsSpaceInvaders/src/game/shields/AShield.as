package game.shields {
	import flash.display.MovieClip;
	import game.projectiles.AProjectile;
	import game.ships.AShip;
	/**
	 * ...
	 * @author Glantucan
	 */
	public class AShield 
	{
		protected var energy:int;
		protected var skin:MovieClip;
		protected var owner:AShip;
		
		public function AShield() 
		{
			
		}
		
		public function takeDamage(projectile:AProjectile):void
		{
			skin.gotoAndPlay("hit");
			projectile.hit();
			energy -= projectile.damage;
			if (energy <= 0)
			{
				owner.shieldDestroyed();
				destroy();
			}
		}
		
		public function destroy():void
		{
			owner = null;
			skin = null;
			
		}
		
		
	}

}