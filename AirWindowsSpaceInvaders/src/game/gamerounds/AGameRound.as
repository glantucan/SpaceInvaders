package game.gamerounds 
{
	import com.greensock.TimelineLite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import game.ProjectileList;
	import game.ships.HeroShip;
	import game.UpdatableList;
	/**
	 * ...
	 * @author Glantucan
	 */
	public class AGameRound 
	{
		/**
		 * Es el movieclip donde se añaden todos los objetos del juego
		 */
		protected var battleField:MovieClip;
		
		/**
		 * La instancia de TimelineLite (Greensock) que sirve para animar el movimiento de las naves enemigas
		 */
		protected var timeline:TimelineLite;
		
		/**
		 * Ancho de la formación de naves enemigas
		 */
		protected var formationWidth:Number;
		/**
		 * Espacio que queremos dejar a los lados de la formación de naves enemigas
		 */
		protected var formationMargin:Number;
		
		/**
		 * Ancho del campo de batalla. No tiene por qué coincidir con el ancho de la escena y 
		 * estará marcado por el ancho del movieclip de refenrencia que tengamos dentro del campo 
		 * de batalla (debe tener un nombre de instancia reference_mc)
		 */
		protected var battleWidth:Number;
		
		/**
		 * Numero de columnas de la formación denaves enemigas
		 */
		protected var enemyCols:int;
		
		/**
		 * Numero de filas de la formación denaves enemigas
		 */
		protected var enemyRows:int;
		
		/**
		 * Desplazamiento vertical en cada moviemiento vertical de las naves enemigas
		 */
		protected var verticalStepDistance:Number;
		
		/**
		 * Número de desplazamientos verticales de la animación de las naves enemigas
		 */
		protected var verticalStepNumber:int;
		
		/**
		 * Contador de fotogramas (por si se necesita)
		 */
		private var frameCount:int;
		
		/**
		 * Instancia de la lista de objetos actualizales en cada fotograma
		 */
		protected var updatableObjects:UpdatableList;
		
		/**
		 * Instancia de la lista de proyectiles que se utiliza para los proyectiles del heroe
		 */
		protected var heroProjectiles:ProjectileList;
		
		/**
		 * Instancia de la lista de proyectiles que se utiliza para los proyectiles de los enemigos
		 */
		protected var alienProjectiles:ProjectileList;
		
		/**
		 * la nave del héroe
		 */
		protected var hero:HeroShip;
		
		/**
		 * Constructor
		 * @param	battleField El movieclip del campo de batalla. Puede ser animado. Debe contener 
		 * un MovieCLip de referencia (alpha=0) con el nombre de instancia ("reference_mc") que se
		 * usara como refernecia del tamaño del campo de batalla y como sistema de referencia para todos los getBounds()
		 */
		public function AGameRound(battleField:MovieClip) 
		{
			this.battleField = battleField;
			

			battleWidth = battleField.reference_mc.width;
			formationWidth = 0.6 * battleWidth;
			formationMargin =  0.05 * battleWidth;
			
			timeline = new TimelineLite();
			
			// Creamos las listas de proyectiles y de objetos a actualizar en cada fotograma
			updatableObjects = new UpdatableList();
			heroProjectiles = new ProjectileList();
			alienProjectiles = new ProjectileList();
		}
		
		
		/**
		 * Método plantilla para crear todos los elementos de la ronda actual. Sólo llama a métodos abstractos 
		 * (no implementados en esta clase) que pueden/deben ser sobreescritos por las subclases
		 */
		public final function buildRound():void
		{
			// Llamada al método abstracto que se puede sobreescribir en cada subclase que ha de servir para crear
			// el fondo del campo de batalla
			createBackground();
			
			// Llamada al método abstracto que se puede sobreescribir en cada subclase que ha de servir para crear
			// las naves de esta ronda.
			createAndConfigureShips();
		}
		
		/**
		 * Comienza la ronda actual
		 */
		public function startRound():void
		{
			battleField.stage.addEventListener(Event.ENTER_FRAME, enCadaFrame);
		}
		
		/**
		 * A ser llamado cuando acabe la ronda actual (mueran todas las naves enemigas o la del heroe)
		 */
		public function endRound():void
		{
			trace("round finished");
			//battleField.removeEventListener(Event.ENTER_FRAME, enCadaFrame);
		}
		
		/**
		 * Metodo abastracto, en principio, que si queremos que todos los fondos de ronda sean distintos habrá 
		 * que sobreescribir en cada subclase
		 */
		protected function createBackground():void 
		{ 
		
		}
		
		
		/**
		 * Metodo abastracto que se debe sobreescribir en cada subclase para crear todas las naves de cada ronda
		 */
		protected function createAndConfigureShips():void
		{ 
			
		}
		
		
		/**
		 * Método que se ejecuta en cada fotograma (listener de ENTER_FRAME) que desencadena la actualización de todos
		 * los elementoes del juego
		 * @param	e
		 */
		private function enCadaFrame(e:Event):void 
		{
			updatableObjects.update(frameCount);
			
			if (updatableObjects.length == 1 || hero.destroyed)
			{
				endRound();
			}
			frameCount++;
		}
		
	}

}