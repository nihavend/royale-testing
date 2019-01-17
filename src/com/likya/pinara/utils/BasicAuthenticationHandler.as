package com.likya.pinara.utils
{
	import com.adobe.fiber.services.wrapper.HTTPServiceWrapper;
	import com.likya.pinara.event.ResourceEvent;
	import com.likya.pinara.model.ModelLocator;
	import com.likya.pinara.model.User;
	
	//import flash.display.DisplayObject;
	//import flash.net.URLVariables;
	import mx.core.UIComponent;
	import mx.messaging.channels.URLVariables;
	
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.core.IFlexDisplayObject;
	import mx.managers.PopUpManager;
	import mx.resources.ResourceManager;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.mxml.HTTPService;
	import mx.utils.Base64Encoder;

	public class BasicAuthenticationHandler
	{
		public function BasicAuthenticationHandler()
		{
		}
		
		public static function authAndSend(service:HTTPService):void {
			var encoder:Base64Encoder = new Base64Encoder();
			COMPILE::SWF {
				encoder.insertNewLines = false; // see below for why you need to do this
			}
			var tmpUserInfo:User = ModelLocator.getInstance().currentUser;
			// encoder.encode("pinara:pinara");
			// encoder.encode(tmpUserInfo.username + ":" + tmpUserInfo.password);
			// tr şifre ve kullanıcı sorunu nedeni utf8 e geçtim
			encoder.encodeUTFBytes(tmpUserInfo.username + ":" + tmpUserInfo.password);

			
			service.headers = {Authorization:"Basic " + encoder.toString()} as Array;   
			
			service.request.data = new URLVariables("name=ifthisdataisnotpassedPOSTmethodisconvertedtoGETbyflashplayer");
			
			if(service.url.indexOf('?_method=GET') <= 0) {
				if(service.url.indexOf('?') > 0) { // Has url param var başına eklenecek
					var pairs:Array = service.url.split('?');
					if(pairs.length == 2) {
						service.url = pairs[0] + "?_method=GET" + "&" + pairs[1];
					} else {
						service.url = pairs[0] + "?_method=GET";
					}
				} else { // boş sona eklenecek
					service.url += "?_method=GET";
				}
			}
			
			service.send();
		}
		
		public static function authAndCall(service:HTTPServiceWrapper, operationName:String, parameter:String = null):mx.rpc.AsyncToken {
			
			var encoder:Base64Encoder = new Base64Encoder();
			COMPILE::SWF {
				encoder.insertNewLines = false;
			}
			//encoder.encode("pinara:pinara");
			var tmpUserInfo:User = ModelLocator.getInstance().currentUser;
			// encoder.encode(tmpUserInfo.username + ":" + tmpUserInfo.password);
			// tr şifre ve kullanıcı sorunu nedeni utf8 e geçtim
			encoder.encodeUTFBytes(tmpUserInfo.username + ":" + tmpUserInfo.password);

			
			service.operations[operationName].headers["Authorization"] = "Basic " + encoder.toString();
			
			if(service.operations[operationName].method == "GET") {
				service.operations[operationName].method = "POST";
				service.operations[operationName].contentType = "application/xml";
				if(service.operations[operationName].url.indexOf('?_method=GET') <= 0) {
					service.operations[operationName].url += "?_method=GET";
				}
			}
			
			if(parameter == null) {
				return service.operations[operationName].send();
			}
			
			return service.operations[operationName].send(parameter);
		}
		
		public static function service_faultHandler(event:FaultEvent):void {
			// Alert.show("xmlService_faultHandler : " + event.toString());
			//outputText.text += "\nxmlService_faultHandler " + event;
			// Alert.show(event.fault.faultString);
			/**
			 * Bazı durumlarda, buraya geldiginde her iki tarafta da sorun yok ise
			 * serverdan gelen xml de istenmeyen bir xml token vardır. 
			 * ex4 tipi content secildiğinde gelen mesaj parse edilemez ve
             * ve hata oluşur. Eğer hata olmasa bu metoda girmez. 
			 * Client da server da hatasız çalışıyor gibi gorunur
			 * hatayı bulmak cok zor olur. faultString i hafife alma.
			 */
			
			if(event.statusCode == 200) {
				Alert.show("Url : " + event.target.url + "\nHata Mesajı : " + event.fault.faultString + "\nResponse : " + event.message.body);
			} else if (event.statusCode == 400) {
				Alert.show(ResourceManager.getInstance().getString('messages', 'basicAuthPassOrUserError'));
			/*} else if (event.statusCode == 499) {
				Alert.show("Server state is not available, please relogin !");
				FlexGlobals.topLevelApplication.dispatchEvent(new ResourceEvent(ResourceEvent.UPDATE_TREE, null));
				FlexGlobals.topLevelApplication.dispatchEvent(new ResourceEvent(ResourceEvent.LOGOUT));*/
			} else if (event.statusCode == 0) {
				// Alert.show("Server is not available, check pls !");
				FlexGlobals.topLevelApplication.dispatchEvent(new ResourceEvent(ResourceEvent.SERVER_UNREADY_LOGOUT));
			} else {
				trace("Unexpected Event : " + event.toString());
				// Alert.show("Unexpected Event : " + event.toString());
				// Alert.show("Server state is not available, please relogin !");
			}
		}
		
		public static function service_resultHandler(refObject:UIComponent/*DisplayObject*/, event:ResultEvent):Boolean {
			
	/*		var returnXml:XML;
			var returnTxt:String = null;
			
			try {
				returnXml = XML(event.message.body);
				returnTxt = "" + returnXml;
				if(startsWith(returnTxt, "NOK : ")) {
					WindowUtils.showDummyWindow(refObject, returnTxt.substr(6));
				} 
				
			} catch(err:Error) {
				Alert.show("Result : " + err.message);
				returnTxt = String(event.result)
			}
			
			// Alert.show("Result : " + event.message.body);
			// trace(returnXml);
			
			 */
			
			var retValue:Boolean = false;
			
			var returnXml:XML;
			var returnTxt:String = null;
			
			// Alert.show("Result : " + event.message.body);
			
			try {
				// returnXml = XML(event.result);
				returnXml = XML(event.message.body);
				// Alert.show("Result : " + returnXml.toString());
				if(returnXml.result == "NOK") {
					// WindowUtils.showDummyWindow(refObject, returnXml.desc.toString());
				} else {
					PopUpManager.removePopUp(refObject as IFlexDisplayObject);
					retValue = true;
				}
			} catch(err:Error) {
				Alert.show("Result : " + err.message);
				returnTxt = String(event.result)
			}
			
			// Alert.show("Result : " + event.message.body);
			// trace(returnXml);
			
			return retValue;
		}
		
		public static function service_customHandler(refObject:UIComponent /*DisplayObject*/, event:ResultEvent, showWin:Boolean = false):Boolean {
			var returnXml:XML;
			var returnTxt:String = null;
			
			try {
				returnXml = XML(event.message.body);
				if(returnXml.result == "NOK") {
					if(showWin) {
						// WindowUtils.showDummyWindow(refObject, returnXml.desc.toString());
					}
					return false;
				} else {
					//PopUpManager.removePopUp(this);
				}
			} catch(err:Error) {
				Alert.show("Result : " + err.message);
				returnTxt = String(event.result)
					
				return false;
			}	
			
			return true;
		}
		
		public static function startsWith(haystack:String, needle:String):Boolean {
			return haystack.indexOf(needle) == 0;
		}
		
	}
}