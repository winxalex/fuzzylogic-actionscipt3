package winxalex.fuzzy 
{
	
	
	/**
	 * ...
	 * @author alex winx
	 */
	public class FuzzyManifold//FuzzySurface
	{
		public var name:String;
		public var memberfunctions:Array;
		public var maxRange:Number = Number.MIN_VALUE;
		public var minRange:Number = Number.MAX_VALUE;
		
		
		public var input:FuzzyInput;
		private var _output:Number ;
		
	    private var _fuzzificator:Fuzzificator = null;
		
		public function FuzzyManifold(name:String) 
		{
			this.name = name;
			memberfunctions = new Array();
		}
		
		public function getMaxDOM(input:Number):Number
		{
			//same principal as in fMax
		/*	func = FuzzyMembershipFunction( ifunc);						
								  func.maximumDOM = func.levelOfConfidence;
								   currentDOM = ifunc.calculateDOM(input);
									if (max < currentDOM) max = currentDOM;
									 func.reset();*/
	
		}
		
		
		public  function getSumDom(input:Number):Number
		{
			//same principal as in fSum
			
					/*func = FuzzyMembershipFunction( ifunc);
							    func.maximumDOM =  func.levelOfConfidence;
								sumDOMs += ifunc.calculateDOM(input);
								  func.reset();*/
		}
	
		
		public function addMember(func:FuzzyMembershipFunction):void
		{
			memberfunctions[func.linguisticTerm] = func;
			memberfunctions.length = memberfunctions.length + 1;
			
			if (func.leftMidPoint-func.leftOffset < minRange)
			minRange = func.leftMidPoint-func.leftOffset;
			
			if (func.rightMidPoint+func.rightOffset > maxRange)
			maxRange = func.rightMidPoint+func.rightOffset;
			
			trace("Membership function <" + func.linguisticTerm + "> added to manifold {" + this.name+"} range["+minRange+","+maxRange+"]");
			
		}
		
		
		
		
		internal function Fuzzify():void
		{
		
			if (memberfunctions.length > 0)
			{
				
				
				if (input.value<=maxRange && input.value>=minRange)
				{
								 
					  for each (var func:IFuzzyMembershipFunction in  this.memberfunctions)
					  {
						    func.reset();
							func.calculateDOM(input.value);
							trace(this.name,FuzzyMembershipFunction(func).linguisticTerm,FuzzyMembershipFunction(func).degreeOfMembership);
					  }
				}
				else
				throw new Error("value :"+input.value+" out of range");
			}
			else
			{
				throw new Error("no membership function involved in manifold <"+this.name+">");
			}
		}
		
		public function toString():String
		{
			var s:String="";
			 for each (var func:IFuzzyMembershipFunction in  this.memberfunctions)
					  {
						  
						  s += func.toString()+"\n";
							
					  }
					  
					  return s;
		}
		
		public function get output():Number { return _output; }
		
		public function set output(value:Number):void 
		{
			_output = value;
		}
		
	}

}