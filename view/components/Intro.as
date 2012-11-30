/**
 * @author Saad Shams :: sshams@live.com
 * Copy or reuse is prohibited.
 * */
package view.components {
	import com.greensock.TweenMax;
	import com.greensock.easing.Quint;
	import com.muizz.IAnimatable;
	import com.muizz.TweenClips;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.media.SoundTransform;
	import flash.utils.Timer;
	
	public class Intro extends MovieClip implements IAnimatable {
		
		public static const NEXT:String = "next";
		
		private const TOTAL_CLIPS:int = 3;
		private const TOTAL_BUTTONS:int = 1;
		
		private var clips:Vector.<MovieClip>;
		private var clips2:Vector.<MovieClip>;
		
		private var glowTimer:Timer;
		private var glowColor:Number = 0x0082c8;
		
		public function Intro() {
			clips = new Vector.<MovieClip>();
			clips2 = new Vector.<MovieClip>();
			
			glowTimer = new Timer(1500); 
			
			for(var i:int=0; i<TOTAL_CLIPS; i++){ //populating clips
				clips.push(this.getChildByName("clip_" + i));
			}
			clips.push(this.getChildByName("clip2_0"));//button
			
			for(var j:int=0; j<TOTAL_BUTTONS; j++){//populating buttons
				clips2.push(this.getChildByName("clip2_" + j));
				clips2[j].buttonMode = true;
			}
			
			clips2[0].addEventListener(MouseEvent.MOUSE_DOWN, start_mouseDownHandler); //start button
			glowTimer.addEventListener(TimerEvent.TIMER, timer_timerHandler); //continous glowing effect
		}
		
		public function animateIn():void { //animate all clips in
			TweenClips.animateInFrom(clips, .4, {y:String(10), alpha: 0, ease:Quint.easeOut}, 0, animateIn_completeHandler);
			glowTimer.start();
		}
		
		public function animateIn_completeHandler():void {
		}
		
		public function animateOut():void {
			TweenClips.animateOutTo(clips, .2, {y:String(-10), alpha: 0, ease:Quint.easeOut}, 0, animateOut_completeHandler);
		}
		
		public function animateOut_completeHandler():void { //revert original settings
			glowTimer.stop();
			dispatchEvent(new Event(NEXT, true));
		}
		
		public function reset():void {
			TweenClips.animateOutTo(clips, .1, {y:String(10), alpha: 1});
		}
		
		private function start_mouseDownHandler(event:MouseEvent):void {
			new Click().play(0, 1, new SoundTransform(0.5));
			animateOut();
		}
		
		private function timer_timerHandler(event:TimerEvent):void { //glowHandler function
			TweenClips.animateGlow(clips2, 1.5, {glowFilter:{color:glowColor, blurX:20, blurY:20, strength:1, alpha:1}}, {glowFilter:{color:glowColor, blurX:5, blurY:5, strength:1, alpha:1}});
		}
		
	}
}