({
	/**
	 * Initializes all values to the beginning.
	 */
	reset : function(component, helper) {
		component.set("v.isRunningSetup", false);
	},

	/**
	 * Runs the setup
	 * @param getInfoOnly (boolean) - whether to only get description of the steps to run (not run them) - true - or to actually run them - false.
	 */
	runSetup : function(getInfoOnly, component, helper){
		var action = component.get("c.runSetup");
		action.setParams({
			'getInfoOnly': getInfoOnly
		});
		action.setCallback(this, function(response){
			var state = response.getState();
			if(state !== "SUCCESS"){
				console.error('error occurred while running setup');
				debugger;
				return;
			}

			var results = response.getReturnValue();
			component.set("v.completionSteps", results);
		})
		$A.enqueueAction(action);
	}
})