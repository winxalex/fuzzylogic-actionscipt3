package winxalex.fuzzy
{
	import flash.display.Graphics;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author alex winx
	 */
	public class FuzzyMembershipFunction implements IFuzzyMembershipFunction
	{
		public static const TRIANGLE:uint = 0;
		public static const LEFT_SHOULDER:uint = 1;
		public static const RIGHT_SHOULDER:uint = 2;
		public static const TRAPEZOID:uint = 3;
		/*public static const INV_TRAPEZOID:uint = 2;
		   public static const RIGHT_TRAPEZOID:uint = 2;
		   public static const INV_C_TRAPEZOID:uint = 3;
		 public static const LEFT_TRAPEZOID:uint = 4;*/
		
		public var linguisticTerm:String;
		
		private var _typeName:String;
		
		public var rightPoint:Point;
		private var _rightPeekPoint:Point;
		public var rightOffset:Number;
		
		public var leftPoint:Point;
		private var _leftPeekPoint:Point;
		public var leftOffset:Number;
		
		public var isScaled:Boolean = false;
		
		public var origRightDomain:Number;
		public var origLeftOffset:Number;
		public var origRightOffset:Number;
		public var origLeftDomain:Number;
		
		public var isLOCReseted:Boolean = false;
		public var areBoundariesDIRTY:Boolean = false;
		
		//domain value at the middle of function range
		private var _averageDomain:Number = NaN;
		
		private var _maximumDomain:Number = NaN;
		
		private var _conture:Vector.<Point> = null;
		/**
		 * level of confidence (firing strenght)
		 */
		private var _levelOfConfidence:Number = 1;
		private var _degreeOfMembership:Number = 0;
		
		public function FuzzyMembershipFunction(linguisticTerm:String, typeName:String, leftDomain:Number = NaN, leftPeekDomain:Number = NaN, rightPeekDomain:Number = NaN, rightDomain:Number = NaN, ... args):void
		{
			this.linguisticTerm = linguisticTerm;
			this._typeName = typeName;
			
			origRightDomain = rightPeekDomain;
			origRightOffset = rightDomain - rightPeekDomain;
			origLeftOffset = leftPeekDomain - leftDomain;
			origLeftDomain = leftPeekDomain;
			
			this.leftPoint = new Point();
			this.leftPoint.x = leftDomain;
			
			this.rightPoint = new Point();
			this.rightPoint.x = rightDomain;
			
			_rightPeekPoint = new Point(rightPeekDomain, 1)
			leftPeekPoint = new Point(leftPeekDomain, 1)
			
			_maximumDomain = origRightDomain;
			
			this.rightOffset = origRightOffset;
			this.leftOffset = origLeftOffset;
			
			if (origRightDomain != origLeftDomain)
				_averageDomain = origLeftDomain + (origRightDomain - origLeftDomain) * 0.5
			else
				_averageDomain = origLeftDomain;
		
			//this.recalcBoundaries();
		
		}
		
		public function get degreeOfMembership():Number
		{
			return _degreeOfMembership;
		}
		
		public function set degreeOfMembership(value:Number):void
		{
			_degreeOfMembership = value;
			
			
			/*if (value == 1)
			{
				//restoring orginal settings
					FuzzyMembershipFunction(this).recalcBoundaries();
				return;
			}*/
		}
		
		public function get levelOfConfidence():Number
		{
			return _levelOfConfidence;
		}
		
		public function set levelOfConfidence(value:Number):void
		{
			
			_levelOfConfidence = value;
			
			
			areBoundariesDIRTY = true;
		}
		
		public function get averageDomain():Number
		{
			return _averageDomain;
		}
		
		public function set averageDomain(value:Number):void
		{
			_averageDomain = value;
		}
		
		/**
		 * maximum X value on which member function has value = 1
		 */
		public function get maximumDomain():Number
		{
			return _maximumDomain;
		}
		
		public function set maximumDomain(value:Number):void
		{
			_maximumDomain = value;
		}
		
		public function get typeName():String
		{
			return _typeName;
		}
		
		public function get rightPeekPoint():Point
		{
			if (areBoundariesDIRTY)
			{
				recalcBoundaries();
			}
			return _rightPeekPoint;
		}
		
		public function get leftPeekPoint():Point
		{
			if (areBoundariesDIRTY)
				recalcBoundaries();
			return _leftPeekPoint;
		}
		
		public function set leftPeekPoint(value:Point):void
		{
			_leftPeekPoint = value;
		}
		
		public function reset():void
		{
			
			areBoundariesDIRTY = false;
			
			_levelOfConfidence = 1;
			_degreeOfMembership = 0;
			
			isScaled = false;
			
			isLOCReseted = false;
		
		    this.rightPeekPoint.x = origRightDomain;
			this.rightPeekPoint.y = 1;
			
			this.leftPeekPoint.x = origLeftDomain;
			this.leftPeekPoint.y = 1;
			
			this.rightOffset = origRightOffset;
			this.leftOffset = origLeftOffset;
			
			if (origRightDomain != origLeftDomain)
				_averageDomain = origLeftDomain + (origRightDomain - origLeftDomain) * 0.5
			else
				_averageDomain = origLeftDomain;
		
		}
		
		public function calculateDOM(value:Number):Number
		{
			
			/*if (areBoundariesDIRTY)
			   {
			   recalcBoundaries();
			 }*/
			
			return 0;
		}
		
		public function fillArea(container:Graphics, scaleX:uint = 1, scaleY:uint = 50):void
		{
			throw new Error("Should be overrided");
		}
		
		public function draw(container:Graphics, scaleX:uint = 1, scaleY:uint = 50):void
		{
			throw new Error("Should be overrided");
		}
		
		public function recalcBoundaries():void
		{
			
			
		}
		
		public function toString():String
		{
			
			var s:String = "linguisticTerm=" + linguisticTerm + " DOM:" + _degreeOfMembership + " LOC=" + _levelOfConfidence + " leftPoint=" + leftPoint + " leftMidPoint=" + leftPeekPoint + " rightMidPoint=" + rightPeekPoint + " rightPoint=" + rightPoint + " >OFFSETS: rightOffset:" + rightOffset + " leftOffset:" + leftOffset;
			return s;
		}
	
	}

}