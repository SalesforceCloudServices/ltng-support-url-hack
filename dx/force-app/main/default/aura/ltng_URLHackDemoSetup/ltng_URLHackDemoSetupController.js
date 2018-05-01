({
	init : function(component, event, helper) {
		console.info('initialize setup');
		helper.reset(component, helper);

		helper.runSetup(true, component, helper);
	},

	/**
	 * Handle when the setup button is clicked
	 */
	handleSetupClicked : function(component, event, helper){
		helper.runSetup(false, component, helper);
	},

	/**
	 * Open the permission set page
	 */
	handlePermissionSetOpen : function(component, event, helper){
		console.info('open permission set');
		var address = '/one/one.app#/setup/PermSets/home';
		var action = $A.get('e.force:navigateToURL');
		action.setParams({
			'url': address
		});
		action.fire();
	}
})