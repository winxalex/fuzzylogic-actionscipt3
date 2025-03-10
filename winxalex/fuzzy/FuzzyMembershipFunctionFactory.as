package winxalex.fuzzy 
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
    import flash.utils.getQualifiedSuperclassName;

	
	/**
	 * ...
	 * @author alex winx
	 */
	public class FuzzyMembershipFunctionFactory implements IFuzzyMembershipFunctionFactory
	{
		//private static var product:IFuzzyMembershipFunction;
		//private static var dispatcher:EventDispatcher = new EventDispatcher();
	     private static var _instance:FuzzyMembershipFunctionFactory = new FuzzyMembershipFunctionFactory();
         private static var _className:String = getQualifiedClassName(super);

		private static var funcDictionary:Vector.<Function> = FuzzyMembershipFunctionFactory.init();
		
		public function FuzzyMembershipFunctionFactory():void
		{
			if (_instance != null && getQualifiedSuperclassName(this) != _className) throw new Error("Factory is Singleton. Use FuzzyMembershipFunctionFactory.getInstance()");
		}
		
		public function create(funcType:uint,...args):FuzzyMembershipFunction
		{
			var parms:Array;
			//version 1 dispatcher.dispatchEvent(new MembershipFunctionCreateEvent(funcType,afgs...)
			//version 2 using signal
			
			if (args.length == 2)
				if (args[1] is Array) 
				{
					parms = args.pop();
					args = args.concat(parms);
				}
				else 
				{
					throw new Error("create function accepts Array,String with separator, or 4 params");
				}
			
			if (args.length == 3 && args[1] is String)
			{
				var delimiter:String=args.pop();
				parms = String(args.pop()).split(delimiter);
				
				args = args.concat(parms);
			}
			
			
			//version 3
			return funcDictionary[funcType].apply(FuzzyMembershipFunctionFactory, args);
		}
		
		public static function getInstance():FuzzyMembershipFunctionFactory
		{
			return _instance;
		}
		
		private static function createTriangleFunction(...args):IFuzzyMembershipFunction
		{
			return new FuzzyTrapezoidMembershipFunction(args[0],"TRIANGLE", args[1], args[2], args[2],args[3]);
		}
		
		private static function createTrapezoidFunction(...args):IFuzzyMembershipFunction
		{
			return new FuzzyTrapezoidMembershipFunction(args[0],"TRAPEZOID", args[1], args[2], args[3],args[4]);
		}
		
		private static function createInvTrapezoidFunction(...args):IFuzzyMembershipFunction
		{
			return new FuzzyTrapezoidMembershipFunction(args[0], args[1], args[2], args[3],args[4]);
		}
		
		private static function createLeftShoulderFunction(...args):IFuzzyMembershipFunction
		{
			
			 return new FuzzyTrapezoidMembershipFunction(args[0],"LEFT_SHOULDER", 0,args[1], args[2], args[3]);
		}
		
		private static function createRightShoulderFunction(...args):IFuzzyMembershipFunction
		{
			//return new FuzzyRightShoulderMembershipFunction(args[0], args[1], args[2], args[3]);
			return new FuzzyTrapezoidMembershipFunction(args[0],"RIGHT_SHOULDER", args[1], args[2],args[3],args[3]);
		}
		
		private static function createQuadricFunction():IFuzzyMembershipFunction
		{
			throw new Error("Not yet Implemented");
			return null;
		}
		
		
		
		private static function init():Vector.<Function>
		{
			var vect:Vector.<Function> = new Vector.<Function>;
			vect[FuzzyMembershipFunction.TRIANGLE] = createTriangleFunction;
			vect[FuzzyMembershipFunction.LEFT_SHOULDER] = createLeftShoulderFunction;
			vect[FuzzyMembershipFunction.RIGHT_SHOULDER] = createRightShoulderFunction;
			vect[FuzzyMembershipFunction.TRAPEZOID] = createTrapezoidFunction;
			//vect[FuzzyMembershipFunction.QUADRIC] = createQuadricFunction;
			return vect;
		}
		
		public static function add(name:String,funct:Function):void
		{
			funcDictionary[name] = funct;
		}
	}

}