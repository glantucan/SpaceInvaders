package game.projectiles 
{
	import flash.display.MovieClip;
	import game.ProjectileList;
	import game.UpdatableList;
	/**
	 * Proyectiles disparados por la neve heroe
	 * @author Glantucan
	 */
	public class HeroBullet extends AProjectile
	{
		
		
		public function HeroBullet(	theBattleField:MovieClip, projId:String, 
									updatables:UpdatableList, projectiles:ProjectileList) 
		{
			super(theBattleField, projId,	updatables,	projectiles);
			
			skin = new HeroBulletSkin();
			battleField.addChild(skin);
			
			damage_mc = skin.animation_mc.damage_mc;
			skin.animation_mc.removeChild(damage_mc);
			
			_collider = skin.getBounds(reference);
			aY = -1;
			vMax = 10;
			damage = 2;
		}
		
		
	}

}