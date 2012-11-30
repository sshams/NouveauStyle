/**
 * @author Saad Shams :: sshams@live.com
 * Copy or reuse is prohibited.
 * */
package {
	import controller.StartupCommand;
	
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	
	public class ApplicationFacade extends Facade implements IFacade {
		
		public static const STARTUP:String = "startup";
		public static const SHOW_OLD_PACK:String = "showOldPack";
		public static const SHOW_PUZZLE:String = "showPuzzle";
		public static const SHOW_CONGRATULATIONS:String = "showCongratulations";
		public static const SHOW_END:String = "showEnd";
		public static const RESTART:String = "restart";
		
		public static function getInstance():ApplicationFacade {
			if(instance == null){
				instance = new ApplicationFacade();
			}
			return instance as ApplicationFacade;
		}
		
		override protected function initializeController():void {
			super.initializeController();
			registerCommand(STARTUP, StartupCommand);
		}
		
		public function startup(app:NouveauStyle):void {
			sendNotification(STARTUP, app);
		}
		
	}
}