package game.projectiles 
{
	import flash.display.MovieClip;
	import game.colliders.ACollider;
	import game.ProjectileList;
	import game.UpdatableList;
	/**
	 * Clase con la funcionalidad básica de todos los proyectiles
	 * @author Glantucan
	 */
	public class AProjectile extends ACollider
	{
		/**
		 * Lista de los proyectiles en la que se encuetra este proyectil. 
		 */
		protected var projectiles:ProjectileList;
		
		/**
		 * MovieClip que contiene el agujero que deja el proyectil en las naves y una animación (con humo, por ejemplo)
		 * si se desea.
		 */
		protected var damage_mc:MovieClip;
		
		/**
		 * Los proyectiles se animan usando cinemática (velocidad y aceleración) por eso se necesitan todas 
		 * estas propiedades
		 */
		protected var vX:Number;
		protected var vY:Number;
		protected var aX:Number;
		protected var aY:Number;
		
		/**
		 * Velocidad máxima que puede alcanzar el proyectil. Cuando la velocidad llega a este máximo se anula la 
		 * aceleración.
		 */
		protected var vMax:Number;
		
		/**
		 * Daño que produce este proyectil al objeto con el que impacte.
		 */
		public var damage:int;
		
		
		public function AProjectile(	theBattleField:MovieClip, projId:String, 
										updatables:UpdatableList, theProjectiles:ProjectileList) 
		{
			super(theBattleField, projId, updatables);
			
			projectiles = theProjectiles;
			vX = 0;
			vY = 0;
			aX = 0;
			aY = 0;
			vMax = 0;
		}
		
		/**
		 * Método a ejecutar cuando se detecte un impacto. Es un método plantilla, así que llama al método abstracto 
		 * onHit() que puede ser sobreescrito en las subclases de ésta clase, para añadir funcionalidad si se necesita.
		 * Marca el proyectil como destruido (de cara a la detección de colisiones) y lanza la animación de destrucción
		 * que se haya configurado en la línea de tiempo de la piuel (se asume que se le ha puesto la etiqueta "destroy")
 		 * 
		 */
		public function hit():void
		{
			//trace("Projectile " + id +" hit, removing from projectile list");
			
			onHit();
			
			destroyed = true;
			_collider = null;
			skin.animation_mc.gotoAndPlay("destroy");
			projectiles.remove(this);
		}
		
		/**
		 * Metodo abstracto que se ejecuta cuando se llama al método público hit() y que se puede sobreescribir si se 
		 * necesita en cada subclase, con funcionalidad específica.
		 */
		protected function onHit():void
		{
			
		}
		
		/**
		 * Método que sobreescribe el método abstracto onUpdate() de ACollider y que realiza las tareas específicas de
		 * actualización comunes para todos los proyectiles. 
		 * Se puede volver a sobreescribir en una subclase, pero es necesario utilizar super.onUpdate() dentro 
		 * porque las tareas que se especifican aquí son necesarias.
 		 */
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
		
		/**
		 * Comprueba si el proyectil se ha salido de la pantalla 
		 * @return true si se ha salido, false si no. Si el proyectil ya h asido destruido devuelve false siempre.
		 */
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
		
		
		/**
		 * Propiedad de solo lectura implementada con un getter. Permite obtener el movieclip que tiene el agujero 
		 * producido por el impacto.
		 * @return
		 */
		public function getDamageMC():MovieClip 
		{
			return damage_mc;
		}
		
		
		
		/**
		 * Método que sobreescribe el método abstracto onDispoasl() de ACollider y que realiza las tareas específicas de
		 * eliminación de objetos de la memoria comunes para todos los proyectiles.
		 * Se puede volver a sobreescribir en una subclase, pero es necesario utilizar super.onDisposal() dentro 
		 * porque las tareas que se especifican aquí son necesarias.
		 */
		override protected function onDisposal():void
		{
			destroyed = true;
			//trace("Projectile " + id +" is disposed now");
			projectiles = null;
		}
	}

}





