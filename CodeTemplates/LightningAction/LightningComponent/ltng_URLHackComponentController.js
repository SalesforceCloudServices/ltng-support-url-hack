/**
 * Controller for the Component.
 * 
 * <p>No changes needed here (unless desired). Change needed on ...Helper.js</p>
 */
({
	/**
	 * Initialization method
	 */
	init : function(component, event, helper) {
		//-- please note: we are only retrieving the base info in this example.
		//-- if we want to retrieve more data, then we would need other means.

		var recordTypeId = component.get("v.recordId");

		//-- get the default values
		var action = component.get("c.getUrlHackDefaultValues");
		action.setParams({
			"baseRecordId": recordTypeId
		});
		action.setCallback(this, function(response){
			var state = response.getState();
			if( state !== "SUCCESS" ){
				console.error("error occurred");
				debugger;
				return;
			}

			var resultValue = response.getReturnValue();

			helper.handleDefaultValues(resultValue, component, helper);
		});
		$A.enqueueAction(action);
	}
})