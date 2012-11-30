/**
 * @author Saad Shams :: sshams@live.com
 * Copy or reuse is prohibited.
 * */
package view.mediators {
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.components.Puzzle;
	
	public class PuzzleMediator extends Mediator implements IMediator {
		
		public static const NAME:String = "PuzzleMediator";
		
		public function PuzzleMediator(viewComponent:Object=null) {
			super(NAME, viewComponent);
			puzzle.addEventListener(Puzzle.NEXT, puzzle_nextHandler);
		}
		
		private function puzzle_nextHandler(event:Event):void {
			sendNotification(ApplicationFacade.SHOW_CONGRATULATIONS);
		}
		
		public function get puzzle():Puzzle {
			return viewComponent as Puzzle;
		}
		
	}
}