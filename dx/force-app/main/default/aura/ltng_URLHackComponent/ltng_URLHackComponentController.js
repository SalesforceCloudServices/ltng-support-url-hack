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

			console.info("success");
			debugger;

			var resultValue = response.getReturnValue();

			helper.handleDefaultValues(resultValue, component, helper);
		});
		$A.enqueueAction(action);
	},

	/**
	 * Handles when the lightning data service notices a change
	 * (can be one handler for all data, or a similar one for each)
	 */
	baseInfoUpdated : function(component, event, helper){
		var changeType = event.getParams().changeType;
		debugger;

		if( changeType === "ERROR" ){
			helper.displayError('Error occurred while loading data', component, event, helper);
			debugger;
		} else if( changeType === "LOADED" ){
			console.info( "record loaded" );
			//helper.checkAllDataLoaded(component, event, helper);
		} else {
			console.info( "Lightning Data Service noticed a change:" + changeType );
		}
	}
})