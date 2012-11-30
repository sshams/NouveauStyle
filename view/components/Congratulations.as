/**
 * @author Saad Shams :: sshams@live.com
 * Copy or reuse is prohibited.
 * */
package view.components {
	import com.greensock.easing.Quint;
	import com.muizz.IAnimatable;
	import com.muizz.TweenClips;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Congratulations extends MovieClip implements IAnimatable {
		
		public static const NEXT:String = "next";
		
		private var clips:Vector.<MovieClip>;
		private var timer:Timer;
		
		private const TOTAL_CLIPS:int = 1;
		
		public function Congratulations() {
			clips = new Vector.<MovieClip>();
			for(var i:int=0; i<TOTAL_CLIPS; i++){
				clips.push(this.getChildByName("clip_" + i));
			}
			timer = new Timer(500, 1);
			timer.addEventListener(TimerEvent.TIMER, timer_timerHandler);
		}
		
		public function animateIn():void {
			TweenClips.animateInFrom(clips, .3, {y:String(10), alpha: 0, ease:Quint.easeOut}, 0, animateIn_completeHandler);
		}
		
		public function animateOut():void {
			TweenClips.animateOutTo(clips, .2, {y:String(-10), alpha: 0, ease:Quint.easeOut}, 0, animateOut_completeHandler);
		}
		
		public function animateIn_completeHandler():void {
			timer.start();
		}
		
		public function animateOut_completeHandler():void {
			dispatchEvent(new Event(NEXT));
		}
		
		public function reset():void {
			TweenClips.animateOutTo(clips, .1, {y:String(10), alpha: 1});
		}
		
		private function timer_timerHandler(event:TimerEvent):void {
			animateOut();
		}
		
	}
}