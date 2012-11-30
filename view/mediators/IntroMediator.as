/**
 * @author Saad Shams :: sshams@live.com
 * Copy or reuse is prohibited.
 * */
package view.mediators {
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	import view.components.Intro;
	
	public class IntroMediator extends Mediator implements IMediator {
		
		public static const NAME:String = "IntroMediator";
		
		public function IntroMediator(viewComponent:Object=null) {
			super(NAME, viewComponent);
			intro.addEventListener(Intro.NEXT, intro_nextHandler);
		}
		
		private function intro_nextHandler(event:Event):void {
			sendNotification(ApplicationFacade.SHOW_OLD_PACK);
		}
		
		public function get intro():Intro {
			return viewComponent as Intro;
		}
		
	}
}