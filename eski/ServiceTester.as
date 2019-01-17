package main
{
	import com.adobe.fiber.core.model_internal.model_internal;
	import com.adobe.fiber.services.wrapper.FindBugModule;
	
	
	public class ServiceTester extends FindBugModule
	{
		public function ServiceTester()
		{
			super();
			model_internal::initialize();
		}
	}
}