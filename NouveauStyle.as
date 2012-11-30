/**
 * @author Saad Shams :: sshams@live.com
 * Copy or reuse is prohibited.
 * */
package {
	import com.greensock.TweenMax;
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import view.components.Congratulations;
	import view.components.End;
	import view.components.Intro;
	import view.components.OldPack;
	import view.components.Puzzle;
	
	public class NouveauStyle extends MovieClip {
		
		public var intro:Intro;
		public var oldPack:OldPack;
		public var puzzle:Puzzle;
		public var congratulations:Congratulations;
		public var end:End;
		
		private var sound:Sound;
		private var soundChannel:SoundChannel;
		
		public function NouveauStyle() {
			intro = new Intro();
			oldPack = new OldPack();
			puzzle = new Puzzle();
			congratulations = new Congratulations();
			end = new End();
			
			ApplicationFacade.getInstance().startup(this);
			
			showIntro();
			
			sound = new BackgroundSound2();
			soundChannel = sound.play(0, 10000, new SoundTransform(.2));
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.displayState = StageDisplayState.FULL_SCREEN;
		}
		
		public function showIntro():void {
			addChild(intro);
			intro.animateIn();
		}
		
		public function hideIntro():void {
			removeChild(intro);
			intro.reset();
		}
		
		public function showOldPack():void {
			addChild(oldPack);
			oldPack.animateIn();
		}
		
		public function hideOldPack():void {
			removeChild(oldPack);
			oldPack.reset();
		}
		
		public function showPuzzle():void {
			addChild(puzzle);
			puzzle.animateIn();
		}
		
		public function hidePuzzle():void {
			removeChild(puzzle);
			puzzle.reset();
		}
		
		public function showCongratulations():void {
			addChild(congratulations);
			congratulations.animateIn();
		}
		
		public function hideCongratulations():void {
			removeChild(congratulations);
			congratulations.reset();
		}
		
		public function showEnd():void {
			addChild(end);
			end.animateIn();
		}
		
		public function hideEnd():void {
			removeChild(end);
			end.reset();
		}
		
	}
	
}