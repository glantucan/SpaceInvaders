package game.projectiles 
{
	import flash.display.MovieClip;
	import game.UpdatableList;
	/**
	 * ...
	 * @author Glantucan
	 */
	public class HeroBullet extends AProjectile
	{
		
		
		public function HeroBullet(	theContainer:MovieClip, projId:String, 
									updatables:UpdatableList, projectiles:ProjectileList) 
		{
			super(theContainer, projId,	updatables,	projectiles);
			skin = new HeroBulletSkin();
			container.addChild(skin);
			
			damage_mc = skin.animation_mc.damage_mc;
			skin.animation_mc.removeChild(damage_mc);
			
			_collider = skin.getBounds(container.stage);
			aY = -1;
			vMax = 10;
			damage = 2;
		}
		
		
	}

}