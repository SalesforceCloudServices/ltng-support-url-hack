({
	init : function(component, event, helper) {
		helper.reset(component, helper);
		helper.calcIconName(component, helper);
		helper.calcTimeLineClass(component, helper);
	},

	/**
	 * Handle expansion toggle was clicked
	 */
	handleExpansionToggle : function(component, event, helper){
		console.log("expansion toggle clicked");
		helper.toggleExpansion(component, helper);
	}
})