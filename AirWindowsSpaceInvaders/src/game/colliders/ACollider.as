package game.colliders 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import game.projectiles.AProjectile;
	import game.ProjectileList;
	import game.UpdatableList;
	
	/**
	 * Define la funcionalidad básica de todos los objetos del juego que se deben actualizar en cada fotograma y 
	 * que pueden chocar.
	 * Esta clase es abstracta. No se deben crear instancias directamente de ella, si no de las clases que la extienden.
	 * @author Glantucan
	 */
	public class ACollider 
	{
		
		/**
		 * La piel del collider
		 */
		protected var skin:MovieClip;
		
		/**
		 * Este es el contenedor de todos los objetos colisionables. Se lo tenemos que pasar al constructor al crear 
		 * cualquier collider.
		 */
		protected var battleField:MovieClip;
		
		/**
		 * Este es un MovieClip de referencia que se utiliza para averiguar si el collider (se utiliza solo con los 
		 * proyectiles) se ha salido de la pantalla. Tiene que estar dentro de battleField y tener nombre de instancia 
		 * refrence_mc (ver constructor).
		 */
		protected var reference:DisplayObject;
		
		/**
		 * Lista de objetos actualizables en cada fotograma
		 */ 
		protected var updatableList:UpdatableList;
		
		/**
		 * Lista de proyectiles que le hacen pupa a los enemigos de esta nave.
		 */
		protected var fProjectiles:ProjectileList;
		
		/**
		 * rectágulo que se utiliza para la detección de colisiones con esta nave.
		 */
		protected var _collider:Rectangle;
		
		/**
		 * Sirve para saber si el collider ha sido destruido y se usa para seguir actualizando o no el objeto en cada 
		 * fotograma y para decidir eliminarlo si ya se ha terminado de reproducir su animación de destrucción. 
		 * Ver método update()
		 */
		public var destroyed:Boolean;
		
		/**
		 * Se utiliza para poder identificar el collider cuando hacemos traces.
		 */
		public var id:String;
		
		
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Métodos públicos
		
		
		/**
		 * Constructor que heredan todos los colliders. Esta clase es abstracta. No se deben crear instancias directamente
		 * de ella, si no de las clases que la extienden.
		 * 
		 * @param	theBattleField El contenedor dende se colocan todos los objetos de juego
		 * @param	theId Un identicador para este objeto. Se usará principalemtne para identificarlo cundo se hace un trace
		 * @param	updatables La lista de objetos actualizables en cada fotograma. Hace falta porque cada objeto se añade 
		 * 			a sí mismo a la lista cuando se crea y se elimina de ella cuando se destruye.
		 */
		public function ACollider(theBattleField:MovieClip, theId:String, updatables:UpdatableList) 
		{
			battleField = theBattleField;
			reference = battleField.reference_mc;
			id = theId;
			
			updatableList = updatables;
			updatableList.add(this);
			
			// Necesitamos esperar a que el objeto esté en la pantalla para poder calcular el rectángulo que se utiliza
			// para detectar colisiones.
			theBattleField.addEventListener(Event.ADDED, onAddedToBattleField);
			
		}
		
		/**
		 * Propiedad de sólo lectura. Nos da la coordenada x de la piel de este objeto
		 */
		public final function get x():Number
		{
			return skin.x;
		}
		
		/**
		 * Propiedad de sólo lectura. Nos da la coordenada y de la piel de este objeto
		 */
		public final function get y():Number
		{
			return skin.y;
		}
		
		/**
		 * Método que sirve para colocar la piel del objeto en las coordenadas especificadas como parámetros
		 * @param	x
		 * @param	y
		 */
		public final function place(x:Number, y:Number):void
		{
			skin.x = x;
			skin.y = y;
		}
		
		/**
		 * Propiedad de sólo lectura. Nos da el rectángulo de colisión
		 */
		public final function get collider():Rectangle
		{
			return _collider;
		}
		
		/**
		 * Propiedad de sólo lectura. Nos da el ancho del rectángulo de colisión
		 */
		public final function get width():Number
		{
			return _collider.width;
		}
		
		/**
		 * Propiedad de sólo lectura. Nos da el alto del rectángulo de colisión
		 */
		public final function get height():Number
		{
			return _collider.height;
		}
		
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Métodos plantilla
		
		/**
		 * Metodo al que se debe llamar cuando se quiera actualizar el estado del objeto. El estado del objeto incluye 
		 * su posición, la animación que esté reproduciendo su piel, si está destruido o no, la vida que le quyeda, 
		 * si es una nave, etc.
		 * Se ha implementado utilizando el "patrón plantilla", es decir, que establece el orden en el que se realizan 
		 * las operaciones y alguinos detalles de ellas, pero no todos. Los que nos se especifican se indican llamando 
		 * a un método que puedan sobreescribir las subclases de esta clase. De esta forma dejamos algunos detalles abiertos
		 * que hacen la arquitectura muho más flexible.
		 */
		public final function update():void  
		{
			// Si el objeto no ha sido destruido actualizamos la posición de su rectaágulo de colisión utilizando las 
			// coordenadas de la piel
			if (!destroyed)
			{
 				_collider.x = skin.x - _collider.width / 2;
				_collider.y = skin.y - _collider.height;
				
				// LLamada a un método abstracto (sin código en esta clase) que se puede sobreescribir en las subclases
				onUpdate();
				
			}
			else if (skin.animation_mc.currentLabel == "destroyed")
			{
				// si el método ha sido marcado como destruido lo eliminamos de la lista de updatables. 
				//if (this is AProjectile) trace("Projectile " + id +" is destroyed, removing from updatables");
				
				updatableList.remove(this);
			}
		}
		
		
		/**
		 * Método que elimina todos los subjetos relacionados con este cuando lo queremos eliminar de la memoria.
		 * Tenemos que asegurarnos de que se eliminan todas las referencias (asignaciones de variable), para que todos 
		 * los contenidos del objeto también sean eliminados.
		 * Este método también es plantilla, porque incluye una método onDisposal() que en esta clase está vacío
		 * y que se debe sobreescribir en cada subclase para que estas eliminen los objetos que se crean ellas y que no
		 * sean accesibles desde aquí
 		 */
		public final function dispose():void
		{
			// LLamada a un método abstracto (sin código en esta clase) que se puede sobreescribir en las subclases
			onDisposal();
			
			skin.parent.removeChild(skin);
			skin = null;
			_collider = null;
			battleField = null;
			reference = null;
			//id = null;
			updatableList = null;
		}
		
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Métodos abstractos (a ser sobreescritos con override en las subclases en las que se necesite)
		
		protected function onUpdate():void 
		{
			
		}
		
		
		protected function onDisposal():void 
		{
			
		}
		
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Métodos privados
		
		/**
		 * Cuando se haya añadido la piel al campo de batalla, generaremos el rectángulo que se utilizará para las colisiones
		 * Después ya sólo lo cambiaremos de posición en cada actualización
		 * @param	e
		 */
		private function onAddedToBattleField(e:Event):void 
		{
			battleField.removeEventListener(Event.ADDED, onAddedToBattleField);
			_collider = skin.getBounds(battleField.reference_mc);
		}
		
	}

}